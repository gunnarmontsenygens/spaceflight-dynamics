function dfile = twobp_solver_file(r0_vec, v0_vec, mu, t0, tf)
%==========================================================================
%
% Solves 2 body problem.
%
% Author: G. Montseny
% Date: October 8, 2025
%
%
% INPUT:               Description                                   Units
%
%  r0_vec  -    [x,y,z] position vector at time t = t0                km 
%  v0_vec   -    [v0_x,v0_y,v0_z] velocity vector at time t = t0     km/s
%  t0   -     initial time                                             s
%  tf   -     final time                                               s
%  mu   -     mass parameter                                       km^3/s^2
%
% OUTPUT:   
%
% In a .txt file.
%
%  rt_vec  -    [x,y,z] N x 3  posiiton array at times t               km 
%  vt_vec   -    [v_x,v_y,v_z] N x 3  posiiton array at times t       km/s
%  t   -            array of times                                      s   

%==========================================================================

% First, let us obtain the initial conditions
X0 = [r0_vec(:);v0_vec(:)];

% Set up tolerances
options_ODE = odeset('RelTol', 1e-12, 'AbsTol', 1e-13);

% Solve ODE
[t,X] = ode45(@(t,x)two_body_equations(t,x,mu),[t0,tf],X0,options_ODE);

% Store data in a .txt file separated by tabs
dfile = 'twobp_solutions.txt';
twobp_solutions = [t,X(:,1),X(:,2),X(:,3),X(:,4),X(:,5),X(:,6)];
save(dfile,'twobp_solutions','-ascii','-tabs')

end