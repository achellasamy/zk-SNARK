
module ntt_tb();

    logic [63:0] x [0:63];
    logic [7:0] w [0:63];
    logic clk, rst;

    ntt UUT (.x(x), .w(w), .clk(clk), .rst(rst));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        write_x(x);
        write_w(w);
        display_data(x, w);
        clk = 1'b0;
        #400;
    end

endmodule

task display_data(input [63:0] x [0:63], input [7:0] w [0:63]);
    integer i;
    for(i = 0; i < 63; i = i + 1) begin
        $display("x(%d) --> %h", i, x[i]);
        $display("w(%d) --> %h", i, w[i]);
    end
endtask

task write_x(output logic [63:0] x [0:63]);
    int i, file;
    string line;

    file = $fopen("./polynomials.txt", "r");
    if(file) $display("Polynomial File was opened successfully");
    else     $display("ERROR: Polynomial File was NOT opened successfully");

    for(i = 0; i < 63; i++) begin
        $fgets(line, file);
        $sscanf(line, "{%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d}",
                        x[i][63], x[i][62], x[i][61], x[i][60], x[i][59], x[i][58], x[i][57], x[i][56], x[i][55], x[i][54], x[i][53], x[i][52], x[i][51], x[i][50], x[i][49], x[i][48],
                        x[i][47], x[i][46], x[i][45], x[i][44], x[i][43], x[i][42], x[i][41], x[i][40], x[i][39], x[i][38], x[i][37], x[i][36], x[i][35], x[i][34], x[i][33], x[i][32], 
                        x[i][31], x[i][30], x[i][29], x[i][28], x[i][27], x[i][26], x[i][25], x[i][24], x[i][23], x[i][22], x[i][21], x[i][20], x[i][19], x[i][18], x[i][17], x[i][16], 
                        x[i][15], x[i][14], x[i][13], x[i][12], x[i][11], x[i][10], x[i][9], x[i][8], x[i][7], x[i][6], x[i][5], x[i][4], x[i][3], x[i][2], x[i][1], x[i][0]);
    end

    $fclose(file);
endtask

task write_w(output [7:0] w [0:63]);
    int i, file;
    string line;

    file = $fopen("./omega.txt", "r");
    if(file) $display("Omega File was opened successfully");
    else     $display("ERROR: Omega File was NOT opened successfully");

    for(i = 0; i < 63; i++) begin
        $fgets(line, file);
        $sscanf(line, "{%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d}",
                        w[i][63], w[i][62], w[i][61], w[i][60], w[i][59], w[i][58], w[i][57], w[i][56], w[i][55], w[i][54], w[i][53], w[i][52], w[i][51], w[i][50], w[i][49], w[i][48],
                        w[i][47], w[i][46], w[i][45], w[i][44], w[i][43], w[i][42], w[i][41], w[i][40], w[i][39], w[i][38], w[i][37], w[i][36], w[i][35], w[i][34], w[i][33], w[i][32], 
                        w[i][31], w[i][30], w[i][29], w[i][28], w[i][27], w[i][26], w[i][25], w[i][24], w[i][23], w[i][22], w[i][21], w[i][20], w[i][19], w[i][18], w[i][17], w[i][16], 
                        w[i][15], w[i][14], w[i][13], w[i][12], w[i][11], w[i][10], w[i][9], w[i][8], w[i][7], w[i][6], w[i][5], w[i][4], w[i][3], w[i][2], w[i][1], w[i][0]);
    end

    $fclose(file);
endtask


