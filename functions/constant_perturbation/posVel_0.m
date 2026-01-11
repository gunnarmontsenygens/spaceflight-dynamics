function [r0_vec,v0_vec] = posVel_0(t_0,a,e,i,w,Omega,tp,mu,tol)
%==========================================================================
%
% Calculates initial position and velocity at time t0 given orbital
% elements.
%
% Author: G. Montseny
% Date: October 15, 2025
%
%
% INPUT:               Description                                   Units
%
%  t_0   -          input time  array                                   s
%  a  -             semi-major axis                                    km 
%  i -              inclination                                        deg
%  e  -             eccentricity                                        -
%  w -              argument of periapsis                              deg
%  Omega -          longitude of the ascending node                    deg 
%  tp   -           time of periapsis                                   s
%  mu   -           mass parameter                                 km^3/s^2
%  tol  -           numerical tolerance for solving Kepler's equation
%
% OUTPUT:       
%    
%  r0_vec    -           initial position [x,y,z]                       km
%  v0_vec    -           initial velocity [vx,vy,vz]                    km
%==========================================================================
%--------------------------------------------------------------
% Calculate true anomaly f at time t_0
%--------------------------------------------------------------

% Calculate the mean anomaly
n = sqrt(mu / a^3); % Mean motion
M = n .* (t_0 - tp);   % Mean anomaly

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
f = mod(f,2*pi);

%--------------------------------------------------------------
% Calculate e_hat and e_hat_perp
%--------------------------------------------------------------
% Calculate direction
e_hat = e_vec_hat(i,w,Omega);
e_hat_perp = e_vec_hat_perp(i,w,Omega);

%--------------------------------------------------------------
% r0_vec
%--------------------------------------------------------------

% Calculate magnitude
r = a.*(1-e.^2)./(1+e.*cos(f));

% Output
r0_vec = r.*(e_hat.*cos(f)+e_hat_perp.*sin(f));
r0_vec = r0_vec';

%--------------------------------------------------------------
% v0_vec
%--------------------------------------------------------------

% Calculate multuplying constant
v = sqrt(mu./(a.*(1-e.^2)));

% Output
v0_vec = v.*(-e_hat.*sin(f)+e_hat_perp.*(cos(f)+e));
v0_vec = v0_vec';

end