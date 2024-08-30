module player
( 
    input  logic        Reset, 
    input  logic        frame_clk,
    input  logic [7:0]  keycode,
    input  logic display_start,
    input  logic display_play,
    input  logic display_gameover,
    input logic [8:0] rand_plat_X [19:0],
    input logic [8:0] rand_plat_Y [19:0],

    output logic [9:0] count, //tb
    output logic bounce_n,
    output logic bounce_c,
    output logic play_init_next,
    output logic play_init_curr,
    output logic plat_shift_n,
    output logic plat_shift_c,
    output logic [9:0] jump_height_n,
    output logic [9:0] jump_height_c,

    output logic [8:0] POI_platform_Y_CM [19:0],
    output logic [15:0] score,
    
    output logic        is_dead,
    output logic [9:0]  playerX, 
    output logic [9:0]  playerY, 
    output logic [9:0]  playerS
    );
    
    
    parameter [9:0] player_X_Center=320;  // Center position on the X axis
    parameter [9:0] player_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] player_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] player_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] player_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] player_Y_Max=479;     // Bottommost point on the Y axis
    
    parameter [9:0] platform_startX_Center=106;  // static platform for now
    parameter [9:0] platform_startY_Center=420;  
    parameter [9:0] platform_start_W=84;
    parameter [9:0] platform_start_H=28; 
    parameter [9:0] player_startX_Center=106; 
    parameter [9:0] player_startY_Center=240;  

    parameter [9:0] R_platform_W=84;
    parameter [9:0] R_platform_H=28;


    logic [9:0] player_X_Motion;
    logic [9:0] player_X_Motion_next;
    logic [9:0] player_Y_Motion;
    logic [9:0] player_Y_Motion_next;

    logic [9:0] player_X_next;
    logic [9:0] player_Y_next;
        
    logic [9:0] counter;
    logic bounce_curr; //flag
    logic bounce_next;

    logic plat_shift_curr;
    logic plat_shift_next;
    
    logic [9:0] jump_height_curr;
    logic [9:0] jump_height_next;
    
    logic [15:0] score_curr;
    logic [15:0] score_next;
 
    assign playerS = 16;
    
    assign count = counter; //tb
    assign bounce_n = bounce_next;
    assign bounce_c = bounce_curr;
    logic play_init_n;
    logic play_init_c;
    
    assign play_init_next = play_init_n;
    assign play_init_curr = play_init_c; 

    logic [8:0] POI_platY_next [19:0];
    logic [8:0] POI_platY_curr [19:0];
    
    assign plat_shift_n = plat_shift_next;
    assign plat_shift_c = plat_shift_curr;
    
    assign jump_height_n = jump_height_next;
    assign jump_height_c = jump_height_curr;
    
    logic [9:0] jump_ini_next;
    logic [9:0] jump_ini_curr;
    
    logic collide_curr;
    logic collide_next;
 

    always_comb
    begin
        collide_next = collide_curr;
        bounce_next = bounce_curr;
        player_Y_Motion_next = player_Y_Motion; //believe u need this to avoice latches
        player_X_Motion_next = player_X_Motion; 
        player_Y_next = playerY;
        player_X_next = playerX;
        play_init_n = play_init_c;
        jump_height_next = jump_height_curr;
        plat_shift_next = plat_shift_curr;
        jump_ini_next = jump_ini_curr;
        score_next = score_curr;
        
        for(int i = 0; i < 20; i++)
        begin
            POI_platY_next[i] = POI_platY_curr[i]; //was just set to rand before
//            POI_platform_Y_CM[i] = POI_platY_next[i];
        end     
        

        if(display_start)
        begin
            bounce_next = bounce_curr;
            player_Y_Motion_next = player_Y_Motion; //Move down
            player_X_Motion_next = player_X_Motion; //no x motion at start
            jump_height_next = jump_height_curr;
            plat_shift_next = plat_shift_curr;
            jump_ini_next = jump_ini_curr;

            
            player_Y_next = playerY + player_Y_Motion_next;
            player_X_next = playerX + player_X_Motion_next;
            
            if (!bounce_curr && 
            (playerY + playerS + 10'd5) >= (platform_startY_Center - platform_start_H/2) && //406
            playerX <= (platform_startX_Center + platform_start_W/2)&& 
            playerX >= (platform_startX_Center - platform_start_W/2)) 
            begin
                bounce_next = 1; // Set bounce flag if collision occurs
            end
            if(bounce_curr)
            begin
                player_Y_Motion_next = -10'd5; //Move up
                if(playerY <= player_Y_Center)begin
                    bounce_next = 0;
                end
            end
            else
            begin
                player_Y_Motion_next = 10'd5; //Move down
            end
        end
        if(display_play)
        begin
            jump_height_next = jump_height_curr;
            plat_shift_next = plat_shift_curr;
            jump_ini_next = jump_ini_curr;
            collide_next = collide_curr;
            score_next = score_curr;
            play_init_n = play_init_c;
            player_Y_next = playerY + player_Y_Motion_next; 
            player_X_next = playerX + player_X_Motion_next;

            
            if(play_init_c) //this block should activate at start and when dead
            begin
                player_Y_next = player_Y_Center;
                player_X_next = player_X_Center;
                bounce_next = 0;
                play_init_n = 0;
                plat_shift_next = 0;
                collide_next = 1; 
                score_next = 0;
            end

            if(bounce_curr)
            begin
                player_Y_Motion_next = -10'd5; //Move up
                if(playerY <= player_Y_Center || plat_shift_curr)
                begin
                    player_Y_next = player_Y_Center + 10'd1; //make player stand still on the middle while platforms move down
                    plat_shift_next = 1;
                    for(int i = 0; i < 20; i++)
                    begin
                        POI_platY_next[i] = POI_platY_curr[i] + 10'd5; //add to move platforms down
//                        POI_platform_Y_CM[i] = POI_platY_curr[i];
                    end
                    jump_height_next = jump_height_curr + 10'd5;
                        if(jump_height_curr >= jump_ini_curr + jump_ini_curr) //platforms down shifting
                        begin
                            plat_shift_next = 0;
                            bounce_next = 0;
                            jump_height_next = 0;
                            collide_next = 1;
                        end
                end
            end
            else
            begin
                player_Y_Motion_next = 10'd5; //Move down
            end
          
            
            if(!bounce_curr)
            begin
                 if(((playerX >= rand_plat_X[0] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[0] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[0] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[0] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[0] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;
                        end
                  if(((playerX >= rand_plat_X[1] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[1] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[1] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[1] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[1] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;    
                            score_next = score_curr + 16'd1;
                        
                        end
                 if(((playerX >= rand_plat_X[2] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[2] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[2] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[2] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[2] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;    
                            score_next = score_curr + 16'd1;                     
                        end
                 if(((playerX >= rand_plat_X[3] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[3] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[3] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[3] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[3] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                            
                        end
               if(((playerX >= rand_plat_X[4] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[4] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[4] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[4] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[4] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                          
                        end
                 if(((playerX >= rand_plat_X[5] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[5] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[5] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[5] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[5] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;
                        end
                 if(((playerX >= rand_plat_X[6] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[6] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[6] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[6] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[6] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                            
                        end
               if(((playerX >= rand_plat_X[7] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[7] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[7] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[7] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[7] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;    
                            score_next = score_curr + 16'd1;                                                 
                        end
                if(((playerX >= rand_plat_X[8] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[8] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[8] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[8] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[8] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0; 
                            score_next = score_curr + 16'd1;                                                     
                        end
               if(((playerX >= rand_plat_X[9] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[9] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[9] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[9] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[9] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                            
                        end
               if(((playerX >= rand_plat_X[10] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[10] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[10] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[10] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[10] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0; 
                            score_next = score_curr + 16'd1;                                                       
                        end
                  if(((playerX >= rand_plat_X[11] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[11] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[11] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[11] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[11] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;  
                            score_next = score_curr + 16'd1;                                                  
                        end
                 if(((playerX >= rand_plat_X[12] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[12] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[12] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[12] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[12] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                         
                        end
                 if(((playerX >= rand_plat_X[13] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[13] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[13] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[13] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[13] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;  
                            score_next = score_curr + 16'd1;                                                                               
                        end
               if(((playerX >= rand_plat_X[14] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[14] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[14] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[14] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[14] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                                                   
                        end
                 if(((playerX >= rand_plat_X[15] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[15] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[15] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[15] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[15] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                          
                        end
                 if(((playerX >= rand_plat_X[16] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[16] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[16] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[16] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[16] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;  
                            score_next = score_curr + 16'd1;                                                     
                        end
               if(((playerX >= rand_plat_X[17] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[17] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[17] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[17] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[17] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;   
                            score_next = score_curr + 16'd1;                                                    
                        end
                if(((playerX >= rand_plat_X[18] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[18] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[18] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[18] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[18] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;   
                            score_next = score_curr + 16'd1;                                                 
                        end
               if(((playerX >= rand_plat_X[19] - R_platform_W/2) &&
                       (playerX <= rand_plat_X[19] + R_platform_W/2) &&
                       (playerY + playerS + 10'd5  >= POI_platY_curr[19] - R_platform_H/2) &&
                       (playerY + playerS  <= POI_platY_curr[19] + R_platform_H/2)) && collide_curr
                        == 10'd1
                        )begin
                            jump_height_next = 10'd520 - (POI_platY_curr[19] - R_platform_H/2);
                            jump_ini_next = jump_height_next;
                            collide_next = 0;
                            score_next = score_curr + 16'd1;                          
                        end
                        
                        
            
                for(int i = 0; i < 20; i++)
                begin
                    if(((playerX >= rand_plat_X[i] - R_platform_W/2) &&
                        (playerX <= rand_plat_X[i] + R_platform_W/2) &&
                        (playerY + playerS + 10'd5  >= POI_platY_curr[i] - R_platform_H/2) &&
                        (playerY + playerS  <= POI_platY_curr[i] + R_platform_H/2)) && collide_curr)
                         bounce_next = 1;
//                       jump_height_next = 10'd640 - POI_platY_curr[i] - R_platform_H/2;
//                       jump_ini_next = jump_height_next;
            
                end
            end

            if(playerY >= player_Y_Max) //RESET ON DEAD
            begin
                play_init_n = 1;
            end
           
            player_X_Motion_next = 0; //PLAYER MOVEMENT
            if (keycode == 8'h4) //left
            begin
                player_X_Motion_next = -10'd10;
            end
            if (keycode == 8'h7) //right
            begin
                player_X_Motion_next = 10'd10;
            end
            
            if (playerX >= player_X_Max ) //WRAP AROUND LOGIC FOR X
            begin
                player_X_next = player_X_Min + 10'd11;
            end
            if (playerX <= player_X_Min + 10'd10) 
            begin
                player_X_next = player_X_Max - 10'd1;
            end
        end
            
        
    end
    
   
   
    always_ff @(posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_player
        if (Reset)
        begin 
            player_Y_Motion <= 10'd5; 
			player_X_Motion <= 10'd0;             
			playerY <= player_startY_Center;
			playerX <= player_startX_Center;
			bounce_curr <= 0;
			counter <= 0;
            plat_shift_curr <= 0;
            jump_ini_curr <= 0;
            collide_curr <= 1;

            //game_display start
            play_init_c <= 1;
            POI_platY_curr <= rand_plat_Y;
            score_curr <= 16'b0;

            jump_height_curr <= 0;
        end
        else if (counter >= 10'd10)begin
            counter <= 10'd0;
        end
        else 
        begin
			player_Y_Motion <= player_Y_Motion_next; 
			player_X_Motion <= player_X_Motion_next; 
			counter <= counter + 1;
            jump_height_curr <= jump_height_next;
            plat_shift_curr <= plat_shift_next;
            jump_ini_curr <= jump_ini_next;
            score_curr <= score_next;
            
            POI_platY_curr <= POI_platY_next;
            collide_curr <= collide_next;
            
            POI_platform_Y_CM <= POI_platY_curr;
            score <= score_curr;

            playerY <= player_Y_next;  
            playerX <= player_X_next;
            bounce_curr <= bounce_next;
            play_init_c <= play_init_n;
		end  
    end


    
      
endmodule