
`timescale 1ns/1ps

module toUpper_tb;
	reg [7:0] in;
	wire [7:0] out;

	toUpper dut (.in(in), .out(out));

	reg [7:0] vectors [0:18];

	integer i;

	initial begin
		// Fill vectors
		vectors[0]  = 8'd40;   // 00101000  '('
		vectors[1]  = 8'd72;   // 01001000  'H'
		vectors[2]  = 8'd183;  // 10110111  '·'
		vectors[3]  = 8'd131;  // 10000011  'ƒ'
		vectors[4]  = 8'd124;  // 01111100  '|'
		vectors[5]  = 8'd20;   // 00010100  'DC4'
		vectors[6]  = 8'd235;  // 11101011  'ë'
		vectors[7]  = 8'd97;   // 01100001  'a'
		vectors[8]  = 8'd65;   // 01000001  'A'
		vectors[9]  = 8'd122;  // 01111010  'z'
		vectors[10] = 8'd71;   // 01000111  'G'
		vectors[11] = 8'd109;  // 01101101  'm'
		vectors[12] = 8'd146;  // 10010010  '\'
		vectors[13] = 8'd48;   // 00110000  '0'
		vectors[14] = 8'd207;  // 11001111  'Ï'
		vectors[15] = 8'd58;   // 00111010  ':'
		vectors[16] = 8'd123;  // 01111011  '{'
		vectors[17] = 8'd148;  // 10000100  '”'
		vectors[18] = 8'd127;  // 01111111  'DEL'

		$dumpfile("toUpper_tb.vcd");
		$dumpvars(0, toUpper_tb);

		$display("time ns |  in(dec) in(bin)  in(char) | out(dec) out(bin) out(char)");
		$display("---------------------------------------------------------------------");

		for (i = 0; i < 19; i = i + 1) begin
			in = vectors[i];
			#25.001; // wait for circuit
			$display("%4dns | %7d %b %s | %7d %b %s", $time, in, in, format_char(in), out, out, format_char(out));
		end

		$display("Test complete.");
		$finish;
	end

	function [8*4:1] format_char; 
		input [7:0] b;
		begin
			if (b >= 8'd32 && b <= 8'd126) begin
				format_char = {1'b0, b};
			end else begin
				case (b)
					8'd127: format_char = "DEL";
					8'd20:  format_char = "DC4";
					default: format_char = ".";
				endcase
			end
		end
	endfunction

endmodule
