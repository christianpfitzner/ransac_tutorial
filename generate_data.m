% Funktion zur Erzeugung pseudozufälliger Daten auf einer Kreisbahn/Geraden
%
% Parameter:
% x0: x-Koordinate des Datenmittelpunkts
% y0: y-Koordinate des Datenmittelpunkts
% vals: Anzahl an Messwerten
% r: Kreisradius
% data: nx2-Matrix mit Kreisbahn-/Geradenkoordinaten
%
% Autor: Stefan May
% Datum: 02.05.2013

function data=generate_data(x0, y0, r, vals)
	s = 1;

    % allocate the data vector with memory
    data = ones(vals, 2); 

    % generate the data for the circle
    for i=1:vals/3
		rnd = (rand - 0.5)*2;
		s = -s;
		x =  rnd*r + x0;
		y = s*sqrt(r^2 - (x - x0)^2) + y0;
		data(i,1) = x + (rand - 0.5) * 0.2;
		data(i,2) = y + (rand - 0.5) * 0.2;
    end
	
    % generate the data for the line
    for i=1:vals/3 
		rnd = (rand - 0.5)*2;
		x =  rnd*r + x0;
		y = x + y0 - x0;
		data(vals/3+i,1) = x + (rand - 0.5) * 0.2;
		data(vals/3+i,2) = y + (rand - 0.5) * 0.2;
    end

    % generate additional random data
    for i=1:vals/3 
		data(vals/3*2+i,1) = x0 + (rand - 0.5) * 5;
		data(vals/3*2+i,2) = y0 + (rand - 0.5) * 5;
    end
	
end
