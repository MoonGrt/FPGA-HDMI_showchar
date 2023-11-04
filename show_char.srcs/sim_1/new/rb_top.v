`timescale  1ns / 1ps       
`default_nettype none
module tb_top;

reg   hdmi_clk = 0 ;
reg   hdmi_pll_LOCKED = 0 ;

// hdmi_tx Outputs
wire  tmds_clk_TX_OE                       ;
wire  [9:0]  tmds_clk_TX_DATA              ;
wire  tmds_clk_TX_RST                      ;
wire  tmds_data0_TX_OE                     ;
wire  [9:0]  tmds_data0_TX_DATA            ;
wire  tmds_data0_TX_RST                    ;
wire  tmds_data1_TX_OE                     ;
wire  [9:0]  tmds_data1_TX_DATA            ;
wire  tmds_data1_TX_RST                    ;
wire  tmds_data2_TX_OE                     ;
wire  [9:0]  tmds_data2_TX_DATA            ;
wire  tmds_data2_TX_RST                    ;
wire  hpd                                  ;

always #10 hdmi_clk = ~hdmi_clk; // 40mhz
initial #100 hdmi_pll_LOCKED = 1;

hdmi_tx  u_hdmi_tx (
    .hdmi_clk                ( hdmi_clk                  ),
    .hdmi_pll_LOCKED         ( hdmi_pll_LOCKED           ),

    .tmds_clk_TX_OE          ( tmds_clk_TX_OE            ),
    .tmds_clk_TX_DATA        ( tmds_clk_TX_DATA    [9:0] ),
    .tmds_clk_TX_RST         ( tmds_clk_TX_RST           ),
    .tmds_data0_TX_OE        ( tmds_data0_TX_OE          ),
    .tmds_data0_TX_DATA      ( tmds_data0_TX_DATA  [9:0] ),
    .tmds_data0_TX_RST       ( tmds_data0_TX_RST         ),
    .tmds_data1_TX_OE        ( tmds_data1_TX_OE          ),
    .tmds_data1_TX_DATA      ( tmds_data1_TX_DATA  [9:0] ),
    .tmds_data1_TX_RST       ( tmds_data1_TX_RST         ),
    .tmds_data2_TX_OE        ( tmds_data2_TX_OE          ),
    .tmds_data2_TX_DATA      ( tmds_data2_TX_DATA  [9:0] ),
    .tmds_data2_TX_RST       ( tmds_data2_TX_RST         ),
    .hpd                     ( hpd                       )
);

endmodule