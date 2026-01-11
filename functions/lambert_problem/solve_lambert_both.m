function [orbit_1,v1_vec_1,orbit_2,v1_vec_2] = solve_lambert_both(r1_vec,r2_vec,delta_t,mu)
%==========================================================================
%
%
% Author: G. Montseny
% Date: October 14, 2025
%
%
%==========================================================================

% Calculate essential variables
[c,s,theta] = init_lambert(r1_vec,r2_vec);

% Solve for path 1
[orbit_1,v1_vec_1] = solve_lambert_path(r1_vec,r2_vec,c,s,theta,delta_t,mu);
[orbit_2,v1_vec_2] = solve_lambert_path(r1_vec,r2_vec,c,s,2*pi-theta,delta_t,mu);



