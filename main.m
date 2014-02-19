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
MARKER_CLUSTER_COLOR = 'b';
LINE_TREE_COLOR = 'g';


% play ground %
PLAYGROUND_IMAGE = imread('res/playground_small','png');
PLAYGROUND_IMAGE_WIDTH = size(PLAYGROUND_IMAGE,2);
PLAYGROUND_IMAGE_HEIGHT = size(PLAYGROUND_IMAGE,1);
imshow(PLAYGROUND_IMAGE);
hold on;


% global game settings %
PLAY_TIME = 90; % time in seconds 
PLAYGROUND_WIDTH = 3; % width in meter
PLAYGROUND_HEIGHT = 2; % height in meter


% strategy settings %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. set node quantity 
nodes_quantity = input('how many strategy nodes? : ');
nodes_x_positions = zeros(nodes_quantity,1);
nodes_y_positions = zeros(nodes_quantity,1);
nodes_child_data = zeros(nodes_quantity,1);

%% 2. set the nodes
disp('please set the nodes positions');
for i = 1:nodes_quantity
    [nodes_x_positions(i),nodes_y_positions(i)]=ginput(1);
    plot(nodes_x_positions(i),nodes_y_positions(i),MARKER_NORMAL_COLORSHAPE,...
        'MarkerSize',MARKER_SIZE,'LineWidth',MARKER_LINE_WIDHT);
    tmp_child_data = get(gca,'Children');
    nodes_child_data(i) = tmp_child_data(1); %set( dataH(1), 'visible', 'off' )
end

%% 3. select the start node
repeat = 1;
disp('mark the start node');
while repeat == 1
    [tmp_x,tmp_y]=ginput(1);
    for i = 1:nodes_quantity
        if tmp_x < nodes_x_positions(i) + MARKER_SIZE/2
            if tmp_x > nodes_x_positions(i) - MARKER_SIZE/2
                if tmp_y < nodes_y_positions(i) + MARKER_SIZE/2
                    if tmp_y > nodes_y_positions(i) - MARKER_SIZE/2
                        start_node = i;
                        set(nodes_child_data(i),'Color',MARKER_START_COLOR);
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

%% 4. select clusters
repeat = 1;
cluster_quantity = input('how many clusters (2er pairs): ');
while repeat == 1
    if cluster_quantity > nodes_quantity/2
        cluster_quantity = input('not possible, again!: ');
    else
        repeat = 0;
    end
end

disp('mark the clusters');
cluster_nodes = zeros(cluster_quantity,2);
cluster_child_data = zeros(cluster_quantity,2);
for j = 1:cluster_quantity
    %first node
    repeat = 1;
    while repeat == 1
        [tmp_x,tmp_y]=ginput(1);
        for i = 1:nodes_quantity
            if tmp_x < nodes_x_positions(i) + MARKER_SIZE/2
                if tmp_x > nodes_x_positions(i) - MARKER_SIZE/2
                    if tmp_y < nodes_y_positions(i) + MARKER_SIZE/2
                        if tmp_y > nodes_y_positions(i) - MARKER_SIZE/2
                            set(nodes_child_data(i),'Color',MARKER_CLUSTER_COLOR);
                            cluster_nodes(j,1) = i;
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
    %second node
    repeat = 1;
    while repeat == 1
        [tmp_x,tmp_y]=ginput(1);
        for i = 1:nodes_quantity
            if tmp_x < nodes_x_positions(i) + MARKER_SIZE/2
                if tmp_x > nodes_x_positions(i) - MARKER_SIZE/2
                    if tmp_y < nodes_y_positions(i) + MARKER_SIZE/2
                        if tmp_y > nodes_y_positions(i) - MARKER_SIZE/2
                            set(nodes_child_data(i),'Color',MARKER_CLUSTER_COLOR);
                            cluster_nodes(j,2) = i;
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
    
    cluster_colors = rand(1,3); %random color for cluster identification
    for i=1:2
        rectangle('Position', [nodes_x_positions(cluster_nodes(j,i))-MARKER_SIZE/2-5 ...
            nodes_y_positions(cluster_nodes(j,i))-MARKER_SIZE/2-5 ...
            MARKER_SIZE+10 MARKER_SIZE+10], ...
            'EdgeColor',cluster_colors(1,:), ...
            'LineWidth', MARKER_LINE_WIDHT);
        tmp_child_data = get(gca,'Children');
        cluster_child_data(j,i) = tmp_child_data(1);
        set(nodes_child_data(cluster_nodes(j,i)),'Color',MARKER_NORMAL_COLOR);
    end
end


%% 5. complete graph G = f(V,E); E=VxV
node_edge_to_node = zeros(nodes_quantity,nodes_quantity);
node_edge_weight = zeros(nodes_quantity,nodes_quantity);
for i = 1:nodes_quantity
    for j = 1:nodes_quantity
        dx = abs(nodes_x_positions(j)-nodes_x_positions(i));
        dy = abs(nodes_y_positions(j)-nodes_y_positions(i));
        
        if dx > 0 || dy > 0
            node_edge_to_node(i,j) = j;
            node_edge_weight(i,j) = sqrt(dx^2 + dy^2);
            plot([nodes_x_positions(i) nodes_x_positions(j)],...
                [nodes_y_positions(i) nodes_y_positions(j)]);
        end
    end
end

%% 6. Prim algortihm -> min. spanning tree (MST)
tree_node_connections = prim_alg(nodes_quantity, node_edge_weight, ...
     nodes_x_positions, nodes_y_positions, LINE_TREE_COLOR, LINE_LINE_WIDTH);




%% 7. Dijstra alogrithm
dijkstra_simple(node_edge_weight,1,12)
% => problem: destination must be *bekannt*

%% 8. TSP
n = 30;
%xy = 10*rand(n,2);
xy = [nodes_x_positions nodes_y_positions];
popSize = 60; 
numIter = 1e4;
showProg = 1;
showResult = 1;
a = meshgrid(1:n);
%dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),n,n); %Gewichte zwischen den Knoten
dmat = node_edge_weight;
[optRoute,minDist] = tspofs_ga(xy,dmat,popSize,numIter,showProg,showResult);

















