`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 10:01:37 PM
// Design Name: 
// Module Name: lfsr
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


module lfsr_tb(

    );
    
    timeunit 10ns;  // This is the amount of time represented by #1 
    timeprecision 1ns;
    
     logic clk; 
     logic rst;
     logic [8:0] x_coord [19:0]; // Array of outputs for x coordinates
     logic [8:0] y_coord [19:0];  // Array of outputs for y coordinates
    

initial begin: CLOCK_INITIALIZATION
    clk = 1'b1;
end 

always begin : CLOCK_GENERATION
    #1 clk = ~clk;
end

initial begin : TEST_VECTORS   
    rst = 1'b1;
    #5;
    rst = 1'b0;
    
 
  
end

    
endmodule
