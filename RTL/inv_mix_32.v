module inv_mix_32 (
  input [31:0] in_col,
  output [31:0] out_col
);

wire [7:0] a0,a1,a2,a3;
wire [7:0] b0,b1,b2,b3;
wire [7:0] b [0:15];

assign a0 = in_col[31:24];
assign a1 = in_col[23:16];
assign a2 = in_col[15:8];
assign a3 = in_col[7:0];


// Using M_General Blocks
// M_General mul00(8'd14 , a0 , b[0]);
// M_General mul01(8'd11 , a1 , b[1]);
// M_General mul02(8'd13 , a2 , b[2]);
// M_General mul03(8'd9  , a3 , b[3]);
// M_General mul13(8'd9  , a0 , b[4]);
// M_General mul10(8'd14 , a1 , b[5]);
// M_General mul11(8'd11 , a2 , b[6]);
// M_General mul12(8'd13 , a3 , b[7]);
// M_General mul22(8'd13 , a0 , b[8]);
// M_General mul23(8'd9  , a1 , b[9]);
// M_General mul20(8'd14 , a2 , b[10]);
// M_General mul21(8'd11 , a3 , b[11]);
// M_General mul31(8'd11 , a0 , b[12]);
// M_General mul32(8'd13 , a1 , b[13]);
// M_General mul33(8'd9  , a2 , b[14]);
// M_General mul30(8'd14 , a3 , b[15]);


// Using M Blocks
M14 mul00(a0 , b[0]);
M11 mul01(a1 , b[1]);
M13 mul02(a2 , b[2]);
M9  mul03(a3 , b[3]);
M9  mul13(a0 , b[4]);
M14 mul10(a1 , b[5]);
M11 mul11(a2 , b[6]);
M13 mul12(a3 , b[7]);
M13 mul22(a0 , b[8]);
M9  mul23(a1 , b[9]);
M14 mul20(a2 , b[10]);
M11 mul21(a3 , b[11]);
M11 mul31(a0 , b[12]);
M13 mul32(a1 , b[13]);
M9  mul33(a2 , b[14]);
M14 mul30(a3 , b[15]);


assign b0 = b[0] ^ b[1] ^ b[2] ^ b[3];
assign b1 = b[4] ^ b[5] ^ b[6] ^ b[7];
assign b2 = b[8] ^ b[9] ^ b[10] ^ b[11];
assign b3 = b[12] ^ b[13] ^ b[14] ^ b[15];


assign out_col = {b0,b1,b2,b3};





endmodule
