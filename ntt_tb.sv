
class NTTClass;

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

    function printData(input [63:0] data [0:63], input t);
        int i;
        if(t) begin
            for(i = 0; i < 64; i++) begin
                $display("x[%d] --> 0x%h", i, data[i]);
            end
        end
        else begin
            for(i = 0; i < 64; i++) begin
                $display("y[%d] --> 0x%h", i, data[i]);
            end
        end
    endfunction

endclass

module ntt_tb();

    logic [63:0] x [0:63];
    logic [63:0] y [0:63];
    logic [7:0] w [0:63][0:63];
    logic clk, rst;

    int i, j;

    ntt UUT (.x(x), .w(w), .clk(clk), .rst(rst), .y(y));
    
    NTTClass cls = new();
    
    always begin
        #5;
        clk = ~clk;
    end
    
    initial begin
        $display("-------Start Test-------");
        for(i = 0; i < 64; i++) begin
            cls.randomize();
            x[i] = cls.xData();
            for(j = 0; j < 64; j++) begin
                w[i][j] = cls.wOmega(i, j);
            end
        end
        cls.printData(x, 1'b1);
        clk = 1'b0;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        #10;
        $display("------------------------");
        #2000;
        cls.printData(y, 1'b0);
        $finish;
    end

endmodule

