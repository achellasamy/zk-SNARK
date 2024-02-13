
module ntt_top();

    logic clk, rst;
    logic [12:0] BRAM_addr;
    logic BRAM_clk;
    logic [63:0] BRAM_din;
    logic [63:0] BRAM_dout;
    logic BRAM_en;
    logic BRAM_rst;
    logic BRAM_we;

    ntt_bram ntt_bram_i
        (
            .clk(clk),
            .rst(rst),
            .BRAM_addr(BRAM_addr),
            .BRAM_clk(BRAM_clk),
            .BRAM_din(BRAM_din),
            .BRAM_dout(BRAM_dout),
            .BRAM_en(BRAM_en),
            .BRAM_rst(BRAM_rst),
            .BRAM_we(BRAM_we)
        );

    NTT_wrapper_wrapper ntt_wrapper_wrapper_i
        (
            .BRAM_PORTB_0_addr(BRAM_addr),
            .BRAM_PORTB_0_clk(BRAM_clk),
            .BRAM_PORTB_0_din(BRAM_din),
            .BRAM_PORTB_0_dout(BRAM_dout),
            .BRAM_PORTB_0_en(BRAM_en),
            .BRAM_PORTB_0_rst(BRAM_rst),
            .BRAM_PORTB_0_we(BRAM_we),
            .peripheral_aresetn(rstn),
            .pl_clk0(clk)
        );

endmodule
