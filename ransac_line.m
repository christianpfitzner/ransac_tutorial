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
	n = 2;
	% 2 Zufallszahlen im gültigen Wertebereich suchen
	idx1 = round(rand * (vals-1)+0.5);
	idx2 = round(rand * (vals-1)+0.5);
	
	% Sicherstellen, dass nicht gleiche Indizes gewählt wurden
	if idx1 == idx2
		continue
	end
	
	% Sample set
	x = [data(idx1,1), data(idx2, 1)];
	y = [data(idx1,2), data(idx2, 2)]	;
	
	% Modellparameter bestimmen
  % m = (y2 - y1) / (x2 - x1)
  
  m = (y(2) - y(1)) / (x(2) - x(1)); 
  
  t =  y(2) - (m*x(2));

	p = [m t];
	
	% Consensus set finden und bewerten
	consensus = 0;
	thresh = 10e-2; %0.3
  %thresh = 0.3;
	for j=1:vals
		epsilon = (data(j,2) - (m*data(j,1)+t))^2;   %Quadratische Gewichtung -> höhere dis höherer fehler^2
		if epsilon < thresh
			consensus++;
		end
	end;
	
	% Beste Übereinstimmung merken
	if consensus > consensus_max
		consensus_max = consensus;
		best_match = i;
		p_best = p;
	end
end;

% Beste Übereinstimmung ausgeben
best_match
p_best

% Plotte Messwerte
clf;	
plot(data(:,1),data(:,2), 'x');

% Plotte geschätzes Modell
x1 = x0-r
y1 = p_best(1)*x1 + p_best(2)
x2 = x0+r
y2 = p_best(1)*x2 + p_best(2)
hold on;
plot([x1,x2], [y1, y2], 'r'); 
hold off;
