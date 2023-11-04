module dvi_transmitter_top(
    input        pclk,           // pixel clock
    input        rst_n,          // reset

    input [23:0] video_din,      // RGB888 video in
    input        video_hsync,    // hsync data
    input        video_vsync,    // vsync data
    input        video_de,       // data enable
    
    output [9:0] tmds_data0,
    output [9:0] tmds_data1,
    output [9:0] tmds_data2,
    output [9:0] tmds_clk,
    output       tmds_oen        // TMDS 输出使能
    );

//*****************************************************
//**                    main code
//***************************************************** 
assign tmds_oen = 1'b1;  
assign tmds_clk = 10'b1111100000;

//对三个颜色通道进行编码
encode encode_b (
    .clkin      (pclk),
    .rstin	    (~rst_n),
    .din        (video_din[7:0]),
    .c0			(video_hsync),
    .c1			(video_vsync),
    .de			(video_de),
    .dout		(tmds_data0)
    ) ;

encode encode_g (
    .clkin      (pclk),
    .rstin	    (~rst_n),
    .din		(video_din[15:8]),
    .c0			(1'b0),
    .c1			(1'b0),
    .de			(video_de),
    .dout		(tmds_data1)
    ) ;
    
encode encode_r (
    .clkin      (pclk),
    .rstin	    (~rst_n),
    .din		(video_din[23:16]),
    .c0			(1'b0),
    .c1			(1'b0),
    .de			(video_de),
    .dout		(tmds_data2)
    ) ;
  
endmodule