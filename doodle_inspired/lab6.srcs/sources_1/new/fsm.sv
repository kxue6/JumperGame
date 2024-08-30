module fsm (
    input logic Reset,
    input logic frame_clk,
    input logic [7:0] keycode,
    input logic is_dead,

    output logic display_start,
    output logic display_play,
    output logic display_gameover
);

typedef enum logic [1:0]{start, play, gameover} state_type;

state_type state_curr, state_next;

always_comb
begin
    display_start = 1'b0;
    display_play = 1'b0;
    display_gameover = 1'b0;
    state_next = state_curr;
    
    case(state_curr) 
    start:
    begin
        display_start = 1'b1;
        display_play = 1'b0;
        display_gameover = 1'b0;
        if(keycode == 8'h2C) //space_bar
        begin
            state_next = play;
        end
    end
    play:
    begin
        display_start = 1'b0;
        display_play = 1'b1;
        display_gameover = 1'b0;
        if(is_dead)
        begin
            state_next = gameover;
        end
    end
    gameover:
    begin
        display_start = 1'b0;
        display_play = 1'b0;
        display_gameover = 1'b1;
        if(keycode ==  8'h2C) //space_bar
        begin
            state_next = start;
        end
    end
    default:
        begin
            state_next = start;
        end
    endcase

end

always_ff @(posedge frame_clk)
begin
    if(Reset)
    begin
        state_curr <= start;
    end
    else
    begin
        state_curr <= state_next;
    end
end

endmodule