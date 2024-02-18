module ntt_bram
    (
        input clk,
        input rst,
        output [12:0] BRAM_addr,
        output BRAM_clk,
        output logic [63:0] BRAM_din,
        input [63:0] BRAM_dout,
        output BRAM_en,
        output BRAM_we
    );

    integer i, j;

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [7:0] wData [0:63][0:63];
    logic [31:0] addressx, addressy, addressw;
    logic [31:0] counterx, countery, counterw, counter_w_ROW;
    logic done, nttrst, sentx, sentw;

    ntt n1 (.x(xData), .w(wData), .clk(clk), .rst(nttrst), .y(yData), .done(done));

    always_ff @(posedge clk) begin
        if(rst) begin
            counterx <= 0;
            counterw <= 0;
            nttrst <= 1'b1;
            sentx <= 1'b0;
            sentw <= 1'b0;
            for(i = 0; i < 64; i = i + 1) begin
                xData[i] <= 64'hXXXX_XXXX_XXXX_XXXX;
            end
        end
        else if(!done && !sentx) begin
            if(counterx < 64) begin
                xData[counterx] <= BRAM_dout;
                counterx <= counterx + 1;
            end
            else begin
                nttrst <= 1'b0;
                sentx <= 1'b1;
                counterx <= 0;
            end
        end
        else if(!done && !sentw && sentx) begin
            if(counter_w_ROW < 64) begin
                if(counterw < 64) begin
                    wData[counter_w_ROW][counterw] <= BRAM_dout;
                    counterw <= counterw + 1;
                end
                else if(counterw >= 64) begin
                    counterw <= 0;
                    counter_w_ROW <= counter_w_ROW + 1;
                end
            end
            else if(counter_w_ROW >= 64) begin
                counter_w_ROW <= 0;
                sentw <= 1'b1;
                nttrst <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            countery <= 0;
            for(i = 0; i < 64; i = i + 1) begin
                yData[i] <= 64'hXXXX_XXXX_XXXX_XXXX;
            end
        end
        else if(done) begin
            if(countery < 64) begin
                BRAM_din <= yData[countery];
                countery <= countery + 1;
            end
            else begin
                countery <= 0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            addressx <= 0;
            addressy <= 64;
            addressw <= 128;
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
            else if(!sentx) begin
                if (addressx < 64) begin
                    addressx <= addressx + 1;
                end
                else begin
                    addressx <= 0;
                end
            end
            else if(sentx) begin
                if(addressw < 4224) begin
                    addressw <= addressw + 1;
                end
                else begin
                    addressw <= 0;
                end
            end
        end
    end

    assign BRAM_addr = (done) ? addressy << 2 : ((sentx) ? addressw << 2 : addressx << 2);
    assign BRAM_clk = clk;
    assign BRAM_en = 1;
    assign BRAM_we = done;

endmodule