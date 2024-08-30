`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2024 07:46:46 PM
// Design Name: 
// Module Name: platform
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module platform
( 
    output logic [9:0]  platformX, 
    output logic [9:0]  platformY, 
    output logic [9:0]  platformW,
    output logic [9:0]  platformH

);


    parameter [9:0] platform_X_Center=320;  // Center position on the X axis
    parameter [9:0] platform_Y_Center=470;  // Center position on the Y axis


    assign platformW = 10'd48;
    assign platformH = 10'd8;

    assign platformX = platform_X_Center;
    assign platformY = platform_Y_Center;



endmodule
