function [t_m] = calc_tm(c,s,theta,mu)
%==========================================================================
%
%
% Equations derived by myself or obtained from CH4. Lambert's Problem.
%
% Author: G. Montseny
% Date: October 14, 2025
%
%
%==========================================================================

% Calculate beta_m0
beta_m0 = 2*asin(sqrt(1-c/s));

% Calculate beta_m in different cases
if theta < pi
    beta_m = beta_m0;
    t_m = sqrt(s^3/(8*mu))*(pi-beta_m+sin(beta_m));
else
    beta_m = -beta_m0;
    t_m = sqrt(s^3/(8*mu))*(pi-beta_m+sin(beta_m));
end
