`timescale 1ns / 1ps

module name_generator (
    input wire clk,      
    input wire rst,       
    output reg [7:0] char_out 
);

    reg [2:0] counter; // 3-bit counter to cycle from 0 to 3

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 3'd0;
            char_out <= 8'd0; // Output nothing (Null) during reset
        end else begin
            // Act like a small ROM to output the correct letter
            case (counter)
                3'd0: char_out <= "E"; 
                3'd1: char_out <= "X"; 
                3'd2: char_out <= "A"; 
                3'd3: char_out <= "M"; 
                3'd4: char_out <= "P";
                3'd5: char_out <= "L";
                3'd6: char_out <= "E";
                default: char_out <= 8'd0;
            endcase

            // Update the counter
            if (counter == 3'd6) begin
                counter <= 3'd0; // Reset counter after the last letter
            end else begin
                counter <= counter + 1; // Move to the next letter
            end
        end
    end

endmodule