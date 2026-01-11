function f = true_anomaly(t,r0_vec,v0_vec,t0,mu,tol)
%==========================================================================
%
% Calculates true anomaly f(t). 
% Only works for elliptic orbits(e<1)
%
% Author: G. Montseny
% Date: October 4, 2025
%
%
% INPUT:               Description                                   Units
%
%  t   -            input time                                         s
%  r0_vec  -        [x,y,z] position vector at time t = t0             km 
%  v0_vec   -       [v0_x,v0_y,v0_z] velocity vector at time t = t0   km/s
%  t0   -           initial time                                       s
%  mu   -           mass parameter                                 km^3/s^2
%  tol  -           numerical tolerance for solving Kepler's equation
%
% OUTPUT:       
%    
%  f    -           true anomaly                                        deg
%==========================================================================

% Extract all the orbit elements
[a,e,~,~,~,tp] = orbital_elements(r0_vec,v0_vec,t0,mu);

% Calculate the mean anomaly
n = sqrt(mu / a^3); % Mean motion
M = n .* (t - tp);   % Mean anomaly

% Solve Kepler's equation to find the eccentric anomaly E
E0 = M; % initial guess
DeltaE = -(M-E0+e.*sin(E0))./(-1+e.*cos(E0));

E_list = [E0, E0+DeltaE]; % list of E as they approach the true answer
res_list = [M-E_list(2)+e.*sin(E_list(2))]; % M-E+esinE as they approach the true answer

if abs(res_list(1)) < tol
    E = E_list(2);
else

    res = res_list(1);

    while abs(res) > tol
        E_i = E_list(end);
        DeltaE = -(M-E_i+e.*sin(E_i))./(-1+e.*cos(E_i));

        E_list(end+1) = E_i + DeltaE;
        res_list(end+1) = M-E_list(end)+e.*sin(E_list(end));
        res = res_list(end);
    end

    E = E_list(end);
end

% Compute the true anomaly f for the computed E
f = 2*atan2(sqrt(1+e).*tan(E./2),sqrt(1-e));
f = mod(rad2deg(f),360);


end