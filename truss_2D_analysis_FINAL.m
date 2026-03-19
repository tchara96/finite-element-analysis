% 2D TRUSS ANALYSIS
% STATICS

%% THANASIS CHARALAMBOUS
% Mechanical Engineer
% 2025/01

%% CODE
clear
clc

%% INSTRUCTIONS
% SET the values of PART 1 & PART 2, PART 3A accordingly to your problem
% No need to change anything beyond PART 3A
% The supports should be at x=0 to make the code works

%% PART 1: GEOMETRY OF TRUSS

% SET the geometry of Truss
% Nodes of Coordinates (x,y)
% They can as many nodes as it needed
nodes = [
    0 0;    % Node 1 coordinates (x, y)
    2 0;    % Node 2 coordinates
    4 0;   % Node 3 coordinates
    6 0;   % Node 4 coordinates
    0 -2.5;   % Node 5 coordinates
    2 -5/3;   % Node 6 coordinates
    4 -5/6;
    ];
num_nodes = size(nodes, 1); % Number of nodes

% SET Members of the truss
% Which nodes are connect between them by the members 
members = [
    1 2; % Member 1 connects nodes 1 and 2 
    1 5; % Member 2 
    2 3; % Member 3 
    2 5; % Member 4 
    2 6; % Member 5 
    3 4; % Member 6 connects nodes 2 and 6 
    3 6; % Member 8 
    3 7; % Member 9 
    4 7;
    5 6;
    6 7;
    ];
num_members = size(members,1); % Number of members

%% PART 2: EXTERNAL FORCES & MOMENTS
% SET External loads & moments [Rx, Ry, M] = [Horizontal force, vertical, Moment]
% If there is load with angle, set it with its x,y components

loads = [
    0 -12.5 0 ;  % Node 1: No horizontal (0),vertical -300 units load, no moment
    0 -12.5 0 ;     % Node 2: No loads, no moment
    0 -12.5 0 ;     % Node 3: No loads, no moment
    0 -12.5 0 ;     % Node 4: No loads, no moment
    0 0 0 ;  % Node 5: No horizontal (0), vertical -300 units load, no moment
    0 0 0 ; 
    0 0 0 ;
    ];  % Node 6: No Horizontal load, vertical load -600, no moment

%% PART 3: SUPPORTS or CONNECTIONS (Applying Boundary Conditions)
% Define support conditions
% What movements each type of support restricts.

% Define support types at each node
% 0: No support 
% 1: Roller, Rocker, Frictionless surface ON GROUND
% 2: Roller, Rocker, Frictionless surface ON WALL
% 3: Short Cable, Short Link
% 4: Collar on frictionless rod, Frictionless pin in slot
% 5: Hinge or frictionless pin or rough surface
% 6: Fixed support

% PART 3A
% SET support types for each node 
% 0, 1, 2, 3, 4, 5, 6
support_node = [
    5; % Hinge at node 1 
    0; % No support at node 2
    0; % No support at node 3
    0; % No support at node 4
    2; % Roller at node 5 ON WALL
    0; % No support at node 6
    0; % 
    ]; %

% PART 3B
% !!! DO NOT CHANGE THESE !!!
% Change for x,y reactions depending on support reactions
% Support Types, Reactions types : [Rx, Ry, M]
support_types = [
    0 1 0 ;  % Support Type 1: Roller, Rocker, Frictionless Surface (only vertical reaction) ON GROUND
    1 0 0 ;  % Support Type 2: Roller, Rocker, Frictionless Surface (only vertical reaction) ON GROUND
    0 0 0 ;  % Support Type 3: Short Cable, Short Link (no reactions defined yet)
    0 0 0 ;  % Support Type 4: Collar on Frictionless Rod, Frictionless Pin in Slot (needs further calculation for reactions)
    1 1 0 ;  % Support Type 5: Hinge, Frictionless Pin, Rough Surface (horizontal & vertical reactions, no moments)
    1 1 1 ;  % Support Type 6: Fixed Support (horizontal & vertical reactions, moments)
];


%% PART 4: Plotting the Geometry of Truss
% Figure 1
figure(1)
hold on;
axis equal;
grid on;
xlabel('x coordinates (m)');
ylabel('y coordinates (m)');
title('Truss Network, Nodes & Members numbering ');

% Plot Nodes
for i = 1:length(nodes) % or i = 1:size(nodes,1);
    plot(nodes(i,1) , nodes(i,2), 'ko', 'MarkerFaceColor','k', 'LineWidth', 1.5); %% Plot node as a black circle 
    text(nodes(i,1) + 0.1, nodes(i,2) - 0.1, ['N' num2str(i)], 'Fontsize', 12, 'Color', 'k'); % Label the node(N1-N..)
end

% Plot Members
for i = 1:length(members) % or i = 1:size(members,1);
    node1 = members(i,1); % 1st node of the member
    node2 = members(i,2); % 2nd node of the member
    % Plot Members, line from 1 node to other node
    plot( [nodes(node1,1), nodes(node2,1)], [ nodes(node1,2), nodes(node2,2) ], 'b-', 'LineWidth', 2);
    % Label members
    midpoint = [(nodes(node1,1) + nodes(node2,1))/2, (nodes(node1,2) + nodes(node2,2))/ 2 ];
    text(midpoint(1)  , midpoint(2), ['M' num2str(i)], 'FontSize', 12 , 'Color', 'b') % Label the members(M1-M..)
end
hold off;

%% PART 5: Joint connectivity (members that are connected to each node)
joint_connectivity = cell(num_nodes,1); % Create an empty cell array to hold the joint connectivity
    % Loop through each member to check which nodes are connected between which members
    for i = 1:num_members 
        node1 = members(i, 1); % 1st node of the member
        node2 = members(i, 2); % 2nd node of the member
        % Add the member index to connectivity list for both nodes
        joint_connectivity{node1} = unique([joint_connectivity{node1},i]); % unique ensure that the member index is not shown multiple times for each node
        joint_connectivity{node2} = unique([joint_connectivity{node2},i]); 
    end

%% PART 6: Nodes' Support Reactions
% Assign the Nodes' support reactions

% Initialize an empty vector to store reaction forces & moments
reaction_forces_moments = zeros(length(nodes),3);
     % Loop through each node and assign its support reaction
     for i = 1:length(nodes)
         support_type = support_node(i); % Get the support type for node i
        if support_type == 1
           reaction_forces_moments(i,:) = support_types(1,:);
        elseif support_type == 2
           reaction_forces_moments(i,:) = support_types(2,:);
        elseif support_type == 3
           reaction_forces_moments(i,:) = support_types(3,:);
        elseif support_type == 4
           reaction_forces_moments(i,:) = support_types(4,:);
        elseif support_type == 5
           reaction_forces_moments(i,:) = support_types(5,:);
        else
           reaction_forces_moments(i, :) = [0 0 0]; % No support at this node (free)
        end
     end

%% PART 7: Plot External Loads 

figure(2);
hold on;
axis equal;
grid on;
xlabel('x coordinates (m)');
ylabel('y coordinates (m)');
title('External Loads on Truss');

% Plot Nodes
for i = 1:length(nodes) % or i = 1:size(nodes,1);
    plot(nodes(i,1) , nodes(i,2), 'o','LineWidth', 1.5); %% Plot node as a black circle 
end

% Plot Members
for i = 1:length(members) % or i = 1:size(members,1);
    node1 = members(i,1); % 1st node of the member
    node2 = members(i,2); % 2nd node of the member
    % Plot Members, line from 1 node to other node
    plot( [nodes(node1,1), nodes(node2,1)], [ nodes(node1,2), nodes(node2,2) ], 'LineWidth', 3, 'Color','k');
end

% Plot External Loads (Forces)
for i = 1:length(loads)
    Fx = loads(i,1) / abs(min(min(loads)) ); % Horizontal load at node i 
    Fy = loads(i,2) / abs(min(min(loads)) ); % Vertical load at node i 
    % Only plot non-zero forces
    if Fx ~= 0
       quiver(nodes(i,1), nodes(i,2), Fx, 0, 'r', 'LineWidth', 2,'MaxHeadSize', 3.0);
       text(nodes(i,1) + Fx/2, nodes(i,2) + Fx/20, sprintf('%.1f N', loads(i,1)), 'Color', 'r', 'FontSize', 10);
    end
    if Fy ~= 0
       quiver(nodes(i, 1), nodes(i, 2), 0, Fy, 'r', 'LineWidth', 2, 'MaxHeadSize', 3.0); % + abs(min(min(loads(i,2)))/60) That is adjustment of Force arrows position
       text(nodes(i,1) + Fx/20   , nodes(i,2) + Fy/2  , sprintf('%.1f N', loads(i,2)), 'Color', 'r', 'FontSize', 10);
    end
end
hold off;

%% PART 8: ANALYSIS
disp('====================================')
disp('RESULTS')
disp('====================================')

% Network Equilibrium
% Sum of Forces (SFx=0, SFy=0)
% Creation of Reactions symbolic matrix (sym_reactions)
[rows, cols] = size(reaction_forces_moments);
reactions = strings(rows,cols); % Create reactions string array
base_names = ["Rx", "Ry", "M"]; % Names corresponding to columns
% Naming Supports Reactions
for i = 1:rows
    for j = 1:cols
        if reaction_forces_moments (i,j) == 1
           reactions(i,j) = base_names(j) + num2str(i); % Assign symbolic variable
        else
           reactions(i,j) = 0 ;
        end
    end
end
% Initialize a cell array
sym_reactions = cell(size(reactions));
% Create Sym Reactions
for i = 1:numel(reactions) % numel, total number of arrays
    if ~strcmp(reactions{i}, "0") % if reactions{i} == 0
        sym_reactions{i} = sym(reactions{i}); % Replace with symbolic variable
    else
        sym_reactions{i} = 0; % Assign numeric zero for known values
    end
end
% Convert to symbolic matrix
sym_reactions = cell2sym(sym_reactions);

% Define External Loads
external_loads = loads;
node_distances_x = nodes(:, 1); % Horizontal positions of nodes (x-coordinates)
node_distances_y = nodes(:, 2); % Vertical positions of nodes (y-coordinates)

% Initialize equilibrium equations
eq_SFx = 0; % Sum of forces in X
eq_SFy = 0; % Sum of forces in Y
eq_SM = 0;  % Sum of moments 

% Loop through each node to calculate contributions to equilibrium
for  i = 1: rows
     % Add contributions to SFx and SFy
     eq_SFx = eq_SFx + sym_reactions(i,1) + external_loads(i,1);
     eq_SFy = eq_SFy + sym_reactions(i,2) + external_loads(i,2);
    
     % Add contributions to SM     
     eq_SM = sum((sym_reactions(:,2) + external_loads(:,2)) .* node_distances_x - (sym_reactions(:,1) + external_loads(:,1)) .* node_distances_y);
end

% Solve the equilibrium equations for the unknown reactions
unknowns = symvar(sym_reactions); % Extract all symbolic variables (unknowns), symvar finds the unknowns variables
solutions = solve([eq_SFx == 0, eq_SFy == 0, eq_SM == 0], unknowns); % Solve equations to find unknowns

% Display the solutions for the reactions
disp('Supports Reaction Forces and Moments');
disp(solutions);

% Get all field names from the struct
fields = fieldnames(solutions); % Return the field names in a cell array using the fieldnames
% Loop through each field and update the matrix
for i = 1:numel(fields)
    field = fields{i};  % Get the current field name (e.g., 'Rx5')
    value = solutions.(field);% Get the corresponding value
    % Extract the row number from the field name
    var_type = field(2); % 'x' or 'y' or another variable
    row_num = str2double(field(3:end)); % Convert strings to double precision values (numbers of the field(3rd and after))

% Determine the column index based on the type (customizable)
    switch var_type
        case 'x'
            col_num = 1;  % X forces/moments go to column 1
        case 'y'
            col_num = 2;  % Y forces/moments go to column 2
        otherwise
            error('Unknown reaction force/moment type: %s', var_type);
    end
% Update the matrix
reaction_forces_moments(row_num, col_num) = value;
end
% Display the updated matrix
disp('Reaction Forces and Moments at Each Node (Rx, Ry, M):');
disp(reaction_forces_moments);
disp('====================================')
%% PART 10: Method of Nodes
% Solve for Member Forces with Known Support Reactions

% Initialize symbolic forces in members
member_forces = sym('F', [num_members,1]); % creates an array(num_member*1)
reaction_forces_x = sym('Rx',[num_members,1]);
reaction_forces_y = sym('Ry',[num_members,1]);

% Get Reaction forces
known_reactions = []; % array creation
known_values = [];
for i = 1:num_nodes
    for j =1:2 % Check Rx (column 1) and Ry (column 2)
        reaction_value = reaction_forces_moments(i,j); % Get from input matrix
        if reaction_value ~= 0
            if j == 1 % Rx direction
                known_reactions = [known_reactions; reaction_forces_x(i)]; % Store reaction force
            else % Ry direction
                known_reactions = [known_reactions; reaction_forces_y(i)]; % Store reaction force
            end
             known_values = [known_values; reaction_value]; % Store reaction values
        end
    end
end

% Initialize Equilibrium equations
eqs = [];
for i = 1:num_nodes
    % Initialize sum of forces in x and y directions
    Fx_eq = sym(0);
    Fy_eq = sym(0);
    % External forces at the node
    Fx_ext = external_loads(i,1);
    Fy_ext = external_loads(i,2);
    % Reaction forces at the node (if unknown, they will remain symbolic)
    Rx = reaction_forces_x(i);  % Rx for the node i
    Ry = reaction_forces_y(i);  % Ry for the node i
    % Add reaction forces to equilibrium
    Fx_eq = Fx_eq + Rx;
    Fy_eq = Fy_eq + Ry;

    % Members connected to the current node
    connected_members = joint_connectivity{i};
    for j = 1:length(connected_members)
        member_index = connected_members(j);
        member_nodes = members(member_index, :); % Nodes connected by this member
        other_node = setdiff(member_nodes, i);  % Find the node that's not i
        
        % Compute directional cosines (unit vector components)
        dx = nodes(other_node,1) -  nodes(i, 1); % x distance between the 2 nodes
        dy = nodes(other_node,2) -  nodes(i, 2); % y distance between the 2 nodes
        L = sqrt(dx.^2 + dy.^2);  % Length of the member

        % Ensure no zero-length members are present
        if L == 0
            error('Error: Zero-length member detected!');
        end

        % Unit vector components
        cos_theta = dx / L;
        sin_theta = dy / L;

        % Add contributions to equilibrium equations from member forces
        Fx_eq = Fx_eq + member_forces(member_index) * cos_theta;
        Fy_eq = Fy_eq + member_forces(member_index) * sin_theta;
    end

    % Add external forces at the node
    Fx_eq = Fx_eq + Fx_ext;
    Fy_eq = Fy_eq + Fy_ext;

% Store the equilibrium equations
    eqs = [eqs; Fx_eq == 0; Fy_eq == 0];

end

% Print Equilibrium Equations Before Solving
disp('Equilibrium Equations:');
disp('------------------------------------')
for i = 1:length(eqs)
    fprintf('Equation %d: %s\n',i,char(eqs(i)));
end

% Substitute known Support Reactions
if ~isempty(known_reactions)
     eqs = subs(eqs, known_reactions, known_values);
end
 
% Solve system of equations for member forces
unknown_forces = [member_forces; reaction_forces_x(:); reaction_forces_y(:)];
solution = solve(eqs, unknown_forces);
% Check if the solution is empty or invalid
if isempty(solution)
    error('Error: The system of equations has no solution.');
end

% Extract numeric values from solution structure
member_forces_values = zeros(num_members, 1);  % Initialize storage
reaction_forces_values = zeros(num_nodes, 2);  % Store solved reaction forces

disp('=========================================================')
% Extract solved member forces
for i = 1:num_members
    force_var = ['F', num2str(i)];
    if isfield(solution, force_var) && ~isempty(solution.(force_var))
        member_forces_values(i) = double(solution.(force_var));
    else
        member_forces_values(i) = NaN; % Indicate unsolved force
        fprintf('Warning: Member %d force could not be determined.\n', i);
    end
end

% Print the results for member forces
disp('Solved Member Forces:');
disp('---------------------------------------------------------')

disp('* Positive(+): Tensile Force');
disp('** Negative(-): Compressive Force');
for i = 1:num_members
    member_nodes = members(i,:);  % Get the nodes for this member
    node_pair_str = sprintf('F%d%d', member_nodes(1), member_nodes(2)); % Create F_ij string

    fprintf('F%d = %s = %.2f\n', i,node_pair_str, member_forces_values(i));
end

% Extract solved reaction forces
for i = 1:num_nodes
    % Rx for node i
    if isfield(solution, ['Rx', num2str(i)]) && ~isempty(solution.(['Rx', num2str(i)]))
        reaction_forces_values(i, 1) = double(solution.(['Rx', num2str(i)]));
    else
        reaction_forces_values(i, 1) = 0; % Default to zero if not solved
    end
    
    % Ry for node i
    if isfield(solution, ['Ry', num2str(i)]) && ~isempty(solution.(['Ry', num2str(i)]))
        reaction_forces_values(i, 2) = double(solution.(['Ry', num2str(i)]));
    else
        reaction_forces_values(i, 2) = 0; % Default to zero if not solved
    end
end