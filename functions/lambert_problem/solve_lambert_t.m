function [delta_t0] = solve_lambert_t(r1_vec,r2_vec,a_0,dir,mu)
%==========================================================================
%
% Author: G. Montseny
% Date: October 14, 2025
%
%
%==========================================================================

% ------------------------------------------------------------------------------
% STEP 1: Determine if the requested transfer is a hyperbolic or elliptic orbit.
% ------------------------------------------------------------------------------

% Calculate essential variables
[c,s,theta] = init_lambert(r1_vec,r2_vec);

% Choose direction and theta
if theta < pi
    if strcmp(dir, 'short')
        theta = theta;
        fprintf('Short path');
    elseif strcmp(dir,'long')
        theta = 2*pi-theta;
        fprintf('Long path');
    else
        v1_vec = [NaN,NaN,NaN];
        return;

    end
else
    if strcmp(dir, 'short')
        theta = 2*pi-theta;
        fprintf('Short path');
    elseif strcmp(dir,'long')
        theta = theta;
        fprintf('Long path');
    else
        v1_vec = [NaN,NaN,NaN];
        return;
    end    

end


% ------------------------------------------------------------------------------
% STEP 2: Determine k_alpha and k_beta (branches)
% ------------------------------------------------------------------------------

% Let beta = k_beta beta_0
% Let alpha = k_alpha*(2pi, alpha_0) = dot((k_alpha_1,k_alpha_2),(2pi,alpha_0))

if strcmp(dir,'short')
    k_alpha = [0,1];
    k_beta = 1;
elseif strcmp(dir,'long')
    k_alpha = [1,-1];
    k_beta = -1;
else 
    k_alpha = [0,0];
end


% ------------------------------------------------------------------------------
% STEP 3: Solve for a
% ------------------------------------------------------------------------------

% Define functions to solve 4.25
alpha_0 = 2*asin(sqrt(s/(2*a_0)));
alpha = dot(k_alpha,[2*pi,alpha_0]);

beta_0 = 2*asin(sqrt((s-c)/(2*a_0)));
beta = k_beta*beta_0;

delta_t0 = ((a_0^(3/2))*(alpha-beta-(sin(alpha)-sin(beta))))/sqrt(mu);


