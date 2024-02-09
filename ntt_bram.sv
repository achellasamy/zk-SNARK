
module ntt_bram
    (
        input clk,
        input rst,
        output [11:0] BRAM_addr,
        output BRAM_clk,
        output [63:0] BRAM_din,
        input [63:0] BRAM_dout,
        output BRAM_en,
        output BRAM_rst,
        output BRAM_we
    );

    localparam BRAM_DEPTH = 4096;

    integer i;

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [31:0] address;
    logic [31:0] counter;
    logic done;

    always_ff (@posedge clk) begin
        if(rst) begin
            for(i = 0; i < 64; i = i + 1) begin
                xData[i] = 64'hXXXX_XXXX_XXXX_XXXX;
                yData[i] = 64'hXXXX_XXXX_XXXX_XXXX;
            end
        end
        else if(!done) begin
            xData[counter] <= BRAM_dout;
        end
    end


    always_ff @(posedge clk) begin
      if (rst) begin
         address <= 0;
      end
      else begin
         if (seq_valid) begin
            if (address < BRAM_DEPTH-1) begin
               address <= address + 1;
            end
            else begin
               address <= 0;
            end            
         end
      end
    end

    assign BRAM_addr = address << 2;
    assign BRAM_clk = clk;
    //assign BRAM_din = 
    assign BRAM_en = 1;
    assign BRAM_rst = rst;
    //assign BRAM_we = 

endmodule

