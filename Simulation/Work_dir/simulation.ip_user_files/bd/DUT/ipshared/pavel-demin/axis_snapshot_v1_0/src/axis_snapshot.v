
`timescale 1 ns / 1 ps

module axis_snapshot #
(
  parameter integer AXIS_TDATA_WIDTH = 32 
//,  parameter         EXT_M_TREADY = "FALSE"
)
(
  // System signals
  input  wire                        aclk,
  input  wire                        aresetn,

    // Slave side
  input wire [AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire                        s_axis_tvalid,
  output wire                       s_axis_tready,
  
  
    // Master side
  // input wire m_axis_tready,

  output wire [AXIS_TDATA_WIDTH-1:0] data 

 

);
 
reg [AXIS_TDATA_WIDTH-1:0] int_data_reg;
reg int_enbl_reg, int_enbl_next;

always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_data_reg <= {(AXIS_TDATA_WIDTH-1){1'b0}};
      int_enbl_reg <= 1'b0;
    end
    else
    begin
	 if(~int_enbl_reg & s_axis_tvalid)
	   begin
           int_enbl_reg <= 1'b1;
		int_data_reg <= s_axis_tdata;
	   end		
	 else 
        begin 
		int_enbl_reg <= int_enbl_reg;
		int_data_reg <= int_data_reg;
        end
    end
  end
//if(EXT_M_TREADY == "TRUE")
//  assign s_axis_tready = m_axis_tready;
//else
  assign s_axis_tready = 1'b1; 
  assign data = int_data_reg; 
endmodule
