module rotating_square (
    input  logic clk, reset,
    input  logic en,        // Enable rotation
    input  logic cw,        // Direction: 1 for Clockwise, 0 for Counter-Clockwise
    output logic [3:0] an,  // Anode enable output for the display
    output logic [7:0] sseg // Segment data output for the display
);

    localparam TOP = 8'b10110000;    // Segments a, b, f, g
    localparam BOT = 8'b11000110;    // Segments c, d, e, g
    localparam BLANK = 8'b11111111;  // All segments off


    localparam MAX_COUNT = 10; // max number to activate tick 


    logic tick;
    logic [3:0] count, ncount; 

    always_ff @(posedge clk, posedge reset)
        if (reset)
            count <= 0;
        else if(count == MAX_COUNT)
            count <= 0; 
        else 
            count <= ncount; 
    always_comb
        if(en)
            ncount = count +1; 
    
        else
            ncount = count; 
    
    assign tick = (count==MAX_COUNT-1);  
    

    logic [2:0] state_reg, state_next;
    logic [7:0] sseg_pats_0, sseg_pats_1, sseg_pats_2, sseg_pats_3;

    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            state_reg <= 0;
        else
            state_reg <= state_next;


    always_comb
    begin
        state_next = state_reg; 
        if (en & tick)        
        begin
            if (cw) // Clockwise
            begin
                if (state_reg == 7)
                    state_next = 0;
                else
                    state_next = state_reg + 1;
            end
            else // Counter-clockwise
            begin
                if (state_reg == 0)
                    state_next = 7;
                else
                    state_next = state_reg - 1;
            end
        end
    end

    always_comb
    begin
        sseg_pats_0 = BLANK;
        sseg_pats_1 = BLANK;
        sseg_pats_2 = BLANK;
        sseg_pats_3 = BLANK;

        case (state_reg)
            0: sseg_pats_3 = TOP;
            1: sseg_pats_2 = TOP;
            2: sseg_pats_1 = TOP;
            3: sseg_pats_0 = TOP;
            4: sseg_pats_0 = BOT;
            5: sseg_pats_1 = BOT;
            6: sseg_pats_2 = BOT;
            7: sseg_pats_3 = BOT;
            default: ; 
        endcase

       
    end

        
    disp_mux disp_unit (
        .clk(clk),
        .reset(reset),
        .in0(sseg_pats_0), // Rightmost digit
        .in1(sseg_pats_1),
        .in2(sseg_pats_2),
        .in3(sseg_pats_3), // Leftmost digit
        .an(an),
        .sseg(sseg)
    );

endmodule