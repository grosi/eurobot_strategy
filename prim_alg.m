function [ tree_node_connections ] = prim_alg(nodes_quantity, node_edge_weight, ...
    nodes_x_positions, nodes_y_positions, LINE_TREE_COLOR, LINE_LINE_WIDTH)
%prim_alg Prims Algorithm for a min. spanning tree
%   todo: implement a priority-queue
%
%   by Vikramaditya Kundur
%   27 Sep 2005 (Updated 30 Sep 2005) 
%   http://www.mathworks.com/matlabcentral/fileexchange/8569-prims-algorithm/content/prim.m

l = nodes_quantity; % Input matrix size from line 1
a = node_edge_weight; % Input the matrix

k = 1:l;
listV(k) = 0;
listV(1) = 1;
e=1;
distance = zeros(1,l-1);
source = zeros(1,l-1);
destination = zeros(1,l-1);
tree_node_connections = zeros(nodes_quantity,nodes_quantity);
while (e<l)
    min=inf;
     for i=1:l
        if listV(i)==1
            for j=1:l
                if listV(j)==0
                   if min>a(i,j)
                        min=a(i,j);
                        b=a(i,j);
                        s=i;
                        d=j;
                    end
                end
            end
        end
    end
    listV(d)=1;
    distance(e)=b;
    source(e)=s;
    destination(e)=d;
    
    plot([nodes_x_positions(source(e)) nodes_x_positions(destination(e))],...
                 [nodes_y_positions(source(e)) nodes_y_positions(destination(e))],LINE_TREE_COLOR,'LineWidth',LINE_LINE_WIDTH);
    
    tree_node_connections(source(e),destination(e)) = node_edge_weight(source(e),destination(e));
    tree_node_connections(destination(e),source(e)) = node_edge_weight(source(e),destination(e));
    e=e+1;
end
end
% T_nodes = zeros(nodes_quantity,1);
% T_nodes(1) = start_node;
% node_in_T = 1;
% tmp_node_edge_weight = node_edge_weight;
% tmp_node_edge_weight(:,start_node) = 0; % start node is still connected to tree
% tree_node_connections = zeros(nodes_quantity,nodes_quantity);
% 
% %find minimum spanning tree
% while node_in_T < nodes_quantity
%     %loop througt the T-nodes (nodes in tree)
%     tmp_edge_weight = 1000000;
%     for i= 1:node_in_T
% 
%         
%         for j= 1:nodes_quantity
%             if T_nodes(i) ~= j && 0 < tmp_node_edge_weight(T_nodes(i),j)
%             %if 0 < tmp_node_edge_weight(T_nodes(i),j)
%                 if tmp_edge_weight > tmp_node_edge_weight(T_nodes(i),j)
%                     
%                     if max(tree_node_connections(:,j)) == 0
%                         % way is done -> delete
%                         tmp_edge_weight = tmp_node_edge_weight(T_nodes(i),j);
% 
%                         % save the two nodes with smallest edge-weight (temporary)
%                         T_node = T_nodes(i);
%                         T_nodes(node_in_T+1) = j;
%                     end
%                 end
%             end
%         end   
%     end
%     
%     %one node added to tree
%     node_in_T = node_in_T + 1;
%     
%     %history about the tree connections
%     tmp_node_edge_weight(T_node,T_nodes(node_in_T)) = 0;
%     tmp_node_edge_weight(T_nodes(node_in_T),T_node) = 0;
%     tree_node_connections(T_node,T_nodes(node_in_T)) = node_edge_weight(T_node,T_nodes(node_in_T));
%     tree_node_connections(T_nodes(node_in_T),T_node) = node_edge_weight(T_node,T_nodes(node_in_T));
%     
%     plot([nodes_x_positions(T_node) nodes_x_positions(T_nodes(node_in_T))],...
%                 [nodes_y_positions(T_node) nodes_y_positions(T_nodes(node_in_T))],LINE_TREE_COLOR,'LineWidth',LINE_LINE_WIDTH);
% end




