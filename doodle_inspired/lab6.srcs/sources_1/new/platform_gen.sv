`timescale 1ns / 1ps
module platform_gen(
    input logic clk, rst,
    output logic [8:0] x_coord [19:0], // Array of outputs for x coordinates
    output logic [8:0] y_coord [19:0]  // Array of outputs for y coordinates
);
    
    lfsr x_gen_0 (
        .clk(clk),
        .rst(rst),
        .seed(9'd320), // Simplified assumption of direct correlation
        .out(x_coord[0])
    );

    lfsr y_gen_0 (
        .clk(clk),
        .rst(rst),
        .seed(9'd470),
        .out(y_coord[0])
    );
    
    
    lfsr x_gen_1 (
        .clk(clk),
        .rst(rst),
        .seed(9'd131), // Simplified assumption of direct correlation
        .out(x_coord[1])
    );

    lfsr y_gen_1 (
        .clk(clk),
        .rst(rst),
        .seed(9'd220),
        .out(y_coord[1])
    );
    
    lfsr x_gen_2 (
        .clk(clk),
        .rst(rst),
        .seed(9'd390), // Simplified assumption of direct correlation
        .out(x_coord[2])
    );

    lfsr y_gen_2 (
        .clk(clk),
        .rst(rst),
        .seed(9'd420),
        .out(y_coord[2])
    );
    
    lfsr x_gen_3 (
        .clk(clk),
        .rst(rst),
        .seed(9'd118), // Simplified assumption of direct correlation
        .out(x_coord[3])
    );

    lfsr y_gen_3 (
        .clk(clk),
        .rst(rst),
        .seed(9'd92),
        .out(y_coord[3])
    );
    
    lfsr x_gen_4 (
        .clk(clk),
        .rst(rst),
        .seed(9'd140), // Simplified assumption of direct correlation
        .out(x_coord[4])
    );

    lfsr y_gen_4 (
        .clk(clk),
        .rst(rst),
        .seed(9'd112),
        .out(y_coord[4])
    );
    
    lfsr x_gen_5 (
        .clk(clk),
        .rst(rst),
        .seed(9'd171), // Simplified assumption of direct correlation
        .out(x_coord[5])
    );

    lfsr y_gen_5 (
        .clk(clk),
        .rst(rst),
        .seed(9'd323),
        .out(y_coord[5])
    );

    lfsr x_gen_6 (
        .clk(clk),
        .rst(rst),
        .seed(9'd136), // Simplified assumption of direct correlation
        .out(x_coord[6])
    );

    lfsr y_gen_6 (
        .clk(clk),
        .rst(rst),
        .seed(9'd456),
        .out(y_coord[6])
    );


    lfsr x_gen_7 (
        .clk(clk),
        .rst(rst),
        .seed(9'd123), // Simplified assumption of direct correlation
        .out(x_coord[7])
    );

    lfsr y_gen_7 (
        .clk(clk),
        .rst(rst),
        .seed(9'd220),
        .out(y_coord[7])
    );
    
    lfsr x_gen_8 (
        .clk(clk),
        .rst(rst),
        .seed(9'd467), // Simplified assumption of direct correlation
        .out(x_coord[8])
    );

    lfsr y_gen_8 (
        .clk(clk),
        .rst(rst),
        .seed(9'd102),
        .out(y_coord[8])
    );
    
    lfsr x_gen_9 (
        .clk(clk),
        .rst(rst),
        .seed(9'd317), // Simplified assumption of direct correlation
        .out(x_coord[9])
    );

    lfsr y_gen_9 (
        .clk(clk),
        .rst(rst),
        .seed(9'd333),
        .out(y_coord[9])
    );
    
    lfsr x_gen_10 (
        .clk(clk),
        .rst(rst),
        .seed(9'd270), // Simplified assumption of direct correlation
        .out(x_coord[10])
    );

    lfsr y_gen_10 (
        .clk(clk),
        .rst(rst),
        .seed(9'd483),
        .out(y_coord[10])
    );
    
    
    lfsr x_gen_11 (
        .clk(clk),
        .rst(rst),
        .seed(9'd129), // Simplified assumption of direct correlation
        .out(x_coord[11])
    );

    lfsr y_gen_11 (
        .clk(clk),
        .rst(rst),
        .seed(9'd69),
        .out(y_coord[11])
    );
    
    lfsr x_gen_12 (
        .clk(clk),
        .rst(rst),
        .seed(9'd56), // Simplified assumption of direct correlation
        .out(x_coord[12])
    );

    lfsr y_gen_12 (
        .clk(clk),
        .rst(rst),
        .seed(9'd148),
        .out(y_coord[12])
    );
    
    lfsr x_gen_13 (
        .clk(clk),
        .rst(rst),
        .seed(9'd392), // Simplified assumption of direct correlation
        .out(x_coord[13])
    );

    lfsr y_gen_13 (
        .clk(clk),
        .rst(rst),
        .seed(9'd500),
        .out(y_coord[13])
    );

    lfsr x_gen_14 (
        .clk(clk),
        .rst(rst),
        .seed(9'd140), // Simplified assumption of direct correlation
        .out(x_coord[14])
    );

    lfsr y_gen_14 (
        .clk(clk),
        .rst(rst),
        .seed(9'd174),
        .out(y_coord[14])
    );
    
    lfsr x_gen_15 (
        .clk(clk),
        .rst(rst),
        .seed(9'd53), // Simplified assumption of direct correlation
        .out(x_coord[15])
    );

    lfsr y_gen_15 (
        .clk(clk),
        .rst(rst),
        .seed(9'd499),
        .out(y_coord[15])
    );

    lfsr x_gen_16 (
        .clk(clk),
        .rst(rst),
        .seed(9'd94), // Simplified assumption of direct correlation
        .out(x_coord[16])
    );

    lfsr y_gen_16 (
        .clk(clk),
        .rst(rst),
        .seed(9'd501),
        .out(y_coord[16])
    );
    
    lfsr x_gen_17 (
        .clk(clk),
        .rst(rst),
        .seed(9'd250), // Simplified assumption of direct correlation
        .out(x_coord[17])
    );

    lfsr y_gen_17 (
        .clk(clk),
        .rst(rst),
        .seed(9'd104),
        .out(y_coord[17])
    );


    lfsr x_gen_18 (
        .clk(clk),
        .rst(rst),
        .seed(9'd255), // Simplified assumption of direct correlation
        .out(x_coord[18])
    );

    lfsr y_gen_18 (
        .clk(clk),
        .rst(rst),
        .seed(9'd40),
        .out(y_coord[18])
    );
    
    lfsr x_gen_19 (
        .clk(clk),
        .rst(rst),
        .seed(9'd102), // Simplified assumption of direct correlation
        .out(x_coord[19])
    );

    lfsr y_gen_19 (
        .clk(clk),
        .rst(rst),
        .seed(9'd403),
        .out(y_coord[19])
    );



endmodule