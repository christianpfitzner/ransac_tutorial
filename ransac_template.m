

% helpfull links
% generate the sum of a vector
%       https://de.mathworks.com/help/matlab/ref/sum.html
% element wise multiplication
%       https://de.mathworks.com/help/matlab/ref/times.html
% common plot commands for line circle and data
%       https://de.mathworks.com/help/matlab/ref/plot.html


clear all;
close all;

% model parameters to calculate the random data points
x0 = 3;    % x coordinate of the center of the line and circle
y0 = 4;    % y coordinate of the center of the line and circle
r  = 2;    % radius of the circle

% number of values in the dataset
vals = 300;

% Generate Data with noise
% The generated data set contains a rough data for a line
% as well as the rough data for a circle
data = generate_data(x0, y0, r, vals);

% plot the generated data 
figure(1);
plot(data(:,1),data(:,2), 'x');
axis equal;


% initialize the variables for the best solutions
best_match    = 0;
consensus_max = 0;
 

% numbers of trials for ransac
nr_of_trials = 50;

for i=1:nr_of_trials
	% number of points necessary for the model
    n = 2;
	
    % get two random numbers
	idx1 = round(rand * (vals-1)+0.5);
	idx2 = round(rand * (vals-1)+0.5);
	
	% check that not two times the same value is taken
	if idx1 == idx2
		continue
	end
	
	% Sample set
	x = [data(idx1,1), data(idx2, 1)];  % get all x values of the random points
	y = [data(idx1,2), data(idx2, 2)];  % get all y values of the ransom points
	
  

	% calculate model parameters for the line based on the two randomly 
    % selected points
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        ADD YOUR CODE HERE          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





	% find the consensus set and evaluate how many points belong here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        ADD YOUR CODE HERE          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






    % save the best consensus set
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        ADD YOUR CODE HERE          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end

% output of the final found model 





% plot the values and include the visualization of the found 
figure(2); 
plot(data(:,1),data(:,2), 'x');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        ADD YOUR CODE HERE          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


