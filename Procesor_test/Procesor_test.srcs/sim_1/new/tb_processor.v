`timescale 1ns / 1ps
module tb_processor
();
reg clk = 1'b0;
initial 
    begin
        while(1)
        begin
            #1 clk=1'b0;
            #1 clk=1'b1;
        end
    end

wire [7:0]leds;

main testbench(
.clk(clk),
.gpi(leds[7:4]),
.gpo(leds[3:0])
);
    
endmodule