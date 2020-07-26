`timescale 1ns / 1ps

module rd_mux(
    input [7:0]memory_data,
    input [7:0]alu_res,
    input rd_op,
    output [7:0]data_out
);
assign data_out = rd_op == 1'b0 ? alu_res : memory_data;
endmodule

module pc_mux(
    input [7:0]pc_addr_plus_1,
    input [7:0]alu_res,
    input jump,
    output [7:0]data_out
);
assign data_out = jump == 1'b0 ? pc_addr_plus_1 : alu_res;
endmodule

module rx_mux(
    input [7:0]r0,
    input [7:0]r1,
    input [7:0]r2,
    input [7:0]r3,
    input [7:0]r4,
    input [7:0]r5,
    input [7:0]r6,
    input [7:0]r7,
    input [2:0]rx_op, //odpalenie muxa
    output [7:0]data_out  
);
assign data_out = rx_op == 3'd0 ? r0 : rx_op == 3'd1 ? r1 : rx_op == 3'd2 ? r2 : rx_op == 3'd3 ? r3 : rx_op == 3'd4 ? r4 : rx_op == 3'd5 ? r5 : rx_op == 3'd6 ? r6 : r7; //przypisanie odpowiedniego rejestru
endmodule


module ry_mux
(
    input [7:0]r0,
    input [7:0]r1,
    input [7:0]r2,
    input [7:0]r3,
    input [7:0]r4,
    input [7:0]r5,
    input [7:0]r6,
    input [7:0]r7,
    input [2:0]ry_op, //odpalenie muxa
    output [7:0]data_out
    
    
);
assign data_out = ry_op == 3'd0 ? r0 : ry_op == 3'd1 ? r1 : ry_op == 3'd2 ? r2 : ry_op == 3'd3 ? r3 : ry_op == 3'd4 ? r4 : ry_op == 3'd5 ? r5 : ry_op == 3'd6 ? r6 : r7;
endmodule

module imm_mux(
    input [7:0]imm,
    input [7:0]ry_out,
    input imm_op,
    output [7:0]data_out
);
assign data_out= imm_op==1'b0 ? ry_out : imm; //przypisanie rejestru bπdü wartoúci z imm
endmodule

module alu_mux(
    input [7:0]data_and,
    input [7:0]data_plus,
    input [7:0]data_compare,
    input [7:0]data_imm,
    input [1:0]alu_op,
    output [7:0]alu_res
);
assign alu_res = alu_op == 2'd0 ? data_and : alu_op == 2'd1 ? data_plus : alu_op == 2'd2 ? data_compare : data_imm;
endmodule

