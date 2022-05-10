clear all;
close all;

% Modellparameter (unbekannt -> zu suchen)
x0 = 3;
y0 = 4;
r = 2;

% Anzahl Messwerte
vals = 100;

% Generiere Messwerte
data=generate_data(x0, y0, r, vals);

best_match = 0;
consensus_max = 0;

% Anzahl an Stichprobenüberprüfungen
trials = 20;

for i=1:trials
	n = 3;
	% 3 Zufallszahlen im gültigen Wertebereich suchen
	idx1 = round(rand * (vals-1)+0.5);
	idx2 = round(rand * (vals-1)+0.5);
	idx3 = round(rand * (vals-1)+0.5);
	
	% Sicherstellen, dass nicht gleiche Indizes gewählt wurden
	if idx1 == idx2 ||  idx2 == idx3 || idx1 == idx3
		continue
	end
	
	% Sample set
	x = [data(idx1,1), data(idx2, 1), data(idx3, 1)];
	y = [data(idx1,2), data(idx2, 2), data(idx3, 2)];	
	
	% Modellparameter bestimmen
	a1 =2* (sum(x)^2 - n * sum(x.^2));
  a2 = 2* (sum(x)*sum(y) - n * sum(x.*y));
	b1 = a2;
	b2 = 2*(sum(y)^2- n * sum(y.^2));
	c1 = sum(x.^2)*sum(x) - n* sum(x.^3) + sum(x)*sum(y.^2) - n * sum(x.*y.^2);
	c2 = sum(x.^2)*sum(y) - n* sum(y.^3) + sum(y)*sum(y.^2) - n * sum(x.^2.*y);
	
	p =inv([a1 b1; a2 b2]) * [c1; c2];
	p(3) = sqrt(1/n * (sum(x.^2) - 2*p(1)*sum(x) + n*p(1)^2 + sum(y.^2) - 2 * p(2) * sum(y) + n * p(2)^2));
	
	% Consensus set finden und bewerten
	consensus = 0;
	thresh = 10e-2;
	for j=1:vals
		epsilon = ((data(j,1) - p(1))^2 + (data(j,2) - p(2))^2 - p(3)^2)^2;
		if epsilon < thresh
			consensus = consensus +1; 	
        end
    end
	
	% Beste Übereinstimmung merken
	if consensus > consensus_max
		consensus_max = consensus;
		best_match = i;
		p_best = p;
	end
end

% Beste Übereinstimmung ausgeben
best_match
p_best

% Plotte Messwerte
clf;
hold on;	
plot(data(:,1),data(:,2), 'x');
t = linspace(0,2*pi,100)'; 
circsx = p_best(3).*cos(t) + p_best(1); 
circsy = p_best(3).*sin(t) + p_best(2); 
plot(circsx,circsy, 'r');

