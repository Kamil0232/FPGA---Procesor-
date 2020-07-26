`timescale 1ns / 1ps
module main
(
    input clk,
    input [7:0]gpi,
    output [7:0]gpo
);

wire [7:0]alu_res;
wire [7:0]data_in;
wire [7:0]pc_addr;
wire [31:0]instr;
wire [1:0]pc_op = instr[25:24];
wire [1:0]alu_op = instr[21:20];
wire [2:0]rx_op = instr[18:16];
wire [0:0]imm_op = instr[15];
wire [2:0]ry_op = instr[14:12];
wire [0:0]rd_op = instr[11];
wire [2:0]d_op = instr[10:8];
wire [7:0]imm = instr[7:0];
wire [7:0]rd_mux_out;
wire [6:0]decoder_out;
wire [7:0]pc_mux_out;
wire jump;
wire [7:0]address;
wire [7:0]data_register_out[7:0];
wire [7:0]rx_out;
wire [7:0]ry_out;
wire [7:0]imm_out;
wire [7:0]alu_result[2:0];
wire cmp_res;
wire [7:0]gpi_main;
wire [7:0]gpo_main;

assign address = pc_addr + 1;
assign pc_addr = data_register_out[7];
assign cmp_res = alu_result[2][0]; 
assign gpi_main = gpi;
assign gpo = gpo_main;

//assign gpi_main[4] = 1'b0;
//assign gpi_main[5] = 1'b0;
//assign gpi_main[6] = 1'b0;
//assign gpi_main[7] = 1'b0;
//assign gpo_main[4] = 1'b0;
//assign gpo_main[5] = 1'b0;
//assign gpo_main[6] = 1'b0;
//assign gpo_main[7] = 1'b0;


d_mem data_memory(
    .address(alu_res),
    .data(data_in)
);

i_mem instruction_memory(
    .address(pc_addr),
    .data(instr)
);

decoder decoder_main(
    .d_op(d_op),
    .out(decoder_out)
);

rd_mux rd_mux_main(
    .memory_data(data_in),
    .alu_res(alu_res),
    .rd_op(rd_op),
    .data_out(rd_mux_out)
);

pc_mux pc_mux_main(
    .pc_addr_plus_1(address),
    .alu_res(alu_res),
    .jump(jump),
    .data_out(pc_mux_out)  
  );
  

genvar iteration;
generate
for (iteration=0; iteration<4; iteration = iteration+1) //przypisanie jednego z szeœciu podstawowych rejestrów
begin
    register register_iteration(
        .clk(clk),
        .ce(decoder_out[iteration]),
        .data_in(rd_mux_out),
        .data_out(data_register_out[iteration])  
        );
end
endgenerate

register register_4(
    .clk(clk),
    .ce(decoder_out[4]),
    .data_in(rd_mux_out),
    .data_out(gpo_main)
);
register register_5(
    .clk(clk),
    .ce(gpi_main <= 8'b11111111 ? 1'b1 : 1'b0),
    .data_in(gpi_main),
    .data_out(data_register_out[5])
);

register register_6(
    .clk(clk),
    .ce(decoder_out[6]),
    .data_in(8'd0),
    .data_out(data_register_out[6])
  );

register register_7(
    .clk(clk),
    .ce(1'b1),
    .data_in(pc_mux_out),
    .data_out(data_register_out[7])
);

jump jump_main(
    .pc_op(pc_op),
    .cmp_res(cmp_res),
    .data_out(jump)
);

rx_mux rx_mux_main(
    .r0(data_register_out[0]),
    .r1(data_register_out[1]),
    .r2(data_register_out[2]),
    .r3(data_register_out[3]),
    .r4(data_register_out[4]),
    .r5(data_register_out[5]),
    .r6(data_register_out[6]),
    .r7(data_register_out[7]),
    .rx_op(rx_op),
    .data_out(rx_out)
);
    
ry_mux ry_mux1(
    .r0(data_register_out[0]),
    .r1(data_register_out[1]),
    .r2(data_register_out[2]),
    .r3(data_register_out[3]),
    .r4(data_register_out[4]),
    .r5(data_register_out[5]),
    .r6(data_register_out[6]),
    .r7(data_register_out[7]),
    .ry_op(ry_op),
    .data_out(ry_out)
);

imm_mux imm_mux_main(
    .imm(imm),
    .ry_out(ry_out),
    .imm_op(imm_op),
    .data_out(imm_out)
);
 
alu alu_main(
    .rx_mux(rx_out),
    .ry_mux(imm_out),
    .and_gate(alu_result[0]),
    .compare(alu_result[2]),
    .sum(alu_result[1])
);

alu_mux alu_mux_main(
    .data_and(alu_result[0]),
    .data_plus(alu_result[1]),
    .data_compare(alu_result[2]),
    .data_imm(imm_out),
    .alu_op(alu_op),
    .alu_res(alu_res)
  );
  
endmodule
