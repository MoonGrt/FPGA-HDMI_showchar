module  hdmi_tx(
	output tmds_clk_TX_OE,
    output [9:0] tmds_clk_TX_DATA,
    output tmds_clk_TX_RST,
    output tmds_data0_TX_OE,
    output [9:0] tmds_data0_TX_DATA,
    output tmds_data0_TX_RST,
  	output tmds_data1_TX_OE,
  	output [9:0] tmds_data1_TX_DATA,
  	output tmds_data1_TX_RST,
  	output tmds_data2_TX_OE,
  	output [9:0] tmds_data2_TX_DATA,
  	output tmds_data2_TX_RST,

    input        hdmi_clk,    
    output       hpd,
    input        hdmi_pll_LOCKED
);

wire [6:0] ascii;
wire [511:0] char_data;

//wire define
wire rst_n = hdmi_pll_LOCKED; // pll

wire [10:0] pixel_xpos_w;
wire [10:0] pixel_ypos_w;
wire [23:0] pixel_data_w;

wire        video_hs;
wire        video_vs;
wire        video_de;
wire [23:0] video_rgb;

wire [9:0] tmds_data0;
wire [9:0] tmds_data1;
wire [9:0] tmds_data2;
wire [9:0] tmds_clk;

assign tmds_data0_TX_OE = 1'b1;
assign tmds_data1_TX_OE = 1'b1;
assign tmds_data2_TX_OE = 1'b1;
assign tmds_clk_TX_OE   = 1'b1;

assign tmds_data0_TX_RST = 1'b0;
assign tmds_data1_TX_RST = 1'b0;
assign tmds_data2_TX_RST = 1'b0;
assign tmds_clk_TX_RST   = 1'b0;

assign tmds_clk_TX_DATA   = ~tmds_clk;
assign tmds_data0_TX_DATA = ~tmds_data0;
assign tmds_data1_TX_DATA = ~tmds_data1;
assign tmds_data2_TX_DATA = ~tmds_data2;

//*****************************************************
//**                    main code
//*****************************************************

video_display #(
    .H_DISP     (11'd800),
    .V_DISP     (11'd480),
    .CHAR_WIDTH (6'd16),
    .CHAR_HEIGHT(6'd32))
video_display(
    .pixel_clk      (hdmi_clk),
    .sys_rst_n      (rst_n),
    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w),
    .char_data      (char_data),
    .ascii          (ascii)
);

video_driver #(
    .H_SYNC     (11'd128),     //行同步
    .H_BACK     (11'd88),      //行显示后沿
    .H_DISP     (11'd800),     //行有效数据
    .H_FRONT    (11'd40),      //行显示前沿
    .H_TOTAL    (11'd1056),    //行扫描周期
    .V_SYNC     (11'd3),       //场同步
    .V_BACK     (11'd21),      //场显示后沿
    .V_DISP     (11'd480),     //场有效数据
    .V_FRONT    (11'd1),       //场显示前沿
    .V_TOTAL    (11'd505))
video_driver(
    .pixel_clk      (hdmi_clk),
    .sys_rst_n      (rst_n),
    .video_hs       (video_hs),
    .video_vs       (video_vs),
    .video_de       (video_de),
    .video_rgb      (video_rgb),
	.data_req		(),
    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
	.pixel_data     (pixel_data_w)
);

//HDMI驱动模块
dvi_transmitter_top dvi_transmitter_top(
    .pclk           (hdmi_clk),
    .rst_n          (rst_n),
                
    .video_din      (video_rgb),
    .video_hsync    (video_hs), 
    .video_vsync    (video_vs),
    .video_de       (video_de),
                
    .tmds_clk       (tmds_clk),
    .tmds_data0     (tmds_data0),
    .tmds_data1     (tmds_data1),
    .tmds_data2     (tmds_data2),
    .tmds_oen       (hpd)
);

//ram_char ram_char (
///*i*/.raddr	(ascii),
///*o*/.rdata (char_data)
//);

ram_char1 #(
	.DATA_WIDTH(512),
	.ADDR_WIDTH(7),
	.RAM_INIT_FILE("ram_init_file.inithex")
)ram_char1(
	.raddr (ascii),   
	.rdata (char_data)
);

endmodule 