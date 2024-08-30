//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       input logic  [8:0] rand_plat_X [19:0],
                       input logic [8:0] rand_plat_Y [19:0],
                       input logic display_start, display_play, display_gameover, 
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
    logic platform_on_start;
    logic R_platform_start [19:0];

    parameter [9:0] platform_startX_Center=106;  // static platform for now
    parameter [9:0] platform_startY_Center=420;  
    parameter [9:0] platform_start_W=84;
    parameter [9:0] platform_start_H=28; 
    
    parameter [9:0] R_platform_W=84;
    parameter [9:0] R_platform_H=28;
    
    parameter int GRID_SIZE = 10;
    always_comb
    begin: platform_start
        if((DrawX >= platform_startX_Center - platform_start_W/2) && 
        (DrawX <= platform_startX_Center + platform_start_W/2) &&
        (DrawY >= platform_startY_Center - platform_start_H/2) && 
        (DrawY <= platform_startY_Center + platform_start_H/2))
        platform_on_start = 1'b1;
        else
        platform_on_start = 1'b0;
    end
    
    always_comb
    begin: random_platform_generation
        for(int i = 0; i < 20; i++)
        begin
            if((DrawX >= rand_plat_X[i] - R_platform_W/2) &&
               (DrawX <= rand_plat_X[i] + R_platform_W/2) &&
               (DrawY >= rand_plat_Y[i] - R_platform_H/2) &&
               (DrawY <= rand_plat_Y[i] + R_platform_H/2))
                R_platform_start[i] = 1'b1;
             else
                R_platform_start[i] = 1'b0; 
         end
    end
  
    int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
  
    always_comb
    begin:Ball_on_proc
        if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
    
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) begin 
            Red = 4'hf;
            Green = 4'hf;
            Blue = 4'h0;
        end
        else if (display_start && platform_on_start) begin
            Red = 4'h0;  
            Green = 4'hf;
            Blue = 4'h0;
        end
        else if((R_platform_start[0] || R_platform_start[1] || R_platform_start[2] ||
                R_platform_start[3] || R_platform_start[4] || R_platform_start[5] ||
                R_platform_start[6] || R_platform_start[7] || R_platform_start[8] ||
                R_platform_start[9] || R_platform_start[10] || R_platform_start[11] ||
                R_platform_start[12] || R_platform_start[13] || R_platform_start[14] ||
                R_platform_start[15] || R_platform_start[16] || R_platform_start[17] ||
                R_platform_start[18] || R_platform_start[19]) && display_play)begin
            Red = 4'h0;  
            Green = 4'hf;
            Blue = 4'h0;
        end       
        else if ((DrawX % GRID_SIZE == 0) || (DrawY % GRID_SIZE == 0)) begin
            Red = 4'hE;  // Light gray for grid lines
            Green = 4'hE;
            Blue = 4'hE;
        end
        else begin 
            Red = 4'hF;  // White background: Full Red, Green, Blue
            Green = 4'hF;
            Blue = 4'hF;
        end      
    end
  
    

endmodule