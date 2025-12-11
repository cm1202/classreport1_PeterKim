module wrapper( 
    input CLK100MHZ, 
    input [15:0] SW, 
    input BTNC, 
    output [7:0] AN,
    output logic CA, 
    output logic CB, 
    output logic CC, 
    output logic CD, 
    output logic CE, 
    output logic CF, 
    output logic CG, 
    output logic DP
    );
        

    logic [7:0] sseg; 
    
    assign CA = sseg[0];
    assign CB = sseg[1];
    assign CC = sseg[2];
    assign CD = sseg[3];
    assign CE = sseg[4];
    assign CF = sseg[5];
    assign CG = sseg[6]; 
    assign DP = sseg[7];
    
    logic [3:0] an; 
    assign AN[3:0] = an; 
    assign AN[7:4] = 4'b1111; 
     
    rotating_square rotating_square( 
        .clk(CLK100MHZ), 
        .rst(BTNC),
        .en(SW[0]),
        .cw(SW[1]),
        .an(an),
        .sseg(sseg)
        );
    

    

    

endmodule