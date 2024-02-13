//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Fri Feb  9 14:32:48 2024
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
    BRAM_PORTB_0_we,
    peripheral_aresetn,
    pl_clk0);
  input [12:0]BRAM_PORTB_0_addr;
  input BRAM_PORTB_0_clk;
  input [63:0]BRAM_PORTB_0_din;
  output [63:0]BRAM_PORTB_0_dout;
  input BRAM_PORTB_0_en;
  input [0:0]BRAM_PORTB_0_we;
  output [0:0]peripheral_aresetn;
  output pl_clk0;

  wire [12:0]BRAM_PORTB_0_addr;
  wire BRAM_PORTB_0_clk;
  wire [63:0]BRAM_PORTB_0_din;
  wire [63:0]BRAM_PORTB_0_dout;
  wire BRAM_PORTB_0_en;
  wire [0:0]BRAM_PORTB_0_we;
  wire [0:0]peripheral_aresetn;
  wire pl_clk0;

  NTT_wrapper NTT_wrapper_i
       (.BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
        .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
        .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
        .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
        .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
        .BRAM_PORTB_0_we(BRAM_PORTB_0_we),
        .peripheral_aresetn(peripheral_aresetn),
        .pl_clk0(pl_clk0));
endmodule