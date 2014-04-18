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
MARKER_NORMAL_SUB_COLORSHAPE = 'mo';
MARKER_START_COLORSHAPE = 'yo';
MARKER_NORMAL_COLOR = 'r';
MARKER_START_COLOR = 'g';
MARKER_NEXT_COLOR = 'y';
MARKER_ODD_COLOR = 'm';
MARKER_CLUSTER_COLOR = 'b';
LINE_TREE_COLOR = 'g';
LINE_GRID_COLORSHAPE = 'k--';


% play ground %
PLAYGROUND_IMAGE = imread('res/playground_small','png');
PLAYGROUND_IMAGE_WIDTH = size(PLAYGROUND_IMAGE,2);
PLAYGROUND_IMAGE_HEIGHT = size(PLAYGROUND_IMAGE,1);

%%%%%%%%%%%%%%%%%%%%%%%%
% global game settings %
%%%%%%%%%%%%%%%%%%%%%%%%
TEAMCOLOR = 1; % yellow := 0; red := 1
PLAY_TIME = 90; % time in seconds 
ROBO_AVERAGE_SPEED = 0.5; % m/s
TOTAL_POINTS = 15; % total points (3x fire + 2x fire wall + net + 2x fire on heart
PLAYGROUND_WIDTH = 3; % width in meter
PLAYGROUND_HEIGHT = 2; % height in meter


% strategy settings %
STRATEGY_TRACK_ENEMY_GRID_SIZE_X = 10e-2; %10cm
STRATEGY_TRACK_ENEMY_GRID_SIZE_Y = 10e-2; %10cm
STRATEGY_TRACK_CENTER_WEIGHT = 3;
STRATEGY_TRACK_FRAME_WEIGHT = 2;
STRATEGY_TRACK_TRESHHOLD = 5;

% node settings %
NODE_QUANTITY_MAIN = 9;
NODE_QUANTITY_SUB = 2;
NODE_GRAPH_NO_SUB_ID = 0;
NODE_GRAPH_SUB_ID = 1;

% node arrive direction %
NORTH = 0;
EAST = 1;
SOUTH = 2;
WEST = 3;
ARRIVE_NODE_FRAME = 15e-2; %15cm

% fire wall
NODE_FIRE_WALL_ID = 1;
NODE_FIRE_WALL_EASY_TIME = 3; %[s]
NODE_FIRE_WALL_HEAVY_TIME = 5; %[s]
NODE_FIRE_WALL_POINT = 1; %max. possible points;
NODE_FIRE_WALL_PERCENT_OF_POINTS = 2*NODE_FIRE_WALL_POINT/TOTAL_POINTS/2;
NODE_FIRE_WALL_1_X_POSITION = 0.05; % [m]
NODE_FIRE_WALL_1_Y_POSITION = 0.8; % [m]
NODE_FIRE_WALL_2_X_POSITION = 1.3; % [m]
NODE_FIRE_WALL_2_Y_POSITION = 1.95; % [m]
NODE_FIRE_WALL_3_X_POSITION = 1.7; % [m]
NODE_FIRE_WALL_3_Y_POSITION = 1.95; % [m]
NODE_FIRE_WALL_4_X_POSITION = 2.95; % [m]
NODE_FIRE_WALL_4_Y_POSITION = 0.8; % [m]

% start
NODE_START_ID = 2;
NODE_START_TIME = 1;
NODE_START_POINT = 1;
NODE_START_PERCENT_OF_POINTS = 1*NODE_START_POINT/TOTAL_POINTS/1;
% red %
if TEAMCOLOR == 1
    NODE_START_X_POSITION = 0.25; % [m]
    NODE_START_Y_POSITION = 0.25; % [m]
% yellow %
else
    NODE_START_X_POSITION = 2.7; % [m]
    NODE_START_Y_POSITION = 0.25; % [m]
end

% fire pools
NODE_FIRE_POOL_ID = 3;
NODE_FIRE_POOL_TIME = 3; %[s]
NODE_FIRE_POOL_POINT = 4;
NODE_FIRE_POOL_PERCENT_OF_POINTS = 1*NODE_FIRE_POOL_POINT/TOTAL_POINTS/1;
NODE_FIRE_POOL_1_X_POSITION = 0.9; % [m]
NODE_FIRE_POOL_1_Y_POSITION = 1.1; % [m]
NODE_FIRE_POOL_2_X_POSITION = 2.1; % [m]
NODE_FIRE_POOL_2_Y_POSITION = 1.1; % [m]

% heart of fire
NODE_HEART_FIRE_ID = 5;
NODE_HEART_FIRE_TIME = 15;
NODE_HEART_FIRE_POINT = 4;
NODE_HEART_FIRE_PERCENT_OF_POINTS = 2*NODE_HEART_FIRE_POINT/TOTAL_POINTS/2;
NODE_HEART_FIRE_1_X_POSITION = 0.1; % [m]
NODE_HEART_FIRE_1_Y_POSITION = 1.9; % [m]
NODE_HEART_FIRE_2_X_POSITION = 1.5; % [m]
NODE_HEART_FIRE_2_Y_POSITION = 1.05; % [m]
NODE_HEART_FIRE_3_X_POSITION = 2.9; % [m]
NODE_HEART_FIRE_3_Y_POSITION = 1.9; % [m]

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
NODE_FIRE_4_X_POSITION = 0.9; % [m]
NODE_FIRE_4_Y_POSITION = 0.60; % [m]
NODE_FIRE_5_X_POSITION = 0.4; % [m]
NODE_FIRE_5_Y_POSITION = 1.1; % [m]
NODE_FIRE_6_X_POSITION = 0.9; % [m]
NODE_FIRE_6_Y_POSITION = 1.6; % [m]


% net %
NODE_NET_ID = 6;
NODE_NET_TIME = 1; %[s]
NODE_NET_POINT = 6;
NODE_NET_PERCENT_OF_POINTS = 1*NODE_NET_POINT/TOTAL_POINTS/1;
NODE_NET_1_X_POSITION = 0.4; % [m]
NODE_NET_1_Y_POSITION = 0.60; % [m]
NODE_NET_2_X_POSITION = 0.7; % [m]
NODE_NET_2_Y_POSITION = 0.60; % [m]
NODE_NET_3_X_POSITION = 1; % [m]
NODE_NET_3_Y_POSITION = 0.60; % [m]
NODE_NET_4_X_POSITION = 2.0; % [m]
NODE_NET_4_Y_POSITION = 0.60; % [m]
NODE_NET_5_X_POSITION = 2.3; % [m]
NODE_NET_5_Y_POSITION = 0.60; % [m]
NODE_NET_6_X_POSITION = 2.6; % [m]
NODE_NET_6_Y_POSITION = 0.60; % [m]



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
nodes_quantity_main = NODE_QUANTITY_MAIN;
nodes_quantity_sub = NODE_QUANTITY_SUB;


%% 3. set the nodes
% red %
if TEAMCOLOR == 1
    
    % fire 1 %
    nodes_main(1).id = NODE_FIRE_ID;
    nodes_main(1).points = NODE_FIRE_POINT;
    nodes_main(1).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(1).time = NODE_FIRE_TIME;
    nodes_main(1).x = (NODE_FIRE_4_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(1).y = (NODE_FIRE_4_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(1).weight = 0;
    nodes_main(1).weighttext = text(nodes_main(1).x-MARKER_SIZE,nodes_main(1).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(1).pool_id = 0; %ID of the pool
    nodes_main(1).child = 0;
    nodes_main(1).arrive = WEST;
    nodes_main(1).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire 2 %
    nodes_main(2).id = NODE_FIRE_ID;
    nodes_main(2).points = NODE_FIRE_POINT;
    nodes_main(2).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(2).time = NODE_FIRE_TIME;
    nodes_main(2).x = (NODE_FIRE_5_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(2).y = (NODE_FIRE_5_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(2).weight = 0;
    nodes_main(2).weighttext = text(nodes_main(2).x-MARKER_SIZE,nodes_main(2).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(2).pool_id = 0; %ID of the pool
    nodes_main(2).child = 0;
    nodes_main(2).arrive = NORTH;
    nodes_main(2).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire 3 %
    nodes_main(3).id = NODE_FIRE_ID;
    nodes_main(3).points = NODE_FIRE_POINT;
    nodes_main(3).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(3).time = NODE_FIRE_TIME;
    nodes_main(3).x = (NODE_FIRE_6_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(3).y = (NODE_FIRE_6_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(3).weight = 0;
    nodes_main(3).weighttext = text(nodes_main(3).x-MARKER_SIZE,nodes_main(3).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(3).pool_id = 0; %ID of the pool
    nodes_main(3).child = 0;
    nodes_main(3).arrive = EAST;
    nodes_main(3).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire wall 1 %
    nodes_main(4).id = NODE_FIRE_WALL_ID;
    nodes_main(4).points = NODE_FIRE_WALL_POINT;
    nodes_main(4).percent = NODE_FIRE_WALL_PERCENT_OF_POINTS;
    nodes_main(4).time = NODE_FIRE_WALL_EASY_TIME;
    nodes_main(4).x = (NODE_FIRE_WALL_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(4).y = (NODE_FIRE_WALL_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(4).weight = 0;
    nodes_main(4).weighttext = text(nodes_main(4).x-MARKER_SIZE,nodes_main(4).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(4).pool_id = 0; %ID of the pool
    nodes_main(4).child = 0;
    nodes_main(4).arrive = EAST;
    nodes_main(4).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire wall 2 %
    nodes_main(5).id = NODE_FIRE_WALL_ID;
    nodes_main(5).points = NODE_FIRE_WALL_POINT;
    nodes_main(5).percent = NODE_FIRE_WALL_PERCENT_OF_POINTS;
    nodes_main(5).time = NODE_FIRE_WALL_HEAVY_TIME;
    nodes_main(5).x = (NODE_FIRE_WALL_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(5).y = (NODE_FIRE_WALL_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(5).weight = 0;
    nodes_main(5).weighttext = text(nodes_main(5).x-MARKER_SIZE,nodes_main(5).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(5).pool_id = 0; %ID of the pool
    nodes_main(5).child = 0;
    nodes_main(5).arrive = NORTH;
    nodes_main(5).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire pool %
    nodes_main(6).id = NODE_FIRE_POOL_ID;
    nodes_main(6).points = NODE_FIRE_POOL_POINT;
    nodes_main(6).percent = NODE_FIRE_POOL_PERCENT_OF_POINTS;
    nodes_main(6).time = NODE_FIRE_POOL_TIME;
    nodes_main(6).x = (NODE_FIRE_POOL_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(6).y = (NODE_FIRE_POOL_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(6).weight = 0;
    nodes_main(6).weighttext = text(nodes_main(6).x-MARKER_SIZE,nodes_main(6).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(6).pool_id = 0; %ID of the pool
    nodes_main(6).child = 0;
    nodes_main(6).arrive = WEST;
    nodes_main(6).sub = NODE_GRAPH_SUB_ID;
    
    % heart fire 1 %
    nodes_sub(1).id = NODE_HEART_FIRE_ID;
    nodes_sub(1).points = NODE_HEART_FIRE_POINT;
    nodes_sub(1).percent = NODE_HEART_FIRE_PERCENT_OF_POINTS;
    nodes_sub(1).time = NODE_HEART_FIRE_TIME;
    nodes_sub(1).x = (NODE_HEART_FIRE_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(1).y = (NODE_HEART_FIRE_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(1).weight = 0;
    nodes_sub(1).weighttext = text(nodes_sub(1).x-MARKER_SIZE,nodes_sub(1).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_sub(1).pool_id = 0; %ID of the pool
    nodes_sub(1).child = 0;
    nodes_sub(1).arrive = EAST;
    nodes_sub(1).sub = NODE_GRAPH_NO_SUB_ID;
    
    % heart fire 2 %
    nodes_sub(2).id = NODE_HEART_FIRE_ID;
    nodes_sub(2).points = NODE_HEART_FIRE_POINT;
    nodes_sub(2).percent = NODE_HEART_FIRE_PERCENT_OF_POINTS;
    nodes_sub(2).time = NODE_HEART_FIRE_TIME;
    nodes_sub(2).x = (NODE_HEART_FIRE_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(2).y = (NODE_HEART_FIRE_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(2).weight = 0;
    nodes_sub(2).weighttext = text(nodes_sub(2).x-MARKER_SIZE,nodes_sub(2).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_sub(2).pool_id = 0; %ID of the pool
    nodes_sub(2).child = 0;
    nodes_sub(2).arrive = WEST;
    nodes_sub(2).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 1 %
    nodes_main(7).id = NODE_NET_ID;
    nodes_main(7).points = NODE_NET_POINT;
    nodes_main(7).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(7).time = NODE_NET_TIME;
    nodes_main(7).x = (NODE_NET_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(7).y = (NODE_NET_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(7).weight = 0;
    nodes_main(7).weighttext = text(nodes_main(7).x-MARKER_SIZE,nodes_main(7).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(7).pool_id = 0; %ID of the pool
    nodes_main(7).child = 0;
    nodes_main(7).arrive = SOUTH;
    nodes_main(7).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 2 %
    nodes_main(8).id = NODE_NET_ID;
    nodes_main(8).points = NODE_NET_POINT;
    nodes_main(8).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(8).time = NODE_NET_TIME;
    nodes_main(8).x = (NODE_NET_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(8).y = (NODE_NET_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(8).weight = 0;
    nodes_main(8).weighttext = text(nodes_main(8).x-MARKER_SIZE,nodes_main(8).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(8).pool_id = 0; %ID of the pool
    nodes_main(8).child = 0;
    nodes_main(8).arrive = SOUTH;
    nodes_main(8).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 3 %
    nodes_main(9).id = NODE_NET_ID;
    nodes_main(9).points = NODE_NET_POINT;
    nodes_main(9).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(9).time = NODE_NET_TIME;
    nodes_main(9).x = (NODE_NET_3_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(9).y = (NODE_NET_3_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(9).weight = 0;
    nodes_main(9).weighttext = text(nodes_main(9).x-MARKER_SIZE,nodes_main(9).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(9).pool_id = 0; %ID of the pool
    nodes_main(9).child = 0;
    nodes_main(9).arrive = SOUTH;
    nodes_main(9).sub = NODE_GRAPH_NO_SUB_ID;

    
% yellow %
else
    
    % fire 1 %
    nodes_main(1).id = NODE_FIRE_ID;
    nodes_main(1).points = NODE_FIRE_POINT;
    nodes_main(1).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(1).time = NODE_FIRE_TIME;
    nodes_main(1).x = (NODE_FIRE_1_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(1).y = (NODE_FIRE_1_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(1).weight = 0;
    nodes_main(1).weighttext = text(nodes_main(1).x-MARKER_SIZE,nodes_main(1).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(1).pool_id = 0; %ID of the pool
    nodes_main(1).child = 0;
    nodes_main(1).arrive = EAST;
    nodes_main(1).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire 2 %
    nodes_main(2).id = NODE_FIRE_ID;
    nodes_main(2).points = NODE_FIRE_POINT;
    nodes_main(2).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(2).time = NODE_FIRE_TIME;
    nodes_main(2).x = (NODE_FIRE_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(2).y = (NODE_FIRE_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(2).weight = 0;
    nodes_main(2).weighttext = text(nodes_main(2).x-MARKER_SIZE,nodes_main(2).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(2).pool_id = 0; %ID of the pool
    nodes_main(2).child = 0;
    nodes_main(2).arrive = NORTH;
    nodes_main(2).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire 3 %
    nodes_main(3).id = NODE_FIRE_ID;
    nodes_main(3).points = NODE_FIRE_POINT;
    nodes_main(3).percent = NODE_FIRE_PERCENT_OF_POINTS;
    nodes_main(3).time = NODE_FIRE_TIME;
    nodes_main(3).x = (NODE_FIRE_3_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(3).y = (NODE_FIRE_3_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(3).weight = 0;
    nodes_main(3).weighttext = text(nodes_main(3).x-MARKER_SIZE,nodes_main(3).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(3).pool_id = 0; %ID of the pool
    nodes_main(3).child = 0;
    nodes_main(3).arrive = WEST;
    nodes_main(3).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire wall 1 %
    nodes_main(4).id = NODE_FIRE_WALL_ID;
    nodes_main(4).points = NODE_FIRE_WALL_POINT;
    nodes_main(4).percent = NODE_FIRE_WALL_PERCENT_OF_POINTS;
    nodes_main(4).time = NODE_FIRE_WALL_EASY_TIME;
    nodes_main(4).x = (NODE_FIRE_WALL_4_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(4).y = (NODE_FIRE_WALL_4_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(4).weight = 0;
    nodes_main(4).weighttext = text(nodes_main(4).x-MARKER_SIZE,nodes_main(4).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(4).pool_id = 0; %ID of the pool
    nodes_main(4).child = 0;
    nodes_main(4).arrive = WEST;
    nodes_main(4).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire wall 2 %
    nodes_main(5).id = NODE_FIRE_WALL_ID;
    nodes_main(5).points = NODE_FIRE_WALL_POINT;
    nodes_main(5).percent = NODE_FIRE_WALL_PERCENT_OF_POINTS;
    nodes_main(5).time = NODE_FIRE_WALL_HEAVY_TIME;
    nodes_main(5).x = (NODE_FIRE_WALL_3_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(5).y = (NODE_FIRE_WALL_3_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(5).weight = 0;
    nodes_main(5).weighttext = text(nodes_main(5).x-MARKER_SIZE,nodes_main(5).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(5).pool_id = 0; %ID of the pool
    nodes_main(5).child = 0;
    nodes_main(5).arrive = NORTH;
    nodes_main(5).sub = NODE_GRAPH_NO_SUB_ID;
    
    % fire pool %
    nodes_main(6).id = NODE_FIRE_POOL_ID;
    nodes_main(6).points = NODE_FIRE_POOL_POINT;
    nodes_main(6).percent = NODE_FIRE_POOL_PERCENT_OF_POINTS;
    nodes_main(6).time = NODE_FIRE_POOL_TIME;
    nodes_main(6).x = (NODE_FIRE_POOL_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(6).y = (NODE_FIRE_POOL_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(6).weight = 0;
    nodes_main(6).weighttext = text(nodes_main(6).x-MARKER_SIZE,nodes_main(6).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(6).pool_id = 0; %ID of the pool
    nodes_main(6).child = 0;
    nodes_main(6).arrive = WEST;
    nodes_main(6).sub = NODE_GRAPH_SUB_ID;
    
    % heart fire 1 %
    nodes_sub(1).id = NODE_HEART_FIRE_ID;
    nodes_sub(1).points = NODE_HEART_FIRE_POINT;
    nodes_sub(1).percent = NODE_HEART_FIRE_PERCENT_OF_POINTS;
    nodes_sub(1).time = NODE_HEART_FIRE_TIME;
    nodes_sub(1).x = (NODE_HEART_FIRE_3_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(1).y = (NODE_HEART_FIRE_3_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(1).weight = 0;
    nodes_sub(1).weighttext = text(nodes_sub(1).x-MARKER_SIZE,nodes_sub(1).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_sub(1).pool_id = 0; %ID of the pool
    nodes_sub(1).child = 0;
    nodes_sub(1).arrive = WEST;
    nodes_sub(1).sub = NODE_GRAPH_NO_SUB_ID;
    
    % heart fire 2 %
    nodes_sub(2).id = NODE_HEART_FIRE_ID;
    nodes_sub(2).points = NODE_HEART_FIRE_POINT;
    nodes_sub(2).percent = NODE_HEART_FIRE_PERCENT_OF_POINTS;
    nodes_sub(2).time = NODE_HEART_FIRE_TIME;
    nodes_sub(2).x = (NODE_HEART_FIRE_2_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(2).y = (NODE_HEART_FIRE_2_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_sub(2).weight = 0;
    nodes_sub(2).weighttext = text(nodes_sub(2).x-MARKER_SIZE,nodes_sub(2).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_sub(2).pool_id = 0; %ID of the pool
    nodes_sub(2).child = 0;
    nodes_sub(2).arrive = EAST;
    nodes_sub(2).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 1 %
    nodes_main(7).id = NODE_NET_ID;
    nodes_main(7).points = NODE_NET_POINT;
    nodes_main(7).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(7).time = NODE_NET_TIME;
    nodes_main(7).x = (NODE_NET_4_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(7).y = (NODE_NET_4_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(7).weight = 0;
    nodes_main(7).weighttext = text(nodes_main(7).x-MARKER_SIZE,nodes_main(7).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(7).pool_id = 0; %ID of the pool
    nodes_main(7).child = 0;
    nodes_main(7).arrive = SOUTH;
    nodes_main(7).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 2 %
    nodes_main(8).id = NODE_NET_ID;
    nodes_main(8).points = NODE_NET_POINT;
    nodes_main(8).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(8).time = NODE_NET_TIME;
    nodes_main(8).x = (NODE_NET_5_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(8).y = (NODE_NET_5_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(8).weight = 0;
    nodes_main(8).weighttext = text(nodes_main(8).x-MARKER_SIZE,nodes_main(8).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(8).pool_id = 0; %ID of the pool
    nodes_main(8).child = 0;
    nodes_main(8).arrive = SOUTH;
    nodes_main(8).sub = NODE_GRAPH_NO_SUB_ID;
    
    % net 3 %
    nodes_main(9).id = NODE_NET_ID;
    nodes_main(9).points = NODE_NET_POINT;
    nodes_main(9).percent = NODE_NET_PERCENT_OF_POINTS;
    nodes_main(9).time = NODE_NET_TIME;
    nodes_main(9).x = (NODE_NET_6_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(9).y = (NODE_NET_6_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH;
    nodes_main(9).weight = 0;
    nodes_main(9).weighttext = text(nodes_main(9).x-MARKER_SIZE,nodes_main(9).y+MARKER_SIZE+MARKER_LINE_WIDHT,'weight','Color','m');
    nodes_main(9).pool_id = 0; %ID of the pool
    nodes_main(9).child = 0;
    nodes_main(9).arrive = SOUTH;
    nodes_main(9).sub = NODE_GRAPH_NO_SUB_ID;
    
end

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

% plot start point %
plot((NODE_START_X_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH,(NODE_START_Y_POSITION*PLAYGROUND_IMAGE_WIDTH)/PLAYGROUND_WIDTH,...
    MARKER_START_COLORSHAPE,'MarkerSize',MARKER_SIZE,'LineWidth',MARKER_LINE_WIDHT);
% plot the main-nodes
for i = 1:nodes_quantity_main
    
    plot(nodes_main(i).x,nodes_main(i).y,MARKER_NORMAL_COLORSHAPE,...
        'MarkerSize',MARKER_SIZE,'LineWidth',MARKER_LINE_WIDHT);
    tmp_child_data = get(gca,'Children');
    nodes_main(i).child = tmp_child_data(1);
end

% plot the sub-nodes
for i = 1:nodes_quantity_sub
    
    plot(nodes_sub(i).x,nodes_sub(i).y,MARKER_NORMAL_SUB_COLORSHAPE,...
        'MarkerSize',MARKER_SIZE,'LineWidth',MARKER_LINE_WIDHT);
    tmp_child_data = get(gca,'Children');
    nodes_sub(i).child = tmp_child_data(1); 
end


%% 5. select pools
% set the pool quantity
repeat = 1;
pool_quantity = input('how many node-pools: ');
while repeat == 1
    if pool_quantity > nodes_quantity_main-1
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
        if pools_node_quantity(i,1) > nodes_quantity_main-1
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
            for k = 1:nodes_quantity_main
                if tmp_x < nodes_main(k).x + MARKER_SIZE/2
                    if tmp_x > nodes_main(k).x - MARKER_SIZE/2
                        if tmp_y < nodes_main(k).y + MARKER_SIZE/2
                            if tmp_y > nodes_main(k).y - MARKER_SIZE/2
                                set(nodes_main(k).child,'Color',MARKER_CLUSTER_COLOR);
                                pool_nodes(i,j) = k;
                                nodes_main(k).pool_id = i;
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
        rectangle('Position', [nodes_main(pool_nodes(i,j)).x-MARKER_SIZE/2-5 ...
            nodes_main(pool_nodes(i,j)).y-MARKER_SIZE/2-5 ...
            MARKER_SIZE+10 MARKER_SIZE+10], ...
            'EdgeColor',pool_colors(1,:), ...
            'LineWidth', MARKER_LINE_WIDHT);
        tmp_child_data = get(gca,'Children');
        set(nodes_main(pool_nodes(i,j)).child,'Color',MARKER_NORMAL_COLOR);
    end
    
end


%% 4. mark the start node
% init variables
repeat = 1;
node_count = 1;
disp('mark the start node');
while repeat == 1
    [tmp_x,tmp_y]=ginput(1);
    for i = 1:nodes_quantity_main
        if tmp_x < nodes_main(i).x + MARKER_SIZE/2
            if tmp_x > nodes_main(i).x - MARKER_SIZE/2
                if tmp_y < nodes_main(i).y + MARKER_SIZE/2
                    if tmp_y > nodes_main(i).y - MARKER_SIZE/2
                        start_node = i;
                        way_time = sqrt((abs((nodes_main(start_node).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH-NODE_START_X_POSITION))^2 ...
                            +(abs((nodes_main(start_node).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT-NODE_START_Y_POSITION))^2)/ROBO_AVERAGE_SPEED;
                        busy_node_time = ceil(nodes_main(start_node).time + way_time);
                        set(nodes_main(i).child,'Color',MARKER_START_COLOR);
                        set(nodes_main(i).weighttext,'Visible','off');
                        text(nodes_main(i).x-5,nodes_main(i).y+5,num2str(node_count),'FontSize',20,'Color','w');
                        
                        % if the start node a member of a pool, check if the pool is completed
                        if nodes_main(start_node).pool_id ~= 0
                            pools_node_quantity(nodes_main(start_node).pool_id,2) = pools_node_quantity(nodes_main(start_node).pool_id,2) - 1;

                            if pools_node_quantity(nodes_main(start_node).pool_id,2) == 0
                                for j=1:nodes_quantity_main
                                    check = find(pool_nodes(nodes_main(start_node).pool_id,:) == j);
                                    if isempty(check) || j==start_node || nodes_main(j).child == 0  
                                    else
                                        set(nodes_main(j).child,'Visible','off');
                                        set(nodes_main(j).weighttext,'Visible','off');
                                        nodes_main(j).child = 0; 
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
weight_history = zeros(NODE_QUANTITY_MAIN,PLAY_TIME);
time = zeros(NODE_QUANTITY_MAIN,PLAY_TIME);
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
    for i = 1:nodes_quantity_main
        
        % destination node point-weight
        switch nodes_main(i).arrive
            case NORTH
                % class 4 weighting %
                if nodes_main(i).y < nodes_main(start_node).y
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 4;
                
                % class 3 weighting %
                elseif nodes_main(i).y >= nodes_main(start_node).y ...
                        && nodes_main(i).y - (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT < nodes_main(start_node).y
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 3;
                    
                % class 2 weighting %
                elseif (nodes_main(i).y - (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT) >= nodes_main(start_node).y ...
                        && (nodes_main(i).x - (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH >= nodes_main(start_node).x  ...
                        || nodes_main(i).x + (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH <= nodes_main(start_node).x )
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 2;
                    
                % class 1 weighting %
                else
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent);
                    
                end
                
            case EAST
                % class 4 weighting %
                if nodes_main(i).x > nodes_main(start_node).x
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 4;
                
                % class 3 weighting %
                elseif nodes_main(i).x <= nodes_main(start_node).x ...
                        && nodes_main(i).x + (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH > nodes_main(start_node).x
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 3;
                    
                % class 2 weighting %
                elseif nodes_main(i).x + (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH <= nodes_main(start_node).x ...
                        && (nodes_main(i).y - (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT >= nodes_main(start_node).y ...
                        || nodes_main(i).y + (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT <= nodes_main(start_node).y)
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 2;
                    
                % class 1 weighting %
                else
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent);
                    
                end
                
            case SOUTH
                % class 4 weighting %
                if nodes_main(i).y > nodes_main(start_node).y
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 4;
                
                % class 3 weighting %
                elseif nodes_main(i).y <= nodes_main(start_node).y ...
                        && nodes_main(i).y + (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT > nodes_main(start_node).y
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 3;
                    
                % class 2 weighting %
                elseif (nodes_main(i).y + (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT) <= nodes_main(start_node).y ...
                        && (nodes_main(i).x - (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH >= nodes_main(start_node).x  ...
                        || nodes_main(i).x + (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH <= nodes_main(start_node).x )
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 2;
                    
                % class 1 weighting %
                else
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent);
                    
                end
                
            case WEST
                % class 4 weighting %
                if nodes_main(i).x < nodes_main(start_node).x
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 4;
                
                % class 3 weighting %
                elseif nodes_main(i).x >= nodes_main(start_node).x ...
                        && nodes_main(i).x - (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH < nodes_main(start_node).x
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 3;
                    
                % class 2 weighting %
                elseif nodes_main(i).x - (ARRIVE_NODE_FRAME/PLAYGROUND_WIDTH)*PLAYGROUND_IMAGE_WIDTH >= nodes_main(start_node).x ...
                        && (nodes_main(i).y - (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT >= nodes_main(start_node).y ...
                        || nodes_main(i).y + (ARRIVE_NODE_FRAME/PLAYGROUND_HEIGHT)*PLAYGROUND_IMAGE_HEIGHT <= nodes_main(start_node).y)
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent) * 2;
                    
                % class 1 weighting %
                else
                    w_dest = (nodes_main(i).points/nodes_main(i).time)*(1/nodes_main(i).percent);
                    
                end
        end
        
        
        % destination node enemy-weight
        w_enemy = strategy_track_enemy_grid(...
        ceil(nodes_main(i).y/(PLAYGROUND_IMAGE_HEIGHT/(PLAYGROUND_HEIGHT/STRATEGY_TRACK_ENEMY_GRID_SIZE_Y))),...
        ceil(nodes_main(i).x/(PLAYGROUND_IMAGE_WIDTH/(PLAYGROUND_WIDTH/STRATEGY_TRACK_ENEMY_GRID_SIZE_X))));
        nodes_main(i).weight = ww1 * w_dest + ww1 * w_enemy;

        % source -> destination node distance-time weight
        w_src_dest = sqrt((abs((nodes_main(start_node).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH-(nodes_main(i).x*PLAYGROUND_WIDTH)/PLAYGROUND_IMAGE_WIDTH))^2 ...
         +(abs((nodes_main(start_node).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT-(nodes_main(i).y*PLAYGROUND_HEIGHT)/PLAYGROUND_IMAGE_HEIGHT))^2)/ROBO_AVERAGE_SPEED;

        node_edge_weight(start_node,i) = ww1 * w_dest + ww1 * w_enemy + ww2 * w_src_dest;
        weight_history(i,seconds) = ww1 * w_dest + ww1 * w_enemy + w_src_dest;
        
        % plot weight informations            
        set(nodes_main(i).weighttext,'String',num2str(node_edge_weight(start_node,i)));
    end
       
    
    %
    % next-node searching
    %
    % unselect the last next node
    if exist('next_node','var') == 1 && start_node ~= next_node.node
        set(nodes_main(next_node.node).child,'Color',MARKER_NORMAL_COLOR);
    end
    
    next_node.weight = inf;%node_edge_weight(start_node,1);

    for i = 1:nodes_quantity_main
        if nodes_main(i).child ~= 0 && i ~= start_node
            % find the best node (lowest weight)
            if next_node.weight > node_edge_weight(start_node,i)
                next_node.node = i;
                next_node.time = w_src_dest/ROBO_AVERAGE_SPEED;
                next_node.weight = node_edge_weight(start_node,i);
            end
        end
    end
    
    set(nodes_main(next_node.node).child,'Color',MARKER_NEXT_COLOR);
    
    % current node is done %
    if busy_node_time <= 0
        node_count = node_count + 1; % count the completed nodes
        
        % plot informations in playground
        figure(PLAYAREA);
        % draw route
        plot([nodes_main(start_node).x nodes_main(next_node.node).x],[nodes_main(start_node).y nodes_main(next_node.node).y],LINE_TREE_COLOR,'LineWidth',2);
        
        % disable the last and now completed node
        set(nodes_main(start_node).child,'Visible','off');
        set(nodes_main(start_node).weighttext,'Visible','off');
        nodes_main(start_node).child = 0;
        
        % goto next node
        start_node = next_node.node;
        set(nodes_main(next_node.node).child,'Color',MARKER_START_COLOR);
        text(nodes_main(next_node.node).x-5,nodes_main(next_node.node).y+5,num2str(node_count),'FontSize',20,'Color','w');
        
        % if the next node a member of a pool, check if the pool is completed
        if nodes_main(start_node).pool_id ~= 0
            pools_node_quantity(nodes_main(start_node).pool_id,2) = pools_node_quantity(nodes_main(start_node).pool_id,2) - 1;

            if pools_node_quantity(nodes_main(start_node).pool_id,2) == 0
                for j=1:nodes_quantity_main
                    check = find(pool_nodes(nodes_main(start_node).pool_id,:) == j);
                    if isempty(check) || j==start_node || nodes_main(j).child == 0
                    else
                        set(nodes_main(j).child,'Visible','off');
                        set(nodes_main(j).weighttext,'Visible','off');
                        nodes_main(j).child = 0; 
                        node_count = node_count + 1; % count the completed nodes
                    end
                end
            end
        end
        
        %reset the busy-timer
        busy_node_time = ceil(nodes_main(start_node).time + next_node.time); 
         
        % check if still incomplete nodes avaiable
        if node_count == nodes_quantity_main;
            break;
        end
    end
    
    busy_node_time = busy_node_time - 1;

    %
    % result display
    %
    figure(PLAYAREA);
    title(strcat('Spielfeld; verbleibende Knoten:',num2str(nodes_quantity_main-node_count), ...
        '; Zeit: ',num2str(seconds),'s; Knotenzeit: ',num2str(busy_node_time),'s'));
    
    figure(NODEWEIGHT);
    subplot(212);
    plot(seconds,ww1,'ro');
    plot(seconds,ww2,'bo');
    
    subplot(211);
    weight_handle = plot(seconds,weight_history(:,seconds),'o','LineWidth',2);
    legend(weight_handle,'Fire 1','Fire 2','Fire 3','Fire Wall 1','Fire Wall 2','Fire Pool',...
        'Net 1','Net 2','Net 3');
end



















