
module ntt(x, w, clk, rst, y);

    input [63:0] x [0:63];
    input [7:0] w [0:63][0:63];
    input clk, rst;
    output logic [63:0] y [0:63];

    logic [63:0] wout;
    logic [63:0] ain;
    logic [7:0] win;

    integer count, j;
    integer indexi;

    genvar i;

    generate
        for(i = 0; i < 64; i = i + 1) begin
            rowcalc rc (.clk(clk), .a(ain), .w(win), .out(wout));
        end
    endgenerate

    always @(negedge rst) begin
        count <= 0;
        indexi <= 0;
        ain <= x[0];
        win <= w[0][0];
        for(j = 0; j < 64; j = j + 1) begin
            y[j] <= 64'hXXXX_XXXX_XXXX_XXXX;
        end
    end

    always @(posedge clk) begin
        if(count > 7 && count < 71) begin
            ain <= x[count - 7];
            win <= w[indexi][count - 7];
            count <= count + 1;
        end
        else if(count == 71) begin
            y[indexi] <= wout;
            indexi <= indexi + 1;
            count <= 0;
        end
        else if(count <= 7) begin
            ain <= x[0];
            win <= w[indexi][0];
            count <= count + 1;
        end
    end

endmodule
