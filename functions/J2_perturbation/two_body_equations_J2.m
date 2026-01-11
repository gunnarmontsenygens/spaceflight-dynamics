function dXdt = two_body_equations_J2(t,X, mu,R_0,J_2)
%==========================================================================
%
% Equations of motion for the 2-body problem with the J2 perturbation
%
% Author: G. Montseny
% Date: October 29, 2025
%
% INPUT:            Description                                  Units
%
% R_0               - radius of   planet                          km
% J_2               -   constant
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

% Set the u_J2
u_J2 = (-3*mu*(R_0^2)*J_2/(2*r^7))*[x*(x^2+y^2-4*z^2),y*(x^2+y^2-4*z^2),z*(3*(x^2+y^2)-2*z^2)];

% Perurbes equations
dXdt = [v_x;
    v_y;
    v_z;
    -mu*x/r^3 + u_J2(1);
    -mu*y/r^3 + u_J2(2);
    -mu*z/r^3 + u_J2(3);
    ];
end