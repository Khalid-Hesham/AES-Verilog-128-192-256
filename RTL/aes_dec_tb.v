`timescale 1ns/1ps

module aes_dec_tb ();

parameter CLK_PERIOD = 11;
parameter KEY_SIZE = 256; // 128, 192, 256

reg clk;
reg start;
reg rst;
reg [127:0] ct;
reg [KEY_SIZE-1:0] key;
wire [127:0] pt;
wire done;

initial begin
  $dumpfile("d.txt");
  $dumpvars;

  // Initialization
  initialize() ;

  // Reset
  reset() ; 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if(KEY_SIZE == 128) begin
    start_task(128'h69_c4_e0_d8_6a_7b_04_30_d8_cd_b7_80_70_b4_c5_5a, 128'h00_01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f);

    @(negedge done) begin
      if(pt == 128'h00_11_22_33_44_55_66_77_88_99_aa_bb_cc_dd_ee_ff)
        $display("TEST1 FOR AES-128 PASSED");
      else
        $display("TEST1 FOR AES-128 FAILED");

      
    #(CLK_PERIOD);
    start_task(128'h29_c3_50_5f_57_14_20_f6_40_22_99_b3_1a_02_d7_3a, 128'h54_68_61_74_73_20_6D_79_20_4B_75_6E_67_20_46_75);
    
    @(negedge done) begin
    if(pt == 128'h54_77_6F_20_4F_6E_65_20_4E_69_6E_65_20_54_77_6F)
      $display("TEST2 FOR AES-128 PASSED");
    else
      $display("TEST2 FOR AES-128 FAILED");
    end
    end
  end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
  if(KEY_SIZE == 192) begin
    start_task(128'hdd_a9_7c_a4_86_4c_df_e0_6e_af_70_a0_ec_0d_71_91, 192'h00_01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f_10_11_12_13_14_15_16_17);

   @(negedge done) begin
    if(pt == 128'h00_11_22_33_44_55_66_77_88_99_aa_bb_cc_dd_ee_ff)
      $display("TEST FOR AES-192 PASSED");
    else
      $display("TEST FOR AES-192 FAILED");
    end
  end
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  if(KEY_SIZE == 256) begin
    start_task(128'h8e_a2_b7_ca_51_67_45_bf_ea_fc_49_90_4b_49_60_89, 256'h00_01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f_10_11_12_13_14_15_16_17_18_19_1a_1b_1c_1d_1e_1f);

   @(negedge done) begin
    if(pt == 128'h00_11_22_33_44_55_66_77_88_99_aa_bb_cc_dd_ee_ff)
      $display("TEST FOR AES-256 PASSED");
    else
      $display("TEST FOR AES-256 FAILED");
   end
  end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  #(2*CLK_PERIOD);
  $stop;
end


/////////////// Signals Initialization //////////////////

task initialize ;
  begin
  clk <= 1'b0;
  rst <= 1'b1;
  start <= 1'b0;
  ct <=  'b0;
  key <= 'b0;
  end
endtask

///////////////////////// RESET /////////////////////////
task reset ;
  begin
  #(CLK_PERIOD/2.0);
  rst <= 1'b0;
  #(CLK_PERIOD/2.0);
  rst <= 1'b1;
  end
endtask

///////////////////////// START /////////////////////////
task start_task ;
  input [127:0] start_ct;
  input [KEY_SIZE-1:0] start_key;
  begin
  start <= 1'b1;
  ct <= start_ct;
  key <= start_key;
  #(CLK_PERIOD);
  start <= 1'b0;
  end
endtask


//////////////////  Clock Generation  /////////////////////
always #(CLK_PERIOD/2.0) clk = ~clk;



//////////////////  AES Instantiation  ////////////////////
aes_dec #(.KEY_SIZE(KEY_SIZE)) aes (

.clk(clk),
.start(start),
.rst(rst),
.pt(pt),
.key(key),
.ct(ct),
.done(done)

);




endmodule