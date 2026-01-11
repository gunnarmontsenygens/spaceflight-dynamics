function dXdt = two_body_equations_ctper(t,X, mu,g)
%==========================================================================
%
% Equations of motion for the 2-body problem with a constant force in the x
% axis. The perturbation potential is
%               R = g * dot( vec(r) , [1,0,0])
%
% Author: G. Montseny
% Date: October 31, 2025
%
% INPUT:            Description                                  Units
%
% g               - constant acceleration                       km^2/s
%
% OUTPUT:       
%    
%
%==========================================================================

% Set positions and velocities
x = X(1);
y = X(2);
z = X(3);
v_x = X(4);
v_y = X(5);
v_z = X(6);

% Set the radius
r = sqrt(x^2+y^2+z^2);

% Set the u
u = [g,0,0];

% Perurbes equations
dXdt = [v_x;
    v_y;
    v_z;
    -mu*x/r^3 + u(1);
    -mu*y/r^3 + u(2);
    -mu*z/r^3 + u(3);
    ];
end