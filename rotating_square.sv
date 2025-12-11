`timescale 1ns / 1ps

module rotating_square(
    input logic clk,
    input logic rst,
    input logic en,
    input logic cw,
    output logic [3:0] an,
    output logic [7:0] sseg 
    ); 
    
    parameter TOP    = 8'b10011100;
    parameter BOTTOM = 8'b10100011;
    
    logic tic; 
  
    counter counter(
        .clk(clk),
        .rst(rst),
        .en(en),
        .tic(tic) 
    );
        
    logic [2:0] state,nstate; 
   
    always_ff @(posedge tic, posedge rst) begin
        if(rst) begin
            state <= 3'b000;
        end
        else begin
            state <= nstate; 
        end
     end
        always_comb begin
            if(cw) begin
                nstate = state + 1;
            end  
            else begin
                nstate = state - 1; 
           end 
        end
        
    
 
    always_comb begin
        case(state)
            3'b000: begin 
                an = 4'b1110; 
                sseg = TOP;
            end
            3'b001: begin
                an = 4'b1110;
                sseg = BOTTOM; 
            end 
            3'b010: begin 
                an = 4'b1101; 
                sseg = BOTTOM;
            end
            3'b011: begin 
                an = 4'b1011; 
                sseg = BOTTOM;
            end
            3'b100: begin 
                an = 4'b0111; 
                sseg = BOTTOM;
            end
            3'b101: begin 
                an = 4'b0111; 
                sseg = TOP;
            end
            3'b110: begin 
                an = 4'b1011; 
                sseg = TOP;
            end
            3'b111: begin 
                an = 4'b1101; 
                sseg = TOP; 
            end
            default: begin 
                an = 4'b1110; 
                sseg = TOP;
            end
        endcase 
    end           
endmodule