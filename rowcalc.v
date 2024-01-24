module rowcalc(
    input clk,
    input [63:0] a,
    input [7:0] w,
    output [63:0] out
    );

    wire [63:0] aw;

    reg [63:0] temp = 0;
    reg [63:0] temp2 = 0;
    reg [127:0] result = 0;
    reg [255:0] b;
    reg done;
    reg [8:0] count = 0;

    always @ (posedge clk) begin
        b <= a << w;
    end

    fast_mod_256 m1 (.a(b[255:224]), .b(b[223:192]), .c(b[191:160]),
                     .d(b[159:128]), .e(b[127:96]), .f(b[95:64]),
                     .g(b[63:32]), .h(b[31:0]), .clk(clk), .z(aw));

    always @(posedge clk) begin
        if(count == 71)
            count <= 0;
        else
            count <= count + 1'b1;
    end

    always @(posedge clk) begin
        if(count < 7)
            result <= aw;
        else
            result <= result + aw;
    end

endmodule

