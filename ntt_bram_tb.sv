
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

    //Input to BRAM1 containing input omega values
    logic [12:0]BRAM_addr_1;
    logic BRAM_clk_1;
    logic [7:0]BRAM_din_1;
    logic BRAM_en_1;
    logic [0:0]BRAM_we_1;

    //Output from BRAM0 containing input polynomial
    logic [9:0]BRAM_PORTB_0_addr;
    logic BRAM_PORTB_0_clk;
    logic [63:0]BRAM_PORTB_0_din;
    logic [63:0]BRAM_PORTB_0_dout;
    logic BRAM_PORTB_0_en;
    logic [0:0]BRAM_PORTB_0_we;

    //Output from BRAM1 containing omega values
    logic [12:0]BRAM_PORTB_1_addr;
    logic BRAM_PORTB_1_clk;
    logic [7:0]BRAM_PORTB_1_dout;
    logic BRAM_PORTB_1_en;
    
    int address;

    logic [63:0] y [0:63];

    ntt_bram_class cls = new();

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
                                   .BRAM_en_1(BRAM_PORTB_1_en));

    BRAM_test_wrapper BRAM_test_wrapper_i (.BRAM_PORTA_0_addr(BRAM_addr_0),
                                           .BRAM_PORTA_0_clk(clk),
                                           .BRAM_PORTA_0_din(BRAM_din_0),
                                           .BRAM_PORTA_0_dout(BRAM_dout_0),
                                           .BRAM_PORTA_0_en(BRAM_en_0),
                                           .BRAM_PORTA_0_we(BRAM_we_0),
                                           .BRAM_PORTA_1_addr(BRAM_addr_1),
                                           .BRAM_PORTA_1_clk(clk),
                                           .BRAM_PORTA_1_din(BRAM_din_1),
                                           .BRAM_PORTA_1_en(BRAM_en_1),
                                           .BRAM_PORTA_1_we(BRAM_we_1),
                                           .BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
                                           .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
                                           .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
                                           .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
                                           .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
                                           .BRAM_PORTB_0_we(BRAM_PORTB_0_we),
                                           .BRAM_PORTB_1_addr(BRAM_PORTB_1_addr),
                                           .BRAM_PORTB_1_clk(BRAM_PORTB_1_clk),
                                           .BRAM_PORTB_1_dout(BRAM_PORTB_1_dout),
                                           .BRAM_PORTB_1_en(BRAM_PORTB_1_en));

    always begin
        clk = ~clk;
        #5;
    end

    initial begin
        $display("-----Begin NTT_BRAM Test-----");
        rst = 1'b1;
        clk = 1'b0;
        BRAM_en_0 = 1'b1;
        BRAM_en_1 = 1'b1;

        #20;
        fork
            fillBRAM0();
            fillBRAM1();
        join
        #20;
        rst = 1'b0;
        #800;
        
        $finish;
    end

    task fillBRAM0();
        BRAM_we_0 = 1'b1;
        #5
        for(int i = 0; i < 64*4; i=i+4) begin
            BRAM_addr_0 = i;
            cls.randomize();
            BRAM_din_0 = cls.xData();
            #20;
        end
        BRAM_we_0 = 1'b0;
    endtask

    task fillBRAM1();
        BRAM_we_1 = 1'b1;
        address = 0;
        #5
        for(int i = 0; i < 64; i++) begin
            for(int j = 0; j < 64; j++) begin
                BRAM_addr_1 = address;
                BRAM_din_1 = cls.wOmega(i, j);
                address = address + 4;
                #20;
            end
        end
        BRAM_we_1 = 1'b0;
    endtask

endmodule


