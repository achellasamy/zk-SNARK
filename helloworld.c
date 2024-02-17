/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "xbram.h"
#include "sleep.h"


int main()
{
    init_platform();

    XBram Bram;

    XBram_Config *ConfigPtr;

    int Status;

    ConfigPtr = XBram_LookupConfig(XPAR_BRAM_0_DEVICE_ID);
	if (ConfigPtr == (XBram_Config *) NULL) {
		return XST_FAILURE;
	}

	Status = XBram_CfgInitialize(&Bram, ConfigPtr, ConfigPtr->CtrlBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

    xil_printf("----------Start NTT Accelerator Test----------\n\r");
    xil_printf("\r\n\rInput Polynomial:\n\r");

    for (int i = 0; i < 64*4; i=i+4){
    	XBram_WriteReg(XPAR_BRAM_0_DEVICE_ID,i,i);
    	xil_printf("x[%d] @ mem[%x] --> 0x%x\n\r", i/4, i, i);

    }

    xil_printf("\r\n\rOutput Polynomial:\n\r");

    uint64_t out_data;
    sleep(15);

    int address = 256;

    for (int i = 0; i < 64*4; i=i+4){
    	out_data = XBram_ReadReg(XPAR_BRAM_0_DEVICE_ID, address);
		xil_printf("y[%d] @ mem[%x] --> 0x%x\n\r", i/4, address, out_data);
		address = address + 4;
    }

    xil_printf("----------End NTT Accelerator Test----------\n\r");

    cleanup_platform();
    return 0;
}
