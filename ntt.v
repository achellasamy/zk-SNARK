
module ntt(x, w, clk, rst);

    input [63:0] x [0:63];
    input [7:0] w [0:63];
    input clk, rst;

    wire [63:0] wout [0:63];
    reg [63:0] dataOut [0:63];

    integer count;
    integer j;

    genvar i;

    generate
        for(i = 0; i < 63; i = i + 1) begin
            rowcalc rc (.clk(clk), .a(x[i]), .w(w[i]), .out(wout[i]));
        end
    endgenerate

    always @(negedge rst) begin
        count = 0;
        for(j = 0; j < 63; j = j + 1) begin
            dataOut[j] = 64'hXXXX_XXXX_XXXX_XXXX;
        end
    end

    always @(posedge clk) begin
        if(count == 71) begin
            for(j = 0; j < 63; j = j + 1) begin
                dataOut[j] <= wout[j];
            end
            count = 0;
        end
        else begin
            count = count + 1;
        end
    end

endmodule
