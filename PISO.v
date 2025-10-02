module PISO #(parameter n = 4) (
    input i_clk,
    input i_rst,
    input i_load,
    input [n-1:0] i_parallel_in,
    output reg o_serial_out
);

    reg [n-1:0] r_shift_reg;

    always @(posedge i_clk or posedge i_rst) begin 
        if (i_rst) begin
            r_shift_reg <= 0;  // Reset shift register
            o_serial_out <= 0; // Reset output
        end 
        else if (i_load) begin
            r_shift_reg <= i_parallel_in; // Load parallel data
        end
        else begin
            o_serial_out <= r_shift_reg[n-1]; // Output MSB first
            r_shift_reg <= {r_shift_reg[n-2:0], 1'b0}; // Shift left
        end
    end

endmodule
