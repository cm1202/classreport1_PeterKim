`timescale 1ms / 1us

module dut_rotating_square;

    localparam T = 20; // Clock period of 20ms 
    logic clk   = 1'b0;
    logic reset = 1'b1; // Start with the circuit in reset
    logic en    = 1'b0; // Start with rotation disabled
    logic cw    = 1'b0; // Default to counter-clockwise
    logic [3:0] an;   
    logic [7:0] sseg;

    rotating_square dut (
        .clk(clk),
        .reset(reset),
        .en(en),      
        .cw(cw),
        .an(an),
        .sseg(sseg)
    );

    //probe to observe ssepats assignment 
    logic [7:0] sseg_pats_0_probe;
    logic [7:0] sseg_pats_1_probe;
    logic [7:0] sseg_pats_2_probe;
    logic [7:0] sseg_pats_3_probe;

    assign sseg_pats_0_probe = dut.sseg_pats_0;
    assign sseg_pats_1_probe = dut.sseg_pats_1;
    assign sseg_pats_2_probe = dut.sseg_pats_2;
    assign sseg_pats_3_probe = dut.sseg_pats_3;


    always #(T/2) clk = ~clk; //initiate clk
    initial begin
        #(T);
        reset = 1'b0;
        #(T);
        
        //enable clockwise
        en = 1'b1; 
        cw = 1'b1; 
        #(5000); 
        
        //stop enable to turn off all led 
        en = 1'b0;
        #(5000); 
        
        
        //enable counter clockwise
        en = 1'b1; 
        cw = 1'b0;  
        
        #(5000);
        
        $finish;
    end 
endmodule