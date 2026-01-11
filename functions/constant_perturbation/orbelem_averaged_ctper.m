function [a_vec,e_vec,i_vec,wtilde_vec,sigma_vec] = orbelem_averaged_ctper(t_vec,a_0,e_0,i_0,wtilde_0,sigma_0,mu,g)
%==========================================================================
%
% Calculates orbital elements for selected times with averaging theory.
% Constant force in the x axis into account. 
% The perturbation potential is
%               R = g * dot( vec(r) , [1,0,0]).
% Program assumes that a stays constant throughout the times. 
% Assumes t0 = 0.
% IMPORTANT: assumes that i_0 = 0 at t = t0
% PROBLEM: wtilde and sigma MISSING EXPRESSIONS
%
% Author: G. Montseny
% Date: October 31, 2025
%
%
% INPUT:               Description                                   Units
%
%  t_vec   -          input time  array                                s
%  a_0  -             semi-major axis  at t = 0                       km 
%  i_0 -              inclination                                     deg
%  e_0  -             eccentricity                                     -
%  wtilde_0 -         longitude of periapsis                           deg
%  sigma_0  -        time of periapsis                                 s
%  mu   -           mass parameter                                 km^3/s^2
%  g   -           constant acceleration                             km^2/s
%
% OUTPUT:       
%    
%  a_vec  -             averaged semi-major axis  at t                   km 
%  i_vec -              averaged inclination at t                       deg
%  e_vec  -             averaged eccentricity at t                       -
%  wtilde_vec -              averaged longitude of periapsis  at t      deg
%  sigma_vec  -         averaged time of periapsis at t                  s
%==========================================================================

% Preallocate all output arrays
n_t = length(t_vec);
a_vec = zeros(1,n_t);
e_vec = zeros(1,n_t);
i_vec = zeros(1,n_t);
wtilde_vec = zeros(1,n_t);
sigma_vec = zeros(1,n_t);

% Calculate other orbital parameters
p_0 = a_0*(1-e_0^2);
n_0 = sqrt(mu/a_0^3);

% Calculate the averaged orbit elements at different times
for i = 1 : n_t
    t = t_vec(i);

    a_vec(i) = a_0;

    e_vec(i) = e_0+abs(sin(1.5*g*t/(n_0*a_0)));

    i_vec(i) = i_0;

    wtilde_vec(i) = -90; 

    sigma_vec(i) = sigma_0; %+ 1.5*J_2*R_0^2*sqrt(1-e_0^2)*n_0*(1-1.5*sind(i_0)^2)*t/p_0^2*360/(2*pi);
end

end