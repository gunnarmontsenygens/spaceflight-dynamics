function [rt_vec,vt_vec,t] = pcr3bp_solver(r0_vec, v0_vec, mu, t0, tf)
%==========================================================================
%
% Solves planar CR3BP
%
% Author: G. Montseny
% Date: November 21, 2025
%
%
% INPUT:               Description                                   Units
%
%  r0_vec  -    [x,y] position vector at time t = t0                km 
%  v0_vec   -    [v0_x,v0_y] velocity vector at time t = t0     km/s
%  t0   -     initial time                                             s
%  tf   -     final time                                               s
%  mu   -     mass parameter                                       km^3/s^2
%
% OUTPUT:       
%  rt_vec  -    [x,y] N x 2  posiiton array at times t               km 
%  vt_vec   -    [v_x,v_y] N x 2  posiiton array at times t       km/s
%  t   -            array of times                                      s   

%==========================================================================

% First, let us obtain the initial conditions
X0 = [r0_vec(:);v0_vec(:)];

% Set up tolerances
options_ODE = odeset('RelTol', 1e-12, 'AbsTol', 1e-13);

% Solve ODE
[t,X] = ode45(@(t,x)pcr3bp_equations(t,x,mu),[t0,tf],X0,options_ODE);


% Returns are N x 4, hence we separate into position and velocity:
rt_vec = X(:,1:2);
vt_vec = X(:,3:4);

end