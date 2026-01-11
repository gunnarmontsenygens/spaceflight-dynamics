function [k_alpha,k_beta] = det_branches(delta_t,c,s,theta,mu)
%==========================================================================
%
% Determines branches of the Lambert problem.
%
% Author: G. Montseny
% Date: October 14, 2025
%
%
%==========================================================================

% Determine k_beta (4.31a)
if theta < pi
    k_beta = 1;
else 
    k_beta = -1;
end

% Calculate t_m
t_m = calc_tm(c,s,theta,mu);

% Determine k_alpha

if delta_t <= t_m
    k_alpha = [0,1];
else
    k_alpha = [1,-1];
end

