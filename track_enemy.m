function [ STRATEGY_TRACK_ENEMY_GRID ] = track_enemy(PLAYGROUND_IMAGE_HEIGHT,PLAYGROUND_IMAGE_WIDTH,...
    PLAYGROUND_HEIGHT,PLAYGROUND_WIDTH,STRATEGY_TRACK_ENEMY_GRID_SIZE_X,STRATEGY_TRACK_ENEMY_GRID_SIZE_Y,...
    STRATEGY_TRACK_ENEMY_GRID,STRATEGY_TRACK_CENTER_WEIGHT,STRATEGY_TRACK_FRAME_WEIGHT)
%track_enemy a simple tracking function


%figure(PLAYAREA);
[enemy_x_positions,enemy_y_positions]=ginput(1); %read in the position

% the current positions has the highest weight. Arround the center will put
% a frame of lower weight, if the frame within the playground
if ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10) < PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y && ...
    ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10) > 1 && ...
    ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10) > 1 && ...
    ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10) < PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X

    % center (=current position)
    STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
    ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)) = STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
    ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)) + STRATEGY_TRACK_CENTER_WEIGHT;

    % upper frame edge
    for i = 1:3
        STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10)-1,...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-2+i) = STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10)-1,...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-2+i) + STRATEGY_TRACK_FRAME_WEIGHT;
    end

    % deeper frame edge
    for i = 1:3
        STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10)+1,...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-2+i) = STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10)+1,...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-2+i) + STRATEGY_TRACK_FRAME_WEIGHT;
    end
    % left frame edge
    STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-1) = STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)-1) + STRATEGY_TRACK_FRAME_WEIGHT;
    % right frame edge
    STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)+1) = STRATEGY_TRACK_ENEMY_GRID(ceil(PLAYGROUND_HEIGHT/PLAYGROUND_IMAGE_HEIGHT*enemy_y_positions*10),...
            ceil(PLAYGROUND_WIDTH/PLAYGROUND_IMAGE_WIDTH*enemy_x_positions*10)+1) + STRATEGY_TRACK_FRAME_WEIGHT;
end


%figure(ENEMYAREA);
%imagesc(STRATEGY_TRACK_ENEMY_GRID);

end

