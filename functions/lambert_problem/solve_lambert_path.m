function [orbit,v1_vec] = solve_lambert_path(r1_vec,r2_vec,c,s,theta,delta_t,mu)
%==========================================================================
%
% Equations derived by myself or obtained from CH4. Lambert's Problem.
%
% Author: G. Montseny
% Date: October 14, 2025
%
%==========================================================================

% ------------------------------------------------------------------------------
% STEP 1: Determine if the requested transfer is a hyperbolic or elliptic orbit.
% ------------------------------------------------------------------------------
% Compute the parabolic transfer time t_p 
delta_tp = calc_tp(c,s,theta,mu);

% Determine theta's direction
if theta<pi
    theta_dir = 'theta < pi';
else
    theta_dir = 'theta > pi';
end

% Determine if they are hyperbolic or elliptic
if delta_t < delta_tp
    orbit = append('Hyperbolic | ',theta_dir);
    v1_vec = [NaN,NaN,NaN];
    return;
else
    orbit = append('Elliptic orbit | ',theta_dir);
end

% ------------------------------------------------------------------------------
% STEP 2: Determine k_alpha and k_beta (branches)
% ------------------------------------------------------------------------------

% Let beta = k_beta beta_0
% Let alpha = k_alpha*(2pi, alpha_0) = dot((k_alpha_1,k_alpha_2),(2pi,alpha_0))

[k_alpha,k_beta] = det_branches(delta_t,c,s,theta,mu);

% ------------------------------------------------------------------------------
% STEP 3: Solve for a
% ------------------------------------------------------------------------------

% Define functions to solve 4.25
f_alpha0 = @(a) 2*asin(sqrt(s/(2*a)));
f_alpha = @(a) dot(k_alpha,[2*pi,f_alpha0(a)]);

f_beta0 = @(a) 2*asin(sqrt((s-c)/(2*a)));
f_beta = @(a) k_beta*f_beta0(a);

f_res = @(a) (a^(3/2))*(f_alpha(a)-f_beta(a)-(sin(f_alpha(a))-sin(f_beta(a))))-sqrt(mu)*delta_t;

% Solve for a
a_m = s/2;
a_0 = [a_m,5*s];
a = fzero(f_res,a_0);

% Calculate alpha and beta
alpha = dot(k_alpha,[2*pi,2*asin(sqrt(s/(2*a)))]);
beta = k_beta*2*asin(sqrt((s-c)/(2*a)));

% ------------------------------------------------------------------------------
% STEP 4: Output the initial velocity
% ------------------------------------------------------------------------------

% Calculate A (4.37a)
A = sqrt(mu/(4*a))*cot(alpha/2);

% Calculate B (4.37b)
B = sqrt(mu/(4*a))*cot(beta/2);

% calculate vectors (4.35)
u_1 = r1_vec./norm(r1_vec);
u_2 = r2_vec./norm(r2_vec) ;
u_c = (r2_vec-r1_vec)./c;

% Calculate v1 (4.36)
v1_vec = (B+A).*u_c + (B-A).*u_1;