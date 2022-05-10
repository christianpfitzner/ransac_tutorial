clear all;
close all;

% Modellparameter (unbekannt -> zu suchen)
x0 = 3;
y0 = 4;
r = 2;

% Number of values
vals = 300;

% Generate Data with noise
% The generated data set contains a rough data for a line
% as well as the rough data for a circle
data=generate_data(x0, y0, r, vals);

% Plot the generated data 
figure(1);
plot(data(:,1),data(:,2), 'x');
axis equal;


% initialize the variables for the best solutions
best_match    = 0;
consensus_max = 0;
 

best_circle_estimation = [0, 0, 0]; 

% numbers of trials for ransac
nr_of_trials = 50;

for i=1:nr_of_trials
	n = 3;
	

    % get two random numbers
	idx1 = round(rand * (vals-1)+0.5);
	idx2 = round(rand * (vals-1)+0.5);
    idx3 = round(rand * (vals-1)+0.5); 
	
	% check that not two times the same value is taken
	if idx1 == idx2
		continue
	end
	
	% Sample set
	x = [data(idx1,1), data(idx2, 1), data(idx3, 1)];  % get all x values
	y = [data(idx1,2), data(idx2, 2), data(idx3, 2)];  % get all y values
	
  

	% calculate model parameters for the line
    m = (y(2) - y(1)) / (x(2) - x(1)); 
    t =  y(2) - (m*x(2));
    p = [m t];



    % calculate circle from two random points



    % calculate the model parameters for the circle
    a_1 = 2 * ( sum(x).^2 - n * sum(x.^2) );
    a_2 = 2 * ( sum(x)*sum(y) - n *sum(x.*y)); 
    b_1 = a_2; 
    b_2 = 2 * ( sum(y)^2 - n * sum(y.^2)); 
    c_1 = sum(x.^2) * sum(x) - n * sum(x.^3) + sum(x)*sum(y.^2) - n * sum(x.*y.^2); 
    c_2 = sum(x.^2) * sum(y) - n * sum(y.^3) + sum(y)*sum(y.^2) - n * sum(x.^2.*y); 


    center = inv([a_1 b_1; a_2 b_2]) * [c_1; c_2]
    x_0 = center(1); 
    y_0 = center(2); 

    radius = sqrt( 1/n * (sum(x.^2) - 2 * x_0 * sum(x) + n*x_0^2 + sum(y.^2) - 2*y_0*sum(y) + n*y_0^2 ));

	% find the consensus set and evaluate how many points belong here
    thresh = 10e-2;
    consensus = 0;
    for j=1:vals
        %epsilon =  (data(j,2) - (m*data(j,1)+t))^2;
        x_val = data(j,1); 
        y_val = data(j,2); 
        epsilon  = ((x_val - x_0)^2 + (y_val - y_0)^2 -r^2)^2;
        if epsilon < thresh
          consensus = consensus + 1; 
        end
    end


    % save the best consensus set
    if consensus > consensus_max
        consensus_max = consensus;
        best_match = i;
        p_best = p;
        best_circle_estimation = [x_0, y_0, radius]
    end
end


% Beste Übereinstimmung ausgeben
best_match
p_best

best_circle_estimation
% Plotte Messwerte
clf;
plot(data(:,1),data(:,2), 'x');
x1 = x0-r
y1 = p_best(1)*x1 + p_best(2)
x2 = x0+r
y2 = p_best(1)*x2 + p_best(2)
hold on;
plot([x1,x2], [y1, y2], 'r');
% hold off;

t = linspace(0,2*pi,100)'; 
circsx = best_circle_estimation(3).*cos(t) + best_circle_estimation(1); 
circsy = best_circle_estimation(3).*sin(t) + best_circle_estimation(2); 
plot(circsx,circsy, 'r');

