module ntt_bram_fixed
    (
        input clk,
        input rst,
        output [9:0] BRAM_addr_0,
        output BRAM_clk_0,
        output logic [63:0] BRAM_din_0,
        input [63:0] BRAM_dout_0,
        output BRAM_en_0,
        output BRAM_we_0,
        output logic ntt_done
    );

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [31:0] address_0;
    logic [31:0] rowi, coli, colix;
    logic [1:0] readx, writeOut;
    logic done, nttrst, enX;

    logic [7:0] wData [0:63][0:63];

    omega omega_i (wData);

    ntt n1 (.x(xData), .w(wData), .clk(clk), .rst(nttrst), .y(yData), .done(done));

    always_ff @( posedge clk ) begin
        if(rst) begin
            address_0 <= 0;
            readx <= 2;
            writeOut <= 0;
            colix <= 0;
            enX <= 1'b1;
            ntt_done <= 1'b0;
            nttrst <= 1'b1;
        end
        else if(done && !ntt_done) begin
            if(writeOut == 0) begin
                BRAM_din_0 <= yData[colix];
                writeOut <= writeOut + 1;
            end
            else if(writeOut == 1) begin
                writeOut <= writeOut + 1;
            end
            else if(writeOut == 2) begin
                writeOut <= writeOut + 1;
            end
            else begin
                if(colix < 63) begin
                    colix <= colix + 1;
                    writeOut <= 0;
                    address_0 <= address_0 + 1;
                end
                else if(colix >= 63) begin
                    ntt_done <= 1'b1;
                    colix <= 0;
                end
            end
        end
        else if(!done && enX) begin
            if(readx == 0) begin
                if(colix < 63) begin
                    colix <= colix + 1;
                    readx <= readx + 1;
                    address_0 <= address_0 + 1;
                end
            end
            else if(readx == 1) begin
                readx <= readx + 1;
            end
            else if(readx == 2) begin
                readx <= readx + 1;
            end
            else if(readx == 3) begin
                if(colix < 63) begin
                    xData[colix] <= BRAM_dout_0;
                    readx <= 0;
                end
                else if(colix >= 63) begin
                    xData[colix] <= BRAM_dout_0;
                    colix <= 0;
                    enX <= 1'b0;
                    nttrst <= 1'b0;
                    address_0 <= address_0 + 1;
                end
            end
        end
    end
    
    assign BRAM_addr_0 = address_0 << 2;
    assign BRAM_clk_0 = clk;
    assign BRAM_en_0 = 1;
    assign BRAM_we_0 = done;

endmodule