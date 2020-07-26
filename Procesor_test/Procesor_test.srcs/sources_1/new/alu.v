`timescale 1ns / 1ps
module alu(
    input [7:0] rx_mux,
    input [7:0] ry_mux,
    output [7:0] and_gate,
    output [7:0] sum,
    output [7:0] compare
);
assign and_gate = rx_mux & ry_mux;
assign sum = (rx_mux+ry_mux)>8'd255 ? 8'd255: rx_mux+ry_mux;
assign compare = rx_mux == 1'b0 ? 8'd255 : 8'd0;
endmodule