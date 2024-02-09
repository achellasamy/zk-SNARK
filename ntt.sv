
module ntt(x, w, clk, rst, y);

    input [63:0] x [0:63];
    input [7:0] w [0:63][0:63];
    input clk, rst;
    output logic [63:0] y [0:63];

    logic [63:0] wout [0:63];
    logic [63:0] ain;
    logic [7:0] win [0:63];

    integer count, j;

    genvar i;

    generate
        for(i = 0; i < 64; i = i + 1) begin
            rowcalc rc (.clk(clk), .a(ain), .w(win[i]), .out(wout[i]));
        end
    endgenerate

    always_ff @(posedge clk) begin
        if(rst) begin
            count <= 0;
            ain <= x[0];
            for(j = 0; j < 64; j = j + 1) begin
                win[j] <= w[j][0];
            end
        end
        else if(count > 7 && count < 71) begin
            ain <= x[count - 7];
            for(j = 0; j < 64; j = j + 1) win[j] <= w[j][count - 7];
            count <= count + 1;
        end
        else if(count == 71) begin
            for(j = 0; j < 64; j = j + 1) y[j] <= wout[j];
            count <= 0;
        end
        else if(count <= 7) begin
            ain <= x[0];
            for(j = 0; j < 64; j = j + 1) win[j] <= w[j][0];
            count <= count + 1;
        end
    end

endmodule
