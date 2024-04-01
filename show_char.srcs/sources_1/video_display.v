module video_display
#(
    parameter H_DISP = 11'd800,        //分辨率--行
    parameter V_DISP = 11'd480,        //分辨率--列
    parameter CHAR_WIDTH  = 6'd16,     //字符宽度
    parameter CHAR_HEIGHT = 6'd32      //字符高度
)(
    input                pixel_clk,
    input                sys_rst_n,
    
    input        [10:0]  pixel_xpos,  //像素点横坐标
    input        [10:0]  pixel_ypos,  //像素点纵坐标 
    output  reg  [23:0]  pixel_data,  //像素点数据

    input        [511:0] char_data,
    output  wire [6:0]   ascii
);

//parameter define
localparam WHITE  = 24'b11111111_11111111_11111111;  //RGB888 白色
localparam BLACK  = 24'b00000000_00000000_00000000;  //RGB888 黑色
localparam RED    = 24'b11111111_00000000_00000000;  //RGB888 红色
localparam GREEN  = 24'b00000000_11111111_00000000;  //RGB888 绿色
localparam BLUE   = 24'b00000000_00000000_11111111;  //RGB888 蓝色

// string
reg [6:0] string[50:1];

//*****************************************************
//**                    main code
//*****************************************************
assign ascii = string[pixel_xpos/CHAR_WIDTH+1];

//根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
always @(posedge pixel_clk ) begin
    if (!sys_rst_n)
        pixel_data <= 16'd0;
    else begin
        if((pixel_ypos >= 0) && (pixel_ypos < (V_DISP/5)*1))
            // pixel_data <= WHITE;
            if(char_data[511 - ((pixel_xpos) % CHAR_WIDTH) - ((pixel_ypos) % CHAR_HEIGHT) * CHAR_WIDTH])
                pixel_data <= WHITE;
            else
                pixel_data <= BLACK;
        else if((pixel_ypos >= (V_DISP/5)*1) && (pixel_ypos < (V_DISP/5)*2))
            pixel_data <= RED;  
        else if((pixel_ypos >= (V_DISP/5)*2) && (pixel_ypos < (V_DISP/5)*3))
            pixel_data <= GREEN;  
        else if((pixel_ypos >= (V_DISP/5)*3) && (pixel_ypos < (V_DISP/5)*4))
            pixel_data <= BLUE;
        else 
            pixel_data <= WHITE;
    end
end

initial
begin
	string[ 1] = 7'd34;
	string[ 2] = 7'd35;
	string[ 3] = 7'd36;
	string[ 4] = 7'd37;
	string[ 5] = 7'd38;
	string[ 6] = 7'd39;
	string[ 7] = 7'd40;
	string[ 8] = 7'd41;
	string[ 9] = 7'd42;
	string[10] = 7'd43;
	string[11] = 7'd44;
	string[12] = 7'd45;
	string[13] = 7'd46;
	string[14] = 7'd47;
	string[15] = 7'd48;
	string[16] = 7'd49;
	string[17] = 7'd50;
	string[18] = 7'd51;
	string[19] = 7'd52;
	string[20] = 7'd53;
	string[21] = 7'd54;
	string[22] = 7'd55;
	string[23] = 7'd56;
	string[24] = 7'd57;
	string[25] = 7'd58;
	string[26] = 7'd59;
	string[27] = 7'd60;
	string[28] = 7'd61;
	string[29] = 7'd62;
	string[30] = 7'd63;
	string[31] = 7'd64;
	string[32] = 7'd65;
	string[33] = 7'd66;
	string[34] = 7'd67;
	string[35] = 7'd68;
	string[36] = 7'd69;
	string[37] = 7'd70;
	string[38] = 7'd71;
	string[39] = 7'd72;
	string[40] = 7'd73;
	string[41] = 7'd74;
	string[42] = 7'd75;
	string[43] = 7'd76;
	string[44] = 7'd77;
	string[45] = 7'd78;
	string[46] = 7'd79;
	string[47] = 7'd80;
	string[48] = 7'd81;
	string[49] = 7'd82;
	string[50] = 7'd82;
end

endmodule
