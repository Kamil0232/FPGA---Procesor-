`timescale 1ns / 1ps
module decoder(
    input [2:0]d_op, //odpalenie dekodera
    output [6:0]out
);
assign out[0] = d_op == 3'd0 ? 1'b1 : 1'b0; //wybór odpowiedniego rejestru z szeœciu dostêpnych 
assign out[1] = d_op == 3'd1 ? 1'b1 : 1'b0;
assign out[2] = d_op == 3'd2 ? 1'b1 : 1'b0;
assign out[3] = d_op == 3'd3 ? 1'b1 : 1'b0;
assign out[4] = d_op == 3'd4 ? 1'b1 : 1'b0;
assign out[5] = d_op == 3'd5 ? 1'b1 : 1'b0;
assign out[6] = d_op == 3'd6 ? 1'b1 : 1'b0;



endmodule