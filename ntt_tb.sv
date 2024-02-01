
class NTTClass;

    rand logic [63:0] x;

    function xData();
        return x;
    endfunction

endclass

module ntt_tb();

    logic [63:0] x [0:63];
    logic [7:0] w [0:63];
    logic clk, rst;

    int i;

    ntt UUT (.x(x), .w(w), .clk(clk), .rst(rst));

    always begin
        #5;
        clk = ~clk;
    end
    
    NTTClass cls = new();

    initial begin
        for(i = 0; i < 64; i++) begin
            cls.randomize();
            x[i] = cls.xData();
        end
        clk = 1'b0;
        #400;
    end

endmodule

