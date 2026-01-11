function [r_vec,v_vec] = posVelArray(t_array,r0_vec,v0_vec,t0,mu,tol)
%==========================================================================
%
% Calculates position vector and velocity vector at time t.
% ONLY FOR ELLIPTIC ORBITS (e<1)
%
% Author: G. Montseny
% Date: October 4, 2025
%
%
% INPUT:               Description                                   Units
%
%  t_array   -            input time  in array                                s
%  r0_vec  -        [x,y,z] position vector at time t = t0             km 
%  v0_vec   -       [v0_x,v0_y,v0_z] velocity vector at time t = t0   km/s
%  t0   -           initial time                                       s
%  mu   -           mass parameter                                 km^3/s^2
%  tol  -           numerical tolerance for solving Kepler's equation
%
% OUTPUT:       
%    
%  r_vec    -       [x,y,z] position vector at time t_array (nx3)      km
%  v_vec    -       [vx,vy,vz] velocity vector at time t_array (nx3)  km/s
%==========================================================================

n = numel(t_array);
r_vec = zeros(n,3);
v_vec = zeros(n,3);

for i = 1 : n
    t = t_array(i);

    [r_vec_i,v_vec_i] = posVel(t,r0_vec,v0_vec,t0,mu,tol);

    r_vec(i,:) = r_vec_i(:).';
    v_vec(i,:) = v_vec_i(:).';
end