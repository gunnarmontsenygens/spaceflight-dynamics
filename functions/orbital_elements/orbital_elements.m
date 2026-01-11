function [a,e,i,w,Omega,tp] = orbital_elements(r0_vec,v0_vec,t0,mu)
%==========================================================================
%
% Calculates orbital elements. 
% Equatorial and circular orbits might need extra considerations.
%
% Author: G. Montseny
% Date: October 4, 2025
%
%
% INPUT:               Description                                   Units
%
%  r0_vec  -    [x,y,z] position vector at time t = t0                km 
%  v0_vec   -    [v0_x,v0_y,v0_z] velocity vector at time t = t0     km/s
%  t0   -     initial time                                             s
%  mu   -     mass parameter                                        km^3/s^2
%
% OUTPUT:       
%    
%  a    -           semi-major axis                                    km
%  e    -           eccentricity                                        -
%  i    -           inclination                                        deg
%  w    -           argument of periapsis                              deg
%  Omega -          longitude of the ascending node                    deg
%  tp    -          time of periapsis passage                           s
%==========================================================================

% Calculate the position unit vector
r0_hat = r0_vec/norm(r0_vec);

% Compute the the angular momentum and the eccentricity vector
h_vec = cross(r0_vec,v0_vec);
e_vec = cross(v0_vec,h_vec)/mu-r0_hat;
e_hat = e_vec./norm(e_vec);

% Calculate the orbit parameter and eccentricity
p = norm(h_vec)^2/mu;
e = norm(e_vec);

% Define new unit vectors under some conditions
if norm(h_vec) ~= 0
    h_hat = h_vec/norm(h_vec);
end

if e ~= 0
    e_hat = e_vec/e;
else
    e_hat = [0,0,0];
end

% Compute semi-major axis
a = p/(1-e^2);

% Compute the inclination
z_hat = [0,0,1];
i = acosd(dot(h_hat,z_hat));

% Define the node vector
n_Omega = cross(z_hat,h_hat);
n_mag = norm(n_Omega);
if n_mag > 1e-10
    n_Omega_hat = n_Omega/n_mag;
else
    n_Omega_hat = [1,0,0];
end

% Compute the longitude of the ascending node
x_hat = [1,0,0];
y_hat = [0,1,0];
Omega = atan2d(dot(y_hat,n_Omega_hat),dot(x_hat,n_Omega_hat));

% Define the perpendicular vector to n_Omega_hat in the plane
n_Omega_hat_perp = cross(h_hat,n_Omega_hat);

% The argument of periapsis can be computed as
w = atan2d(dot(n_Omega_hat_perp,e_vec),dot(n_Omega_hat,e_vec));

% Compute the normal to the eccentricity vector
e_hat_perp = cross(h_hat,e_hat);

% Compute the true anomaly at t0
f0 = atan2(dot(r0_vec,e_hat_perp),dot(r0_vec,e_hat));

% Compute the eccentric or hyperbolic anomaly:
if e < 1 

    E = 2*atan2(tan(f0/2)*sqrt((1-e)),sqrt((1+e)));

    % Compute time of periapsis passage for an ellipse
    tp = t0 - (E-e*sin(E))*sqrt(a^3/mu);

elseif e > 1 
    F = 2*atanh(tan(f0/2)*sqrt((e-1)/(1+e)));
    
    % Compute the time of periapsis passage for a hyperbola
    tp = t0 + (F-e*sinh(F))*sqrt(abs(a)^3/mu);
elseif e == 1

    % Compute the time of periapsis passage for a parabola
    tp = t0 - 0.5*sqrt(p^3/mu)*tan(f0/2)*(1+(tan(f0/2)^2)/3);
end

% Make Omega be between 0 and 360 degrees
Omega = mod(Omega,360);


end
