module Traffic_Light_Control_System(
    input Clk,
    input Reset,
    output reg [2:0] North,
    output reg [2:0] South,
    output reg [2:0] East,
    output reg [2:0] West
    );
    
parameter [2:0] n_go=3'b000, n_gr=3'b001, s_go=3'b010, s_gr=3'b011, e_go=3'b100, e_gr=3'b101, w_go=3'b110, w_gr=3'b111;
reg [2:0] state=n_go;
reg [3:0] count=4'b0000;

always @ (posedge Clk or posedge Reset) begin
    if (Reset==1) begin
        state=n_go;
        count=4'b0000;
    end
    else begin
        case (state) 
            n_go: begin
                if (count==4'b1111) begin
                    count=4'b0000;
                    state=n_gr;
                end
                else count=count+4'b0001;
            end
            n_gr: begin
                if (count==4'b0011) begin
                    count=4'b0000;
                    state=w_go;
                end
                else count=count+4'b0001;
            end
            w_go: begin
                if (count==4'b1111) begin
                    count=4'b0000;
                    state=w_gr;
                end
                else count=count+4'b0001;
            end
            w_gr: begin
                if (count==4'b0011) begin
                    count=4'b0000;
                    state=s_go;
                end
                else count=count+4'b0001;
            end
            s_go: begin
                if (count==4'b1111) begin
                    count=4'b0000;
                    state=s_gr;
                end
                else count=count+4'b0001;
            end
            s_gr: begin
                if (count==4'b0011) begin
                    count=4'b0000;
                    state=e_go;
                end
                else count=count+4'b0001;
            end
            e_go: begin
                if (count==4'b1111) begin
                    count=4'b0000;
                    state=e_gr;
                end
                else count=count+4'b0001;
            end
            e_gr: begin
                if (count==4'b0011) begin
                    count=4'b0000;
                    state=n_go;
                end
                else count=count+4'b0001;
            end
        endcase
    end
end  
    
// 001 - red, 010 - yellow, 100 - green

always @ (state) begin
    case (state)
        n_go: begin
            North=3'b100;
            South=3'b001;
            East=3'b001;
            West=3'b001;
        end
        n_gr: begin
            North=3'b010;
            South=3'b001;
            East=3'b001;
            West=3'b001;
        end
        s_go: begin
            North=3'b001;
            South=3'b100;
            East=3'b001;
            West=3'b001;
        end
        s_gr: begin
            North=3'b001;
            South=3'b010;
            East=3'b001;
            West=3'b001;
        end
        e_go: begin
            North=3'b001;
            South=3'b001;
            East=3'b100;
            West=3'b001;
        end
        e_gr: begin
            North=3'b001;
            South=3'b001;
            East=3'b010;
            West=3'b001;
        end
        w_go: begin
            North=3'b001;
            South=3'b001;
            East=3'b001;
            West=3'b100;
        end
        w_gr: begin
            North=3'b001;
            South=3'b001;
            East=3'b001;
            West=3'b010;
        end
    endcase
end    
    
endmodule
