function e_hat = e_vec_hat(i,w,Omega)
%==========================================================================
%
% Calculates normalized eccentricity vector.
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
%  e_hat    -       normalized eccentricity vector                     km
%==========================================================================
e_hat = [cosd(w)*cosd(Omega)-cosd(i)*sind(w)*sind(Omega),
        cosd(w)*sind(Omega)+cosd(i)*sind(w)*cosd(Omega),
        sind(w)*sind(i)];
end
