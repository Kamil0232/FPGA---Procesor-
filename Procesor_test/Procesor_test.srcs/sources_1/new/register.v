`timescale 1ns / 1ps
module register(
    input clk,
    input ce,
    input [7:0]data_in,
    output [7:0]data_out
);
reg [7:0]data_bank = 0;
assign data_out = data_bank;
 
always@(posedge clk)
begin
    if(ce)
    begin
        data_bank <= data_in;
    end
end

endmodule


