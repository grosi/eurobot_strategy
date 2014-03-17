%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Projekt: Eurobot
% Thema: Spielstrategie
% Autor: Simon Grossenbacher (gross10)
% Datum: 16.02.2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% graphic settings %
MARKER_LINE_WIDHT = 2;
LINE_LINE_WIDTH = 3;
MARKER_SIZE = 20;
MARKER_NORMAL_COLORSHAPE = 'ro';
MARKER_NORMAL_COLOR = 'r';
MARKER_START_COLOR = 'g';
MARKER_ODD_COLOR = 'm';
MARKER_CLUSTER_COLOR = 'b';
LINE_TREE_COLOR = 'g';
LINE_GRID_COLORSHAPE = 'k--';


% play ground %
PLAYGROUND_IMAGE = imread('res/playground_small','png');
PLAYGROUND_IMAGE_WIDTH = size(PLAYGROUND_IMAGE,2);
PLAYGROUND_IMAGE_HEIGHT = size(PLAYGROUND_IMAGE,1);


% global game settings %
PLAY_TIME = 90; % time in seconds 
ROBO_AVERAGE_SPEED = 0.5; % m/s
TOTAL_POINTS = 21; % total points
PLAYGROUND_WIDTH = 3; % width in meter
PLAYGROUND_HEIGHT = 2; % height in meter


% strategy settings %
STRATEGY_TRACK_ENEMY_GRID_SIZE_X = 10e-2; %10cm
STRATEGY_TRACK_ENEMY_GRID_SIZE_Y = 10e-2; %10cm
STRATEGY_TRACK_CENTER_WEIGHT = 1;
STRATEGY_TRACK_FRAME_WEIGHT = 0.5;
STRATEGY_TRACK_TRESHHOLD = 5;

% node settings %
NODE_QUANTITY = 11;

% ball
NODE_BALL_ID = 1;
NODE_BALL_TIME = 5; %[s]
NODE_BALL_POINT = 4; %max. possible points;
NODE_BALL_PERCENT_OF_POINTS = 3*NODE_BALL_POINT/TOTAL_POINTS/3;
NODE_BALL_1_1_X_POSITION = 0.62; % [m]
NODE_BALL_1_1_Y_POSITION = 0.49; % [m]
NODE_BALL_1_2_X_POSITION = 2; % [m]
NODE_BALL_1_2_Y_POSITION = 0.49; % [m]
NODE_BALL_2_1_X_POSITION = 0.82; % [m]
NODE_BALL_2_1_Y_POSITION = 0.49; % [m]
NODE_BALL_2_2_X_POSITION = 2.2; % [m]
NODE_BALL_2_2_Y_POSITION = 0.49; % [m]
NODE_BALL_3_1_X_POSITION = 1.02; % [m]
NODE_BALL_3_1_Y_POSITION = 0.49; % [m]
NODE_BALL_3_2_X_POSITION = 2.4; % [m]
NODE_BALL_3_2_Y_POSITION = 0.49; % [m]

% start
NODE_START_ID = 2;
NODE_START_TIME = 1;
NODE_START_POINT = 1;
NODE_START_PERCENT_OF_POINTS = 1*NODE_START_POINT/TOTAL_POINTS/1;
NODE_START_X_POSITION = 0.25; % [m]
NODE_START_Y_POSITION = 0.25; % [m]

% fresco
NODE_FRESCO_ID = 3;
NODE_FRESCO_TIME = 10; %[s]
NODE_FRESCO_POINT = 6;
NODE_FRESCO_PERCENT_OF_POINTS = 1*NODE_FRESCO_POINT/TOTAL_POINTS/1;
NODE_FRESCO_1_1_X_POSITION = 1.35; % [m]
NODE_FRESCO_1_1_Y_POSITION = 0.2; % [m]
NODE_FRESCO_1_2_X_POSITION = 1.65; % [m]
NODE_FRESCO_1_2_Y_POSITION = 0.2; % [m]

% fire
NODE_FIRE_ID = 4;
NODE_FIRE_TIME = 2; %[s]
NODE_FIRE_POINT = 1;
NODE_FIRE_PERCENT_OF_POINTS = 3*NODE_FIRE_POINT/TOTAL_POINTS/3;
NODE_FIRE_1_X_POSITION = 2.10; % [m]
NODE_FIRE_1_Y_POSITION = 0.60; % [m]
NODE_FIRE_2_X_POSITION = 2.6; % [m]
NODE_FIRE_2_Y_POSITION = 1.1; % [m]
NODE_FIRE_3_X_POSITION = 2.10; % [m]
NODE_FIRE_3_Y_POSITION = 1.6; % [m]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. generate the figures/windows
% enemy tracking
ENEMYAREA = figure();
set(gca,'YDir','Reverse'); % y-axes mirrored
xlim([0 PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X+1]);
ylim([0 PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y+1]);
title('Gegener Position');
hold on;
% node-weight development
NODEWEIGHT = figure();
subplot(211);
xlim([0 PLAY_TIME]);
title('Knotengewichte');
hold on;
subplot(212);
xlim([0 PLAY_TIME]);
title('Gewicht-Gewicht');
hold on;
% playground
PLAYAREA = figure();
imshow(PLAYGROUND_IMAGE);
title('Spielfeld');
hold on;


%% 2. set node quantity 
nodes_quantity = NODE_QUANTITY;


%% 3. set the nodes
% ball 1
nodes(1).id = NODE_BALL_ID;
nodes(1).points = NODE_BALL_POINT;
nodes(1).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(1).time = NODE_BALL_TIME;
nodes(1).x = (NODE_BALL_1_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(1).y = (NODE_BALL_1_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(1).weight = 0;
nodes(1).weighttext = text(nodes(1).x-MARKER_SIZE,nodes(1).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(1).pool_id = 0; %ID of the pool
nodes(1).child = 0;

% ball 2
nodes(2).id = NODE_BALL_ID;
nodes(2).points = NODE_BALL_POINT;
nodes(2).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(2).time = NODE_BALL_TIME;
nodes(2).x = (NODE_BALL_1_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(2).y = (NODE_BALL_1_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(2).weight = 0;
nodes(2).weighttext = text(nodes(2).x-MARKER_SIZE,nodes(2).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(2).pool_id = 0; %ID of the pool
nodes(2).child = 0;

% ball 3
nodes(3).id = NODE_BALL_ID;
nodes(3).points = NODE_BALL_POINT;
nodes(3).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(3).time = NODE_BALL_TIME;
nodes(3).x = (NODE_BALL_2_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(3).y = (NODE_BALL_2_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(3).weight = 0;
nodes(3).weighttext = text(nodes(3).x-MARKER_SIZE,nodes(3).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(3).pool_id = 0; %ID of the pool
nodes(3).child = 0;

% ball 4
nodes(4).id = NODE_BALL_ID;
nodes(4).points = NODE_BALL_POINT;
nodes(4).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(4).time = NODE_BALL_TIME;
nodes(4).x = (NODE_BALL_2_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(4).y = (NODE_BALL_2_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(4).weight = 0;
nodes(4).weighttext = text(nodes(4).x-MARKER_SIZE,nodes(4).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(4).pool_id = 0; %ID of the pool
nodes(4).child = 0;

% ball 5
nodes(5).id = NODE_BALL_ID;
nodes(5).points = NODE_BALL_POINT;
nodes(5).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(5).time = NODE_BALL_TIME;
nodes(5).x = (NODE_BALL_3_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(5).y = (NODE_BALL_3_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(5).weight = 0;
nodes(5).weighttext = text(nodes(5).x-MARKER_SIZE,nodes(5).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(5).pool_id = 0; %ID of the pool
nodes(5).child = 0;

% ball 6
nodes(6).id = NODE_BALL_ID;
nodes(6).points = NODE_BALL_POINT;
nodes(6).percent = NODE_BALL_PERCENT_OF_POINTS;
nodes(6).time = NODE_BALL_TIME;
nodes(6).x = (NODE_BALL_3_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(6).y = (NODE_BALL_3_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(6).weight = 0;
nodes(6).weighttext = text(nodes(6).x-MARKER_SIZE,nodes(6).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(6).pool_id = 0; %ID of the pool
nodes(6).child = 0;

% fresco 1
nodes(7).id = NODE_FRESCO_ID;
nodes(7).points = NODE_FRESCO_POINT;
nodes(7).percent = NODE_FRESCO_PERCENT_OF_POINTS;
nodes(7).time = NODE_FRESCO_TIME;
nodes(7).x = (NODE_FRESCO_1_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(7).y = (NODE_FRESCO_1_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(7).weight = 0;
nodes(7).weighttext = text(nodes(7).x-MARKER_SIZE,nodes(7).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(7).pool_id = 0; %ID of the pool
nodes(7).child = 0;

% fresco 2
nodes(8).id = NODE_FRESCO_ID;
nodes(8).points = NODE_FRESCO_POINT;
nodes(8).percent = NODE_FRESCO_PERCENT_OF_POINTS;
nodes(8).time = NODE_FRESCO_TIME;
nodes(8).x = (NODE_FRESCO_1_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(8).y = (NODE_FRESCO_1_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(8).weight = 0;
nodes(8).weighttext = text(nodes(8).x-MARKER_SIZE,nodes(8).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(8).pool_id = 0; %ID of the pool
nodes(8).child = 0;

% fire 1
nodes(9).id = NODE_FIRE_ID;
nodes(9).points = NODE_FIRE_POINT;
nodes(9).percent = NODE_FIRE_PERCENT_OF_POINTS;
nodes(9).time = NODE_FIRE_TIME;
nodes(9).x = (NODE_FIRE_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(9).y = (NODE_FIRE_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(9).weight = 0;
nodes(9).weighttext = text(nodes(9).x-MARKER_SIZE,nodes(9).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(9).pool_id = 0; %ID of the pool
nodes(9).child = 0;

% fire 2
nodes(10).id = NODE_FIRE_ID;
nodes(10).points = NODE_FIRE_POINT;
nodes(10).percent = NODE_FIRE_PERCENT_OF_POINTS;
nodes(10).time = NODE_FIRE_TIME;
nodes(10).x = (NODE_FIRE_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(10).y = (NODE_FIRE_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(10).weight = 0;
nodes(10).weighttext = text(nodes(10).x-MARKER_SIZE,nodes(10).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(10).pool_id = 0; %ID of the pool
nodes(10).child = 0;

% fire 3
nodes(11).id = NODE_FIRE_ID;
nodes(11).points = NODE_FIRE_POINT;
nodes(11).percent = NODE_FIRE_PERCENT_OF_POINTS;
nodes(11).time = NODE_FIRE_TIME;
nodes(11).x = (NODE_FIRE_3_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(11).y = (NODE_FIRE_3_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
nodes(11).weight = 0;
nodes(11).weighttext = text(nodes(11).x-MARKER_SIZE,nodes(11).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
nodes(11).pool_id = 0; %ID of the pool
nodes(11).child = 0;

% start
% nodes(12).id = NODE_START_ID;
% nodes(12).points = NODE_START_POINT;
% nodes(12).percent = NODE_START_PERCENT_OF_POINTS;
% nodes(12).time = NODE_START_TIME;
% nodes(12).x = (NODE_START_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
% nodes(12).y = (NODE_START_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
% nodes(12).weight = 0;
% nodes(12).pool_id = 0; %ID of the pool
% nodes(12).child = 0;


% plot the nodes
for i = 1:nodes_quantity
    
    plot(nodes(i).x,nodes(i).y,MARKER_NORMAL_COLORSHAPE,...
        'MarkerSize',MARKER_SIZE,'LineWidth',MARKER_LINE_WIDHT);
    tmp_child_data = get(gca,'Children');
    nodes(i).child = tmp_child_data(1); %set( dataH(1), 'visible', 'off' )
end


%% 5. select pools
% set the pool quantity
repeat = 1;
pool_quantity = input('how many node-pools: ');
while repeat == 1
    if pool_quantity > nodes_quantity-1
        pool_quantity = input('make no sense, try again: ');
    else
        repeat = 0;
    end
end

% set the size of the pools and the trigger level for complete
pools_node_quantity = zeros(pool_quantity,2);
for i=1:pool_quantity
    pools_node_quantity(i,1) = input(strcat('size of pool number ',num2str(i),':'));
    repeat = 1;
    while repeat == 1
        if pools_node_quantity(i,1) > nodes_quantity-1
            pools_node_quantity(i,1) = input('make no sense, try again: ');
        else
            repeat = 0;
        end      
    end
    
    pools_node_quantity(i,2) = input(strcat('trigger level of pool number ',num2str(i),':'));
    repeat = 1;
    while repeat == 1
        if pools_node_quantity(i,2) > pools_node_quantity(i,1)-1
            pools_node_quantity(i,2) = input('make no sense, try again: ');
        else
            repeat = 0;
        end      
    end
end

% connect nodes to a specific pool
pool_nodes = zeros(pool_quantity,max(pools_node_quantity(:,1))); %has to set manuel in C
for i=1:pool_quantity
    disp(strcat('mark the nodes of pool number ',num2str(i)));
    for j=1:pools_node_quantity(i,1)
        repeat = 1;
        while repeat == 1
            [tmp_x,tmp_y]=ginput(1);
            for k = 1:nodes_quantity
                if tmp_x < nodes(k).x + MARKER_SIZE/2
                    if tmp_x > nodes(k).x - MARKER_SIZE/2
                        if tmp_y < nodes(k).y + MARKER_SIZE/2
                            if tmp_y > nodes(k).y - MARKER_SIZE/2
                                set(nodes(k).child,'Color',MARKER_CLUSTER_COLOR);
                                pool_nodes(i,j) = k;
                                nodes(k).pool_id = i;
                                repeat = 0;
                                break;
                            end
                        end
                    end
                end
            end
            
            if repeat == 1
                disp('mark the node again!');
            end 
        end 
    end
    
    % set a colored frame arround the nodes
    pool_colors = rand(1,3); %random color for cluster identification
    for j=1:pools_node_quantity(i,1)
        rectangle('Position', [nodes(pool_nodes(i,j)).x-MARKER_SIZE/2-5 ...
            nodes(pool_nodes(i,j)).y-MARKER_SIZE/2-5 ...
            MARKER_SIZE+10 MARKER_SIZE+10], ...
            'EdgeColor',pool_colors(1,:), ...
            'LineWidth', MARKER_LINE_WIDHT);
        tmp_child_data = get(gca,'Children');
        set(nodes(pool_nodes(i,j)).child,'Color',MARKER_NORMAL_COLOR);
    end
    
end


%% 4. mark the start node
% init variables
repeat = 1;
node_count = 1;
disp('mark the start node');
while repeat == 1
    [tmp_x,tmp_y]=ginput(1);
    for i = 1:nodes_quantity
        if tmp_x < nodes(i).x + MARKER_SIZE/2
            if tmp_x > nodes(i).x - MARKER_SIZE/2
                if tmp_y < nodes(i).y + MARKER_SIZE/2
                    if tmp_y > nodes(i).y - MARKER_SIZE/2
                        start_node = i;
                        way_time = sqrt((abs((nodes(start_node).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH-NODE_START_X_POSITION))^2 ...
                            +(abs((nodes(start_node).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT-NODE_START_Y_POSITION))^2)/ROBO_AVERAGE_SPEED;
                        busy_node_time = ceil(nodes(start_node).time + way_time);
                        set(nodes(i).child,'Color',MARKER_START_COLOR);
                        set(nodes(i).weighttext,'Visible','off');
                        text(nodes(i).x-5,nodes(i).y+5,num2str(node_count),'FontSize',20,'Color','w');
                        
                        if nodes(start_node).pool_id ~= 0
                            pools_node_quantity(nodes(start_node).pool_id,2) = pools_node_quantity(nodes(start_node).pool_id,2) - 1;

                            if pools_node_quantity(nodes(start_node).pool_id,2) == 0
                                for j=1:nodes_quantity
                                    check = find(pool_nodes(nodes(start_node).pool_id,:) == j);
                                    if isempty(check) || j==start_node || nodes(j).child == 0  
                                    else
                                        set(nodes(j).child,'Visible','off');
                                        set(nodes(j).weighttext,'Visible','off');
                                        nodes(j).child = 0; 
                                        node_count = node_count + 1; % count the completed nodes
                                    end
                                end
                            end
                        end
                        
                        
                        repeat = 0;
                        break;
                    end
                end
            end
        end
    end
    if repeat == 1
        disp('mark the start node again!');
    end
end


%% 5 start game
% init variables
strategy_track_enemy_grid = zeros(PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y, ...
    PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X);
weight_history = zeros(NODE_QUANTITY,PLAY_TIME);
time = zeros(NODE_QUANTITY,PLAY_TIME);
ww1 = 1;
ww2 = 0;

% a loop with 90 iterations (one for every second)  
for seconds = 1:PLAY_TIME
    %
    % enemy-tracking
    %
    %set the position of the enemy robo
    disp('set next enemy robo position');
    figure(PLAYAREA);
    strategy_track_enemy_grid = track_enemy(PLAYGROUND_IMAGE_HEIGHT,PLAYGROUND_IMAGE_WIDTH,...
        PLAYGROUND_HEIGHT,PLAYGROUND_WIDTH,STRATEGY_TRACK_ENEMY_GRID_SIZE_X,STRATEGY_TRACK_ENEMY_GRID_SIZE_Y,...
        strategy_track_enemy_grid,STRATEGY_TRACK_CENTER_WEIGHT,STRATEGY_TRACK_FRAME_WEIGHT);
    figure(ENEMYAREA);
    imagesc(strategy_track_enemy_grid);
    colorbar;
    
    %
    % node-weighting
    %
    figure(PLAYAREA);
    ww1 = (PLAY_TIME-seconds)/PLAY_TIME;
    ww2 = (PLAY_TIME-(PLAY_TIME-seconds))/PLAY_TIME;
    for i = 1:nodes_quantity
        % destination node point-weight
        if nodes(i).id == NODE_BALL_ID && nodes(i).x > nodes(start_node).x
            w_dest = (nodes(i).points/nodes(i).time)*(1/nodes(i).percent);
        else
            w_dest = (nodes(i).points/nodes(i).time)*(1/nodes(i).percent)*2;
        end
        % destination node enemy-weight
        w_enemy = strategy_track_enemy_grid(...
        ceil(nodes(i).y/(PLAYGROUND_IMAGE_HEIGHT/(PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y))),...
        ceil(nodes(i).x/(PLAYGROUND_IMAGE_WIDTH/(PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X))));
        nodes(i).weight = ww1 * w_dest + ww1 * w_enemy;

        % source -> destination node distance-time weight
        w_src_dest = sqrt((abs((nodes(start_node).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH-(nodes(i).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH))^2 ...
         +(abs((nodes(start_node).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT-(nodes(i).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT))^2)/ROBO_AVERAGE_SPEED;

        node_edge_weight(start_node,i) = ww1 * w_dest + ww1 * w_enemy + ww2 * w_src_dest;
        weight_history(i,seconds) = ww1 * w_dest + ww1 * w_enemy + w_src_dest;
        
        % plot weight informations            
        set(nodes(i).weighttext,'String',num2str(node_edge_weight(start_node,i)));
    end
       
    
    %
    % next-node searching
    %
    if busy_node_time <= 0
    
        next_node.weight = inf;%node_edge_weight(start_node,1);

        for i = 1:nodes_quantity
            if nodes(i).child ~= 0 && i ~= start_node
                % find the best node (lowest weight)
                if next_node.weight > node_edge_weight(start_node,i)
                    next_node.node = i;
                    next_node.time = w_src_dest/ROBO_AVERAGE_SPEED;
                    next_node.weight = node_edge_weight(start_node,i);
                end
            end
        end

        node_count = node_count + 1; % count the completed nodes
        
        % plot informations in playground
        figure(PLAYAREA);
        % draw route
        plot([nodes(start_node).x nodes(next_node.node).x],[nodes(start_node).y nodes(next_node.node).y],LINE_TREE_COLOR,'LineWidth',2);
        
        % disable the last and now completed node
        set(nodes(start_node).child,'Visible','off');
        set(nodes(start_node).weighttext,'Visible','off');
        nodes(start_node).child = 0;
        % mark the new start node and disable his cluster pair
        start_node = next_node.node;
        set(nodes(next_node.node).child,'Color',MARKER_START_COLOR);
        text(nodes(next_node.node).x-5,nodes(next_node.node).y+5,num2str(node_count),'FontSize',20,'Color','w');
        
        if nodes(start_node).pool_id ~= 0
            pools_node_quantity(nodes(start_node).pool_id,2) = pools_node_quantity(nodes(start_node).pool_id,2) - 1;

            if pools_node_quantity(nodes(start_node).pool_id,2) == 0
                for j=1:nodes_quantity
                    check = find(pool_nodes(nodes(start_node).pool_id,:) == j);
                    if isempty(check) || j==start_node || nodes(j).child == 0
                    else
                        set(nodes(j).child,'Visible','off');
                        set(nodes(j).weighttext,'Visible','off');
                        nodes(j).child = 0; 
                        node_count = node_count + 1; % count the completed nodes
                    end
                end
            end
        end
        
        
        busy_node_time = ceil(nodes(start_node).time + next_node.time); %reset the busy-timer
        
        
        % check if still incomplete nodes avaiable
        if node_count == nodes_quantity;
            break;
        end
    end
    
    busy_node_time = busy_node_time - 1;

    %
    % result display
    %
    figure(PLAYAREA);
    title(strcat('Spielfeld; verbleibende Knoten:',num2str(nodes_quantity-node_count), ...
        '; Zeit: ',num2str(seconds),'s; Knotenzeit: ',num2str(busy_node_time),'s'));
    
    figure(NODEWEIGHT);
    subplot(212);
    plot(seconds,ww1,'ro');
    plot(seconds,ww2,'bo');
    
    subplot(211);
    weight_handle = plot(seconds,weight_history(:,seconds),'o','LineWidth',2);
    legend(weight_handle,'Ball 1','Ball 2','Ball 3','Ball 4','Ball 5','Ball 6','Fresco 1','Fresco 2',...
        'Fire 1','Fire 2','Fire 3');
end











%% 5. complete graph G = f(V,E); E=VxV
% figure(PLAYAREA);
% node_edge_to_node = zeros(nodes_quantity,nodes_quantity);
% node_edge_weight = zeros(nodes_quantity,nodes_quantity);
% for i = 1:nodes_quantity
%     for j = 1:nodes_quantity
%         dx = abs(nodes_x_positions(j)-nodes_x_positions(i));
%         dy = abs(nodes_y_positions(j)-nodes_y_positions(i));
%         
%         if dx > 0 || dy > 0
%             node_edge_to_node(i,j) = j;
%             node_edge_weight(i,j) = sqrt(dx^2 + dy^2);
%             plot([nodes_x_positions(i) nodes_x_positions(j)],...
%                 [nodes_y_positions(i) nodes_y_positions(j)]);
%         end
%     end
% end




%     for i = 1:nodes_quantity
%         for j = 1:nodes_quantity
%             
%             if i ~= j
%                 nodes(j).weight = node_weight(seconds,strategy_track_enemy_grid,nodes(j),...
%                     PLAYGROUND_IMAGE_WIDTH,PLAYGROUND_IMAGE_HEIGHT,PLAYGROUND_WIDTH,PLAYGROUND_HEIGHT,...
%                     STRATEGY_TRACK_ENEMY_GRID_SIZE_X,STRATEGY_TRACK_ENEMY_GRID_SIZE_Y);
%                 node_edge_weight(i,j) = sqrt((abs(nodes(i).x-nodes(j).x))^2+(abs(nodes(i).y-nodes(j).y))^2)+...
%                     nodes(j).weight;
%             end
%         end
%     end





%% 6. Prim algortihm -> min. spanning tree (MST)
% tree_node_connections = prim_alg(nodes_quantity, node_edge_weight, ...
%      nodes_x_positions, nodes_y_positions, LINE_TREE_COLOR, LINE_LINE_WIDTH);
% 
% 


%% 7. Dijstra alogrithm
%dijkstra_simple(node_edge_weight,1,12)
% => problem: destination must be *bekannt*

%% 8. TSP

%% 8.1 2-Approximation Algorithm for Metric TSP
% way = zeros(nodes_quantity,nodes_quantity);
% for i = 1:nodes_quantity
%     tmp = inf;
%     for j = 1:nodes_quantity
%         if tree_node_connections(mod(start_node-2+i,nodes_quantity)+1,j) ~= 0
%             if tree_node_connections(mod(start_node-2+i,nodes_quantity)+1,j) < tmp
%                 tmp = tree_node_connections(mod(start_node-2+i,nodes_quantity)+1,j);
%                 tmp_dest = j;    
%             end
%         end
%     end
%     way(mod(start_node-2+i,nodes_quantity)+1,tmp_dest) = tree_node_connections(mod(start_node-2+i,nodes_quantity)+1,tmp_dest);
% end

%% 8.1 Perfect matching with minimum weights

% % find odd nodes
% nodes_odd = zeros(1,nodes_quantity);
% odd_nodes_quantity = 0;
% for i = 1:nodes_quantity
%     edge_count = 0;
%     for j = 1:nodes_quantity
%         if tree_node_connections(i,j) ~= 0
%             edge_count = edge_count + 1;
%         end
%     end
%     
%     %check the node degree
%     if mod(edge_count,2) == 1
%         nodes_odd(i) = i;
%         odd_nodes_quantity = odd_nodes_quantity + 1;
%         set(nodes_child_data(i),'Color',MARKER_ODD_COLOR);
%     end
%     
% end
% 
% % draw a new complete graph (just for visualisation)
% for i = 1:nodes_quantity
%     if nodes_odd(i) ~= 0
%         for j = 1:nodes_quantity
%             if nodes_odd(j) ~= 0
%                 plot([nodes_x_positions(i) nodes_x_positions(j)],...
%                     [nodes_y_positions(i) nodes_y_positions(j)],MARKER_ODD_COLOR);
%             end
%         end
%     end
% end
% 
% 
% for i = 1:factorial(odd_nodes_quantity-1)/2
%     for j = 1:odd_nodes_quantity
%         
%     
%     end
%     
% end

















% n = 30;
% xy = [nodes_x_positions nodes_y_positions];
% popSize = 60; 
% numIter = 1e4;
% showProg = 1;
% showResult = 1;
% a = meshgrid(1:n);
% 
% dmat = node_edge_weight;
% [optRoute,minDist] = tspofs_ga(xy,dmat,popSize,numIter,showProg,showResult);





% Process Inputs and Initialize Defaults
% nargs = 6;
% for k = 6:nargs-1
%     switch k
%         case 0
%             xy = 10*rand(50,2);
%         case 1
%             N = size(xy,1);
%             a = meshgrid(1:N);
%             dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),N,N);
%         case 2
%             popSize = 100;
%         case 3
%             numIter = 1e4;
%         case 4
%             showProg = 1;
%         case 5
%             showResult = 1;
%         otherwise
%     end
% end

% Verify Inputs
% [N,dims] = size(xy);
% [nr,nc] = size(dmat);
% if N ~= nr || N ~= nc
%     error('Invalid XY or DMAT inputs!')
% end
% n = N - 1; % Separate Start City
% 
% % Sanity Checks
% popSize = 4*ceil(popSize/4);
% numIter = max(1,round(real(numIter(1))));
% showProg = logical(showProg(1));
% showResult = logical(showResult(1));
% 
% % Initialize the Population
% pop = zeros(popSize,n);
% pop(1,:) = (1:n) + 1; % alle Knoten der Reihe nach
% for k = 2:popSize
%     pop(k,:) = randperm(n) + 1;
% end
% 
% % Run the GA
% globalMin = Inf;
% totalDist = zeros(1,popSize);
% distHistory = zeros(1,numIter);
% tmpPop = zeros(4,n);
% newPop = zeros(popSize,n);
% if showProg
%     pfig = figure('Name','TSPOFS_GA | Current Best Solution','Numbertitle','off');
% end
% for iter = 1:numIter
%     % Evaluate Each Population Member (Calculate Total Distance)
%     % zufaehlig alle knoten miteinander verbinden und distanz messen
%     for p = 1:popSize
%         d = dmat(1,pop(p,1)); % Add Start Distance
%         for k = 2:n
%             d = d + dmat(pop(p,k-1),pop(p,k));
%         end
%         totalDist(p) = d;
%     end
% 
%     % Find the Best Route in the Population
%     [minDist,index] = min(totalDist);
%     distHistory(iter) = minDist; % zuvor bestimmte distanz speichern -> geht es kürzer?
%     if minDist < globalMin
%         globalMin = minDist;
%         optRoute = pop(index,:); %route der aktuell kürzesten route
%         if showProg
%             % Plot the Best Route
%             figure(pfig);
%             rte = [1 optRoute];
%             if dims > 2
%                 plot3(xy(rte,1),xy(rte,2),xy(rte,3),'r.-', ...
%                     xy(1,1),xy(1,2),xy(1,3),'ro');
%             else
%                 plot(xy(rte,1),xy(rte,2),'r.-',xy(1,1),xy(1,2),'ro');
%             end
%             title(sprintf('Total Distance = %1.4f, Iteration = %d',minDist,iter));
%         end
%     end
% 
%     % Genetic Algorithm Operators
%     randomOrder = randperm(popSize); %zufällige reihenfolge von routen-möglichkeiten festlegen
%     for p = 4:4:popSize
%         rtes = pop(randomOrder(p-3:p),:); %cluster von 4 routen-möglichkeiten bilden
%         dists = totalDist(randomOrder(p-3:p)); %kürzeste route des clusters herausfinden
%         [ignore,idx] = min(dists); % #ok
%         bestOf4Route = rtes(idx,:); %beste der 4 routen
%         routeInsertionPoints = sort(ceil(n*rand(1,2))); %2 zufällige knoten der besten route auswählen
%         I = routeInsertionPoints(1);
%         J = routeInsertionPoints(2);
%         for k = 1:4 % Mutate the Best to get Three New Routes
%             tmpPop(k,:) = bestOf4Route;
%             switch k
%                 case 2 % Flip
%                     tmpPop(k,I:J) = tmpPop(k,J:-1:I);
%                 case 3 % Swap
%                     tmpPop(k,[I J]) = tmpPop(k,[J I]);
%                 case 4 % Slide
%                     tmpPop(k,I:J) = tmpPop(k,[I+1:J I]);
%                 otherwise % Do Nothing
%             end
%         end
%         newPop(p-3:p,:) = tmpPop;
%     end
%     pop = newPop;
% end
% 
% if showResult
%     % Plots the GA Results
%     figure('Name','TSPOFS_GA | Results','Numbertitle','off');
%     subplot(2,2,1);
%     pclr = ~get(0,'DefaultAxesColor');
%     if dims > 2, plot3(xy(:,1),xy(:,2),xy(:,3),'.','Color',pclr);
%     else plot(xy(:,1),xy(:,2),'.','Color',pclr); end
%     title('City Locations');
%     subplot(2,2,2);
%     imagesc(dmat([1 optRoute],[1 optRoute]));
%     title('Distance Matrix');
%     subplot(2,2,3);
%     rte = [1 optRoute];
%     if dims > 2
%         plot3(xy(rte,1),xy(rte,2),xy(rte,3),'r.-', ...
%             xy(1,1),xy(1,2),xy(1,3),'ro');
%     else
%         plot(xy(rte,1),xy(rte,2),'r.-',xy(1,1),xy(1,2),'ro');
%     end
%     title(sprintf('Total Distance = %1.4f',minDist));
%     subplot(2,2,4);
%     plot(distHistory,'b','LineWidth',2);
%     title('Best Solution History');
%     set(gca,'XLim',[0 numIter+1],'YLim',[0 1.1*max([1 distHistory])]);
% end
% 
% % Return Outputs
% if nargout
%     varargout{1} = optRoute;
%     varargout{2} = minDist;
% end

















