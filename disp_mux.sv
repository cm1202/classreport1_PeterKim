`timescale 1ns / 1ps

// This module is based on the design in Chapter 4 disp_mux
module disp_mux (
    input  logic clk, reset,
    input  logic [7:0] in0, in1, in2, in3, 
    output logic [3:0] an,              
    output logic [7:0] sseg             
);

    localparam N = 18; 

    logic [N-1:0] q_reg;
    logic [N-1:0] q_next;

    always_ff @(posedge clk, posedge reset)
        if (reset)
            q_reg <= '0;
        else
            q_reg <= q_next;

    assign q_next = q_reg + 1;


    always_comb
        case (q_reg[N-1:N-2])
            2'b00: 
            begin 
                sseg = in0;
                an = 4'b1110;
            end
            2'b01: 
            begin
                sseg = in1;
                an = 4'b1101;
            end
            2'b10: 
            begin
                sseg = in2;
                an = 4'b1011;
            end
            default:
            begin
                sseg = in3; 
                an = 4'b0111; 
            end 
        endcase
    
endmodule

