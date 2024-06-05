//NTT BRAM Module
//NO FIXED OMEGA VALUES

module ntt_bram_single
    (
        input clk,
        input rst,
        output [14:0] BRAM_addr,
        output BRAM_clk,
        output logic [63:0] BRAM_din,
        input [63:0] BRAM_dout,
        output BRAM_en,
        output BRAM_we,
        output logic ntt_done
    );

    logic [63:0] xData [0:63];
    logic [63:0] yData [0:63];
    logic [7:0] wData [0:63][0:63];
    logic [31:0] address;
    logic [31:0] rowi, coli;
    logic [1:0] read, writeOut;
    logic done, nttrst, readW, readX;

    ntt n1 (.x(xData), .w(wData), .clk(clk), .rst(nttrst), .y(yData), .done(done));

    always_ff @( posedge clk ) begin : Data_Read
        if(rst) begin
            address <= 0;
            rowi <= 0;
            coli <= 0;
            readX <= 1'b1;
            readW <= 1'b0;
            read <= 2;
            writeOut <= 0;
            nttrst <= 1'b1;
            ntt_done <= 1'b0;
        end
        else if(done && !ntt_done) begin
            if(writeOut == 0) begin
                BRAM_din <= yData[coli];
                writeOut <= writeOut + 1;
            end
            else if(writeOut == 1) begin
                writeOut <= writeOut + 1;
            end
            else if(writeOut == 2) begin
                writeOut <= writeOut + 1;
            end
            else begin
                if(coli < 63) begin
                    coli <= coli + 1;
                    writeOut <= 0;
                    address <= address + 1;
                end
                else if(coli >= 63) begin
                    ntt_done <= 1'b1;
                    coli <= 0;
                end
            end
        end
        else if(!done && readX) begin
            if(read == 0) begin
                if(coli < 63) begin
                    coli <= coli + 1;
                    read <= read + 1;
                    address <= address + 1;
                end
            end
            else if(read == 1) begin
                read <= read + 1;
            end
            else if(read == 2) begin
                read <= read + 1;
            end
            else if(read == 3) begin
                if(coli < 63) begin
                    xData[coli] <= BRAM_dout;
                    read <= 0;
                end
                else if(coli >= 63) begin
                    xData[coli] <= BRAM_dout;
                    coli <= 0;
                    rowi <= 0;
                    readX <= 1'b0;
                    readW <= 1'b1;
                    read <= 1;
                    address <= address + 1;
                end
            end
        end
        else if(!done && readW) begin
            if(read == 0) begin
                if(coli < 63) begin
                    coli <= coli + 1;
                    read <= read + 1;
                    address <= address + 1;
                end
                else if(rowi < 63) begin
                    coli <= 0;
                    rowi <= rowi + 1;
                    read <= read + 1;
                    address <= address + 1;
                end
                else if(rowi >= 63) begin
                    rowi <= 0;
                    coli <= 0;
                    readW <= 1'b0;
                    address <= 4160; //First Write address for yData
                    nttrst <= 1'b0;
                end
            end
            else if(read == 1) begin
                read <= read + 1;
            end
            else if(read == 2) begin
                read <= read + 1;
            end
            else if(read == 3)begin
                wData[rowi][coli] <= BRAM_dout;
                read <= 0;
            end
        end
    end
    
    assign BRAM_addr = address << 2;
    assign BRAM_clk = clk;
    assign BRAM_en = 1;
    assign BRAM_we = done;

endmodule