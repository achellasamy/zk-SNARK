//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Mon Mar  4 10:47:13 2024
//Host        : zksnark-Precision-Tower-5810 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target NTT_wrapper_wrapper.bd
//Design      : NTT_wrapper_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module NTT_wrapper_wrapper
   (BRAM_PORTB_0_addr,
    BRAM_PORTB_0_clk,
    BRAM_PORTB_0_din,
    BRAM_PORTB_0_dout,
    BRAM_PORTB_0_en,
    BRAM_PORTB_0_rst,
    BRAM_PORTB_0_we,
    pl_clk0,
    zynq_ntt_done,
    zynq_ntt_rst);
  input [31:0]BRAM_PORTB_0_addr;
  input BRAM_PORTB_0_clk;
  input [31:0]BRAM_PORTB_0_din;
  output [31:0]BRAM_PORTB_0_dout;
  input BRAM_PORTB_0_en;
  input BRAM_PORTB_0_rst;
  input [3:0]BRAM_PORTB_0_we;
  output pl_clk0;
  input [0:0]zynq_ntt_done;
  output [0:0]zynq_ntt_rst;

  wire [31:0]BRAM_PORTB_0_addr;
  wire BRAM_PORTB_0_clk;
  wire [31:0]BRAM_PORTB_0_din;
  wire [31:0]BRAM_PORTB_0_dout;
  wire BRAM_PORTB_0_en;
  wire BRAM_PORTB_0_rst;
  wire [3:0]BRAM_PORTB_0_we;
  wire pl_clk0;
  wire [0:0]zynq_ntt_done;
  wire [0:0]zynq_ntt_rst;

  NTT_wrapper NTT_wrapper_i
       (.BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
        .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
        .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
        .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
        .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
        .BRAM_PORTB_0_rst(BRAM_PORTB_0_rst),
        .BRAM_PORTB_0_we(BRAM_PORTB_0_we),
        .pl_clk0(pl_clk0),
        .zynq_ntt_done(zynq_ntt_done),
        .zynq_ntt_rst(zynq_ntt_rst));
endmodule
