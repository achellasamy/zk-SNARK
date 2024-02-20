
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
    logic [12:0] BRAM_addr;
    logic BRAM_clk;
    logic [63:0] BRAM_din;
    logic [63:0] BRAM_dout;
    logic BRAM_en;
    logic BRAM_we;

    logic [12:0]BRAM_PORTB_0_addr;
    logic BRAM_PORTB_0_clk;
    logic [63:0]BRAM_PORTB_0_din;
    logic [63:0]BRAM_PORTB_0_dout;
    logic BRAM_PORTB_0_en;
    logic [0:0]BRAM_PORTB_0_we;

    logic [63:0] y [0:63];

    ntt_bram_class cls = new();

    ntt_bram ntt_bram_i (.clk(clk),
                         .rst(rst),
                         .BRAM_addr(BRAM_PORTB_0_addr),
                         .BRAM_clk(BRAM_PORTB_0_clk),
                         .BRAM_din(BRAM_PORTB_0_din),
                         .BRAM_dout(BRAM_PORTB_0_dout),
                         .BRAM_we(BRAM_PORTB_0_we),
                         .BRAM_en(BRAM_PORTB_0_en));
                         
    BRAM_test_wrapper BRAM_test_wrapper_i (.BRAM_PORTA_0_addr(BRAM_addr),
                                           .BRAM_PORTA_0_clk(clk),
                                           .BRAM_PORTA_0_din(BRAM_din),
                                           .BRAM_PORTA_0_dout(BRAM_dout),
                                           .BRAM_PORTA_0_en(BRAM_en),
                                           .BRAM_PORTA_0_we(BRAM_we),
                                           .BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
                                           .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
                                           .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
                                           .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
                                           .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
                                           .BRAM_PORTB_0_we(BRAM_PORTB_0_we));

    always begin
        clk = ~clk;
        BRAM_clk = clk;
        #5;
    end

    initial begin
        $display("-----Begin NTT_BRAM Test-----");
        rst = 1'b1;
        clk = 1'b0;

        #10;
        BRAM_en = 1'b1;
        fillBRAM();
        readBRAM();
        #10;
        
        $finish;
    end

    task fillBRAM();
        BRAM_we = 1'b1;
        #5
        for(int i = 0; i < 64; i++) begin
            BRAM_addr = i << 2;
            cls.randomize();
            BRAM_din = cls.xData();
            #10;
        end
        BRAM_we = 1'b0;
    endtask

    task readBRAM();
        #10;
        for(int i = 0; i < 64; i++) begin
            BRAM_addr = i << 2;
            $display("BRAM[%d] --> %h", i << 2, BRAM_dout);
            #10;
        end
    endtask



endmodule


