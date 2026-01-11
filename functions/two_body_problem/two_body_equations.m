function dXdt = two_body_equations(t,X, mu)
%==========================================================================
%
% Equations of motion for the 2-body problem
%
% Author: G. Montseny
% Date: October 8, 2025
%
%==========================================================================

r = sqrt(X(1)^2+X(2)^2+X(3)^2);

dXdt = [X(4);
    X(5);
    X(6);
    -mu*X(1)/r^3;
    -mu*X(2)/r^3;
    -mu*X(3)/r^3;
    ];
end