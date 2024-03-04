
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
    
    int address;

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
        BRAM_en = 1'b1;

        #20;
        fillBRAM();
        #20;
        rst = 1'b0;
        #800;
        
        $finish;
    end

    task fillBRAM();
        BRAM_we = 1'b1;
        address = 64;
        #5
        for(int i = 0; i < 64; i++) begin
            BRAM_addr = i;
            cls.randomize();
            BRAM_din = cls.xData();
            #20;
        end
        for(int i = 0; i < 64; i++) begin
            for(int j = 0; j < 64; j++) begin
                BRAM_addr = address;
                BRAM_din = cls.wOmega(i, j);
                address = address + 1;
                #20;
            end
        end
        BRAM_we = 1'b0;
    endtask



endmodule


