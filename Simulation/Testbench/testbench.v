`timescale 1ns/1ps

module testbench;
   reg clk;
   reg reset;
   wire [15:0]m_axis_tdata;
   wire m_axis_tvalid;
   reg m_axis_tready;
   // Clock gen
   initial begin
      clk = 1'b0;
      forever clk = #4 ~clk;
   end
 
   // reset logic
   initial begin
      m_axis_tready = 1'b0;
      reset = 1'b0;
      #50 reset = 1'b0;
      #32 m_axis_tready = 1'b1;
   end
   
  //DUT test
   initial begin
       repeat(1000) @(negedge clk);
       $finish;
   end     
   
   //DUT
   DUT DUT_1 (
       .aclk(clk),
       .M_AXIS_tdata(m_axis_tdata),
       .M_AXIS_tready(m_axis_tready),
       .M_AXIS_tvalid(m_axis_tvalid)
   );
  endmodule // testbench