function [ weight ] = node_weight( time,strategy_track_enemy_grid,node,...
    PLAYGROUND_IMAGE_WIDTH,PLAYGROUND_IMAGE_HEIGHT,PLAYGROUND_WIDTH,PLAYGROUND_HEIGHT,...
    STRATEGY_TRACK_ENEMY_GRID_SIZE_X,STRATEGY_TRACK_ENEMY_GRID_SIZE_Y)
%node_weight calculate the current weight of the node

if time > node.time
    %if strategy_track_enemy_grid(ceil(node.x/PLAYGROUND_IMAGE_WIDTH/PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X) < max_level
    
%     weight = time + strategy_track_enemy_grid(...
%         ceil(node.x/PLAYGROUND_IMAGE_WIDTH/PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X),...
%         ceil(node.y/PLAYGROUND_IMAGE_HEIGHT/PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y)) +...
%         10 * (node.points/node.time+node.percent);
    weight = time*1/(((node.points/node.time)*node.percent)) + strategy_track_enemy_grid(...
        ceil(node.y/(PLAYGROUND_IMAGE_HEIGHT/(PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y))),...
        ceil(node.x/(PLAYGROUND_IMAGE_WIDTH/(PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X))));

    %else
%        weight = inf; 
    %end
else
    weight = 0;
end
end


