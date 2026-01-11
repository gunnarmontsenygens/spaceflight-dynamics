function J = J_pcr3bp(x,y,v_x,v_y,mu)
%==========================================================================
%
% Jacobi integral constant for the planar CR3BP
%
%
% Author: G. Montseny
% Date: November 21, 2025
%
%==========================================================================
J = 0.5*(v_x.^2+v_y.^2)-V_pcr3bp(x,y,mu);