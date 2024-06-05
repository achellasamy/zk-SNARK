/* Adapted From Hartshorn, 
Austin J, et al. Number Theoretic Transform (ntt) 
Fpga Accelerator. : Worcester Polytechnic Institute, 2020.*/

// compute (2^32)(b+c)-a-b+d mod p
// pipeline into two stages
// checks for overflow

module fast_mod(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    input clk,
    output reg [63:0] z
    );

    parameter p = 64'hffffffff00000001;
    
    reg [64:0] ztemp1 = 0;
    
    always @ (posedge clk) begin
    //first stage
        ztemp1 <= {(b+c), 32'b0} + d - a - b;
    //second stage (checking for overflow)
        if((ztemp1) > p)
            z <= ztemp1 - p;
        else
            z <= ztemp1;
    end

endmodule