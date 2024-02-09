module ntt_bram
    (
        input clk,
        input rst,
        output [11:0] BRAM_addr,
        output BRAM_clk,
        output logic [63:0] BRAM_din,
        input [63:0] BRAM_dout,
        output BRAM_en,
        output BRAM_rst,
        output BRAM_we
    );

    integer i;

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [7:0] wData [0:63][0:63];
    logic [31:0] addressx, addressy;
    logic [31:0] counterx, countery;
    logic done, nttrst;

    ntt n1 (.x(xData), .w(wData), .clk(clk), .rst(nttrst), .y(yData), .done(done));

    always_ff @(posedge clk) begin
        if(rst) begin
            counterx <= 0;
            for(i = 0; i < 64; i = i + 1) begin
                xData[i] = 64'hXXXX_XXXX_XXXX_XXXX;
            end
        end
        else if(!done) begin
            if(counterx < 64) begin
                xData[counterx] <= BRAM_dout;
                nttrst <= 1'b1;
                counterx <= counterx + 1;
            end
            else begin
                nttrst = 1'b0;
                counterx <= 0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            countery <= 0;
            for(i = 0; i < 64; i = i + 1) begin
                yData[i] = 64'hXXXX_XXXX_XXXX_XXXX;
            end
        end
        else if(done) begin
            if(countery < 64) begin
                BRAM_din <= yData[countery];
                nttrst <= 1'b1;
                counterx <= counterx + 1;
            end
            else begin
                counterx <= 0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            addressx <= 0;
            addressy <= 64;
        end
        else begin
            if(done) begin
                if (addressy < 128) begin
                    addressy <= addressy + 1;
                end
                else begin
                    addressy <= 64;
                end            
            end
            else begin
                if (addressx < 64) begin
                    addressx <= addressx + 1;
                end
                else begin
                    addressx <= 0;
                end
            end
        end
    end

    assign BRAM_addr = (done) ? addressy << 2 : addressx << 2;
    assign BRAM_clk = clk;
    assign BRAM_en = 1;
    assign BRAM_rst = rst;
    assign BRAM_we = done;

endmodule