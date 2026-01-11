function [rt_vec,vt_vec,t] = twobp_solver_ctper(r0_vec, v0_vec, mu,g,t0, tf)
%==========================================================================
%
% Solves 2 body problem with with a constant force in the x
% axis. The perturbation potential is
%               R = g * dot( vec(r) , [1,0,0]).
%
% Author: G. Montseny
% Date: October 31, 2025
%
%
% INPUT:               Description                                   Units
%
%  r0_vec  -    [x,y,z] position vector at time t = t0                km 
%  v0_vec   -    [v0_x,v0_y,v0_z] velocity vector at time t = t0     km/s
%  t0   -     initial time                                             s
%  tf   -     final time                                               s
%  mu   -     mass parameter                                       km^3/s^2
%  g               - constant acceleration                       km^2/s
%
% OUTPUT:       
%  rt_vec  -    [x,y,z] N x 3  posiiton array at times t               km 
%  vt_vec   -    [v_x,v_y,v_z] N x 3  posiiton array at times t       km/s
%  t   -            array of times                                      s   

%==========================================================================

% First, let us obtain the initial conditions
X0 = [r0_vec(:);v0_vec(:)];

% Set up tolerances
options_ODE = odeset('RelTol', 1e-12, 'AbsTol', 1e-13);

% Solve ODE
[t,X] = ode45(@(t,x)two_body_equations_ctper(t,x, mu,g),[t0,tf],X0,options_ODE);

% Returns are N x 6, hence we separate into position and velocity:
rt_vec = X(:,1:3);
vt_vec = X(:,4:6);

end