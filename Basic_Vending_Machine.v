module Basic_Vending_Machine(
    input [1:0] Money,
    input Clk,
    input Reset,
    output reg Z,
    output reg Change
    );
    
    // Rs. 10 - 00, Rs.20 - 01, Rs.50 - 10
    parameter Sin=4'b0000, S10=4'b0001, S20=4'b0010, S50=4'b0011, S30=4'b0100, S40=4'b0101, S70=4'b0110, S60=4'b0111, S80=4'b1000;
    parameter M10=2'b00, M20=2'b01, M50=2'b10; 
    reg [3:0] ps, ns;
    
    always @ (posedge Clk or posedge Reset) begin
        if (Reset==1) ps <=Sin;
        else ps<=ns;
    end
    
    always @ (ps or Money) begin
        case(ps)
            Sin: begin
                if (Money==M10) ns<=S10;
                else if (Money==M20) ns<=S20;
                else ns<=S50;
            end
            S10: begin
                if (Money==M10) ns<=S20;
                else if (Money==M20) ns<=S30;
                else ns<=S60;
            end
            S20: begin
                if (Money==M10) ns<=S30;
                else if (Money==M20) ns<=S40;
                else ns<=S70;
            end
            S30: begin
                if (Money==M10) ns<=S40;
                else if (Money==M20) ns<=S50;
                else ns<=S80;
            end
            S40: ns<=Sin;
            S50: ns<=Sin;
            S60: ns<=Sin;
            S70: ns<=Sin;
            S80: ns<=Sin;
        endcase
    end
    
    always @ (Money or ps) begin
        case (ps)
            Sin: begin
                Z=0; Change=0;
            end
            S10: begin
                Z=0; Change=0;
            end
            S20: begin
                Z=0; Change=0;
            end
            S50: begin
                Z=0; Change=0;
            end
            S30: begin
                Z=0; Change=0;
            end
            S40: begin
                Z=1; Change=0;
            end
            S50: begin
                Z=1; Change=1;
            end
            S60: begin
                Z=1; Change=1;
            end
            S70: begin
                Z=1; Change=1;
            end
            S80: begin
                Z=1; Change=1;
            end
        endcase
    end
    
endmodule
