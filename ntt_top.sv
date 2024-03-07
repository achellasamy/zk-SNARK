
module ntt_top();

    logic clk, rst, done;
    logic [9:0]BRAM_PORTB_0_addr;
    logic BRAM_PORTB_0_clk;
    logic [63:0]BRAM_PORTB_0_din;
    logic [63:0]BRAM_PORTB_0_dout;
    logic BRAM_PORTB_0_en;
    logic [0:0]BRAM_PORTB_0_we;
    logic [12:0]BRAM_PORTB_1_addr;
    logic BRAM_PORTB_1_clk;
    logic [31:0]BRAM_PORTB_1_dout;
    logic BRAM_PORTB_1_en;

    ntt_bram_dual ntt_bram_dual_i (.clk(clk),
                                   .rst(rst),
                                   .BRAM_addr_0(BRAM_PORTB_0_addr),
                                   .BRAM_clk_0(BRAM_PORTB_0_clk),
                                   .BRAM_din_0(BRAM_PORTB_0_din),
                                   .BRAM_dout_0(BRAM_PORTB_0_dout),
                                   .BRAM_we_0(BRAM_PORTB_0_we),
                                   .BRAM_en_0(BRAM_PORTB_0_en),
                                   .BRAM_addr_1(BRAM_PORTB_1_addr),
                                   .BRAM_clk_1(BRAM_PORTB_1_clk),
                                   .BRAM_dout_1(BRAM_PORTB_1_dout),
                                   .BRAM_en_1(BRAM_PORTB_1_en),
                                   .ntt_done(done));

    NTT_wrapper_wrapper ntt_wrapper_wrapper_i (.BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
                                               .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
                                               .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
                                               .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
                                               .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
                                               .BRAM_PORTB_0_we(BRAM_PORTB_0_we),
                                               .BRAM_PORTB_1_addr(BRAM_PORTB_1_addr),
                                               .BRAM_PORTB_1_clk(BRAM_PORTB_1_clk),
                                               .BRAM_PORTB_1_dout(BRAM_PORTB_1_dout),
                                               .BRAM_PORTB_1_en(BRAM_PORTB_1_en),
                                               .pl_clk0(clk),
                                               .zynq_ntt_done(done),
                                               .zynq_ntt_rst(rst));

endmodule
