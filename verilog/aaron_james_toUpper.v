`timescale 1ns/1ps

module toUpper(
    input  wire [7:0] in,
    output wire [7:0] out
);
    wire a1_out, a2_out, a3_out, a4_out;
    wire ni6, ni5, ni4, ni3, ni2, ni1, ni7, ni0;
    
    not #5 n7 (ni7, in[7]);
    not #5  n6 (ni6, in[6]);
    not #5 n5 (ni5, in[5]);
    not #5  n4 (ni4, in[4]);
    not #5  n3 (ni3, in[3]);
    not #5  n2 (ni2, in[2]);
    not #5  n1 (ni1, in[1]);
    not #5 n0 (ni0, in[0]);


    and #10  a1 (a1_out, ni7,ni6,in[5]);
    and #10 a2 (a2_out, in[7], in[5]);
    and #10 a3 (a3_out, ni7,in[6], in[5],  ni4, ni3, ni2, ni1,ni0);
    and #10 a4(a4_out, ni7, in[5], in[6], in[4], in[3], in[2]);
    and #10 a5(a5_out,ni7, in[6], in[5], in[4], in[3], ni2, in[1], in[0]);



    
    or #10  o1 (out[5], a1_out, a2_out, a3_out, a4_out, a5_out);



    buf #4 b0 (out[0], in[0]);
    buf #4 b1 (out[1], in[1]);
    buf #4 b2 (out[2], in[2]);
    buf #4 b3 (out[3], in[3]);
    buf #4 b4 (out[4], in[4]);
    buf #4 b6 (out[6], in[6]);
    buf #4 b7 (out[7], in[7]);

endmodule

