`timescale 1ns / 1ps

module player_tb();
    
    logic        Reset; 
    logic        frame_clk;
    logic [7:0]  keycode;
    logic display_start;
    logic display_play;
    logic [15:0] score;
    logic display_gameover;
    logic [8:0] rand_plat_X [19:0];
    logic [8:0] rand_plat_Y [19:0];

    logic [9:0] count; //tb
    logic bounce_n;
    logic bounce_c;
    logic play_init_next;
    logic play_init_curr;
    logic plat_shift_n;
    logic plat_shift_c;
    logic [9:0] jump_height_n;
    logic [9:0] jump_height_c;

    logic [8:0] POI_platform_Y_CM [19:0];
    logic        is_dead;
    logic [9:0]  playerX;
    logic [9:0]  playerY;
    logic [9:0]  playerS;
    logic [9:0]  playerYS;

    
    localparam T = 16666667; //clock period in nanoseconds 1/60hz;
    assign playerYS = playerY + playerS;
    
    player TEST (.*);
    logic [8:0] x [19:0];
    logic [8:0] y [19:0];
    platform_gen randomVals(
        .clk(1'b1), 
        .rst(Reset),
        .x_coord(x), // Array of outputs for x coordinates
        .y_coord(y)
    );
    
    

    
    initial begin: CLOCK_INITIALIZATION
        frame_clk = 1'b1;
    end 
    
    always begin : CLOCK_GENERATION
        #(T / 2) frame_clk = ~frame_clk;  // Toggle every half a period
    end
    
//    keycode = 8'h4; left
//    keycode = 8'h7; right
    
    initial begin : TEST_VECTORS
        display_start = 1'b1;
        display_play = 1'b0;
        display_gameover = 1'b0;
        rand_plat_X[0] = 9'd320;
        rand_plat_Y[0] = 9'd470;
        for(int i = 1; i < 20; i++)
        begin
            rand_plat_X[i] = 9'd0;
            rand_plat_Y[i] = 9'd0;
        end
        Reset = 1'b1;
        #T  
        Reset = 1'b0;
        #T
        display_start = 1'b0;
        display_play = 1'b1;
        display_gameover = 1'b0;  
        
    end
endmodule