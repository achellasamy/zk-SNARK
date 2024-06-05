/* Adapted From Hartshorn, 
Austin J, et al. Number Theoretic Transform (ntt) 
Fpga Accelerator. : Worcester Polytechnic Institute, 2020.*/

module fast_mod_256(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    input [31:0] e,
    input [31:0] f,
    input [31:0] g,
    input [31:0] h,
    input clk,
    output reg [63:0] z
    );

    parameter p = 64'hffffffff00000001;

    reg [34:0] afg = 35'b0;
    reg [34:0] bch = 35'b0;
    reg [34:0] cd = 35'b0;
    reg [34:0] ef = 35'b0;
    reg [65:0] ztemp = 66'b0;
    reg [65:0] ztemp2 = 66'b0;
    reg [34:0] bch2 = 35'b0;
    reg [34:0] ef2 = 35'b0;

    always @ (posedge clk) begin
        afg <= (a+f+g);
        bch <= (b+c+h);
        cd <= (c+d);
        ef <= (e+f);

        if({cd, 32'b0} > {afg, 32'b0})
            ztemp <= p + p + {afg - cd, 32'b0} + bch - ef;
        else if(cd > afg)
            ztemp <= p + {afg - cd, 32'b0}+ bch - ef;
        else
            ztemp <= {afg - cd, 32'b0} + bch - ef;

        if(ztemp > (p+p))
            z <= ztemp - p - p;
        else if(ztemp > p)
            z <= ztemp - p;
        else
            z <= ztemp;
    end
endmodule