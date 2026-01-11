function e_hat_perp = e_vec_hat_perp(i,w,Omega)
%==========================================================================
%
% Calculates normalized vector perpendicular to the eccentricity vector.
%
% Author: G. Montseny
% Date: October 4, 2025
%
%
% INPUT:               Description                                   Units
%
%  i    -           inclination                                        deg
%  w    -           argument of periapsis                              deg
%  Omega -          longitude of the ascending node                    deg
%
% OUTPUT:       
%    
%  e_hat_perp  - norm. perpendicular vector to the eccentricity vector   -
%==========================================================================
e_hat_perp = [-sind(w)*cosd(Omega)-cosd(i)*cosd(w)*sind(Omega),
        -sind(w)*sind(Omega)+cosd(i)*cosd(w)*cosd(Omega),
        cosd(w)*sind(i)];
end