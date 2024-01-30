
module ntt_tb();

    logic [63:0] x [0:63];
    logic [63:0] w [0:63];
    logic clk, rst;

    ntt UUT (.x(x), .w(w), .clk(clk), .rst(rst));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        write_x(x);
        write_w(w);
        clk = 1'b0;
        #400;

    end
endmodule

task display_data(input [63:0] x [0:63]);
    integer i;
    for(i = 0; i < 63; i = i + 1) begin
        $display("x(%d) --> %h" , x[i]);
    end
endtask

task write_x(output logic [63:0] x [0:63]);
    int i, file;
    string line;

    file = $fopen("./polynomials.txt", "r");
    if(file) $display("File was opened successfully");
    else     $display("ERROR: File was NOT opened successfully");

    $fgets(line, file);
    $sscanf(line, "{%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d}",
                    x[63], x[62], x[61], x[60], x[59], x[58], x[57], x[56], x[55], x[54], x[53], x[52], x[51], x[50], x[49], x[48],
                    x[47], x[46], x[45], x[44], x[43], x[42], x[41], x[40], x[39], x[38], x[37], x[36], x[35], x[34], x[33], x[32], 
                    x[31], x[30], x[29], x[28], x[27], x[26], x[25], x[24], x[23], x[22], x[21], x[20], x[19], x[18], x[17], x[16], 
                    x[15], x[14], x[13], x[12], x[11], x[10], x[9], x[8], x[7], x[6], x[5], x[4], x[3], x[2], x[1], x[0]);

    $fclose(file);
endtask

task write_w(output [63:0] w [0:63]);
    integer i;
    for(i = 0; i < 63; i = i + 1) begin
        //code to make input values w
    end
endtask


