function [ weight ] = node_weight( remain_time,total_time,strategy_track_enemy_grid,src_node,dest_node,...
    PLAYGROUND_IMAGE_WIDTH,PLAYGROUND_IMAGE_HEIGHT,PLAYGROUND_WIDTH,PLAYGROUND_HEIGHT,...
    STRATEGY_TRACK_ENEMY_GRID_SIZE_X,STRATEGY_TRACK_ENEMY_GRID_SIZE_Y)
%node_weight calculate the current weight of the node

%if strategy_track_enemy_grid(ceil(node.x/PLAYGROUND_IMAGE_WIDTH/PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X) < max_level



ww1 = remain_time/total_time;
ww2 = (total_time-remain_time)/total_time;

w_dest = (dest_node.points/dest_node.time)*(1/dest_node.percent);

w_src_dest = sqrt((abs(src_node.x-dest_node.x))^2+(abs(src_node.y-dest_node.y))^2);

weight = ww1 * w_dest + ww2 * w_src_dest;




% weight = time*1/(((node.points/node.time)*node.percent)) + strategy_track_enemy_grid(...
%     ceil(node.y/(PLAYGROUND_IMAGE_HEIGHT/(PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y))),...
%     ceil(node.x/(PLAYGROUND_IMAGE_WIDTH/(PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X))));

%else
%        weight = inf; 
%end

end


