
class ntt_bram_class;

    rand logic [63:0] x;

    constraint range  { 0 <= x <= 64'hffffffff00000000; }

    function logic [7:0] wOmega(input int i, input int j);
        logic [7:0] w;
        w = (i*j) % 64'hffffffff00000001;
        return w;
    endfunction
                       
    function logic [63:0] xData();
        return x;
    endfunction

endclass

module ntt_bram_tb();

    logic clk;
    logic rst;

    //Input to BRAM0 containing input polynomial
    logic [9:0] BRAM_addr_0;
    logic BRAM_clk_0;
    logic [63:0] BRAM_din_0;
    logic [63:0] BRAM_dout_0;
    logic BRAM_en_0;
    logic BRAM_we_0;

    //Output from BRAM0 containing input polynomial
    logic [9:0]BRAM_PORTB_0_addr;
    logic BRAM_PORTB_0_clk;
    logic [63:0]BRAM_PORTB_0_din;
    logic [63:0]BRAM_PORTB_0_dout;
    logic BRAM_PORTB_0_en;
    logic [0:0]BRAM_PORTB_0_we;
    
    int address;

    logic [63:0] y [0:63];

    ntt_bram_class cls = new();

    ntt_bram_fixed ntt_bram_fixed_i (.clk(clk),
                                   .rst(rst),
                                   .BRAM_addr_0(BRAM_PORTB_0_addr),
                                   .BRAM_clk_0(BRAM_PORTB_0_clk),
                                   .BRAM_din_0(BRAM_PORTB_0_din),
                                   .BRAM_dout_0(BRAM_PORTB_0_dout),
                                   .BRAM_we_0(BRAM_PORTB_0_we),
                                   .BRAM_en_0(BRAM_PORTB_0_en));

    BRAM_test_wrapper BRAM_test_wrapper_i (.BRAM_PORTA_0_addr(BRAM_addr_0),
                                           .BRAM_PORTA_0_clk(clk),
                                           .BRAM_PORTA_0_din(BRAM_din_0),
                                           .BRAM_PORTA_0_dout(BRAM_dout_0),
                                           .BRAM_PORTA_0_en(BRAM_en_0),
                                           .BRAM_PORTA_0_we(BRAM_we_0),
                                           .BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
                                           .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
                                           .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
                                           .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
                                           .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
                                           .BRAM_PORTB_0_we(BRAM_PORTB_0_we));

    always begin
        clk = ~clk;
        #5;
    end

    initial begin
        $display("-----Begin NTT_BRAM Test-----");
        rst = 1'b1;
        clk = 1'b0;
        BRAM_en_0 = 1'b1;

        #20;
        fork
            fillBRAM0();
        join
        #20;
        rst = 1'b0;
        #5800;

        readBRAM();
        
        $finish;
    end

    task readBRAM();
        BRAM_we_0 = 1'b0;
        for(int i = 64*4; i < 128*4; i=i+4) begin
            BRAM_addr_0 = i;
            #20;
            y[(i/4)-64] = BRAM_dout_0;
        end
    endtask

    task fillBRAM0();
        BRAM_we_0 = 1'b1;
        #5
        for(int i = 0; i < 64*4; i=i+4) begin
            BRAM_addr_0 = i;
            cls.randomize();
            BRAM_din_0 = i;
            #20;
        end
        BRAM_we_0 = 1'b0;
    endtask

endmodule


