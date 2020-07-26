`timescale 1ns / 1ps
module jump(
    input [1:0]pc_op,
    input cmp_res,
    output data_out
);

//assign data_out = (pc_op == 2'd0||(pc_op == 2'd2 && cmp_res == 1'b0)||(pc_op == 2'd3 && cmp_res == 1'b1)) ? 1'b0 : 1'b1; //wybór trybu skoku
assign data_out = pc_op == 2'b0 ? 1'b1 : pc_op == 2'd1 ? 1'b0 : pc_op == 2'd2 ? (cmp_res == 0 ? 1'b1 : 1'b0) : (cmp_res == 0 ? 1'b0 : 1'b1);
endmodule
