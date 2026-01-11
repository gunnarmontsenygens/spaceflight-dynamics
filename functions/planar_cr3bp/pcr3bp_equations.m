function dXdt = pcr3bp_equations(t,X, mu)
%==========================================================================
%
% Equations of motion for the planar CR3BP
%
% X = [x,y,v_x,v_y]
%
% Author: G. Montseny
% Date: November 21, 2025
%
%==========================================================================

% Extract components from X
x = X(1);
y = X(2);
v_x = X(3);
v_y = X(4);

% Partial derivatives of V
dVdx = x - (1-mu)*(x+mu)/((x+mu)^2+y^2)^(3/2)-mu*(x-1+mu)/((x-1+mu)^2+y^2)^(3/2);
dVdy = y - (1-mu)*y/((x+mu)^2+y^2)^(3/2)-mu*y/((x-1+mu)^2+y^2)^(3/2);

% Equations of PCR3BP
dXdt = [v_x;
    v_y;
    2*v_y+dVdx;
    -2*v_x+dVdy;
    ];
end