`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 10:10:54 PM
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


module lfsr(
    input logic clk, rst,
    input logic [8:0] seed,
    output logic [8:0] out
);

logic [8:0] q;

always_ff @(posedge clk or posedge rst) 
begin
    if(rst)
    begin
        q <= seed;
    end
    else
    begin
        q <= {q[7:0], q[8] ^ q[4]};
    end
end

assign out = q;

endmodule
