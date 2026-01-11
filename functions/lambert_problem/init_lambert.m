function [c,s,theta] = init_lambert(r1_vec,r2_vec)
%==========================================================================
%
% Initializes Lamber's Problem
%
% Author: G. Montseny
% Date: October 14, 2025
%
%==========================================================================

% Calculate magnitudes r1, r2, and c
r1 = norm(r1_vec);
r2 = norm(r2_vec);
c = norm(r2_vec-r1_vec);

% Compute the semiperimeter of the space triangle FP1P2 
s = (r1+r2+c)/2;

% Caclulate theta
theta = acos(dot(r1_vec,r2_vec)/(r1*r2));
theta = mod(theta,2*pi);