`timescale 1ns / 1ps


module DataMemory(input clk, input rst, input en, output reg [31:0] A, output reg [31:0] B);
     reg [3:0] i;

    always @(posedge rst or posedge en)
        begin
            if (rst)
                i = 4'b0000;
            else if(i == 4'b1001)
                i = 4'b0000;
            else
                i = i + 1;
        end
 
     always @(*)
                begin
                    case(i)
                        4'b0000:
                            begin
                                A = 32'h3f800000;
                                B = 32'h40000000;
                            end
                        4'b0001:
                            begin
                                A = 32'hbf800000;
                                B = 32'h3f800000;
                            end
                        4'b0010:
                            begin
                                A = 32'hc2de8000;
                                B = 32'h45155e00;
                            end
                        4'b0011:
                            begin
                                A = 32'h6b64b235;
                                B = 32'h6ac49214;
                            end
                        4'b0100:
                            begin
                                A = 32'h2ac49214;
                                B = 32'h6ac49214;
                            end
                        4'b0101:
                            begin
                                A = 32'hbfc66666;
                                B = 32'h3fc7ae14;
                            end
                        4'b0110:
                            begin
                                A = 32'hc565ee8b;
                                B = 32'h4565ee8a;
                            end
                        4'b0111:
                            begin
                                A = 32'h447a4efa;
                                B = 32'hc47a1ccd;
                            end
                        4'b1000:
                            begin
                                A = 32'h00000000;
                                B = 32'h00000000;
                            end
                        4'b1001:
                            begin
                                A = 32'h38108900;
                                B = 32'hbb908900;
                            end
                endcase
            end
endmodule
