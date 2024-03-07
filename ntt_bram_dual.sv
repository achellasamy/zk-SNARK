module ntt_bram_dual
    (
        input clk,
        input rst,
        output [9:0] BRAM_addr_0,
        output BRAM_clk_0,
        output logic [63:0] BRAM_din_0,
        input [63:0] BRAM_dout_0,
        output BRAM_en_0,
        output BRAM_we_0,
        output [12:0] BRAM_addr_1,
        output BRAM_clk_1,
        input [7:0] BRAM_dout_1,
        output BRAM_en_1,
        output logic ntt_done
    );

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [7:0] wData [0:63][0:63];
    logic [31:0] address_0, address_1;
    logic [31:0] rowi, coli, colix;
    logic [1:0] readw, readx, writeOut;
    logic done, nttrst, enW, enX;

    ntt n1 (.x(xData), .w(wData), .clk(clk), .rst(nttrst), .y(yData), .done(done));

    always_ff @( posedge clk ) begin
        if(rst) begin
            address_1 <= 0;
            readw <= 2;
            nttrst <= 1'b1;
            rowi <= 0;
            coli <= 0;
            enW <= 1'b1;
        end
        else if(!done && enW) begin
            if(readw == 0) begin
                if(coli < 63) begin
                    coli <= coli + 1;
                    readw <= readw + 1;
                    address_1 <= address_1 + 1;
                end
                else if(rowi < 63) begin
                    coli <= 0;
                    rowi <= rowi + 1;
                    readw <= readw + 1;
                    address_1 <= address_1 + 1;
                end
                else if(rowi >= 63) begin
                    rowi <= 0;
                    coli <= 0;
                    enW <= 1'b0;
                    nttrst <= 1'b0;
                end
            end
            else if(readw == 1) begin
                readw <= readw + 1;
            end
            else if(readw == 2) begin
                readw <= readw + 1;
            end
            else if(readw == 3)begin
                wData[rowi][coli] <= BRAM_dout_1;
                readw <= 0;
            end
        end
    end

    always_ff @( posedge clk ) begin
        if(rst) begin
            address_0 <= 0;
            readx <= 2;
            writeOut <= 0;
            colix <= 0;
            enX <= 1'b1;
            ntt_done <= 1'b0;
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
                    address_0 <= address_0 + 1;
                end
            end
        end
    end
    
    assign BRAM_addr_0 = address_0 << 2;
    assign BRAM_clk_0 = clk;
    assign BRAM_en_0 = 1;
    assign BRAM_we_0 = done;
    assign BRAM_addr_1 = address_1 << 2;
    assign BRAM_clk_1 = clk;
    assign BRAM_en_1 = 1;

endmodule