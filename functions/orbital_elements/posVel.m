function [r_vec,v_vec] = posVel(t,r0_vec,v0_vec,t0,mu,tol)
%==========================================================================
%
% Calculates position vector and velocity vector at time t.
% Only works for elliptic orbits (e<1)
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
%  r_vec    -       [x,y,z] position vector at time t                  km
%  v_vec    -       [vx,vy,vz] velocity vector at time t              km/s
%==========================================================================

% Extract all the orbit elements
[a,e,i,w,Omega,~] = orbital_elements(r0_vec,v0_vec,t0,mu);

% Compute the true anomaly f(t)
f = true_anomaly(t,r0_vec,v0_vec,t0,mu,tol);

% Calculate e_hat and e_hat_perp
e_hat = e_vec_hat(i,w,Omega);
e_hat_perp = e_vec_hat_perp(i,w,Omega);

% Calculate position vector
r = a*(1-e^2)/(1+e*cosd(f));
r_vec = r*(cosd(f)*e_hat+sind(f)*e_hat_perp);

% Calculate the velocity vector
v_vec = sqrt(mu/(a*(1-e^2)))*(-sind(f)*e_hat + (e+cosd(f))*e_hat_perp);






