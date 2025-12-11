
module counter #(parameter N = 27)(
    input logic clk,
    input logic rst,
    input logic en,
    output logic tic
    );
    
    logic [N-1:0] count, ncount; 
    
    always_ff@(posedge(clk), posedge(rst))
        if(rst) 
            count <= 0; 
        else 
            count <= ncount; 
    always_comb 
    begin
    if (en)
        //xxxx// do counter thing
        ncount = count +1 ; 
    else 
        
        ncount<= count; 
    end
    assign tic = (count ==1); 
endmodule
