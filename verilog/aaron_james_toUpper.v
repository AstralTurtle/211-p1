module toUpper(
    input  wire [7:0] in,
    output wire [7:0] out
);
    wire a1_out, a2_out, a3_out, a4_out;
    wire ni6, ni5, ni4, ni3, ni2, ni1, ni0;
    
    not n7 (ni7, in[7])
    not  n6 (ni6, in[6]);
    not  n4 (ni4, in[4]);
    not  n3 (ni3, in[3]);
    not  n2 (ni2, in[2]);
    not  n1 (ni1, in[1]);

    and  a1 (a1_out, ni7,ni6,ni5);
    and a2 (a2_out, in[5], in[0], ni4, ni3, ni2, ni1);
    and a3 (a3_out, in[7], in[5]);
    and a4(a4_out, in[5], in[6], in[4], in[3], in[2]);



    
    or  o1 (out[5], a1_out, a2_out, a3_out, a4_out);



    buf b0 (out[0], in[0]);
    buf b1 (out[1], in[1]);
    buf b2 (out[2], in[2]);
    buf b3 (out[3], in[3]);
    buf b4 (out[4], in[4]);
    buf b6 (out[6], in[6]);
    buf b7 (out[7], in[7]);

endmodule
