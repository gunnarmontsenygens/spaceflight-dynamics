function dfile = orbelem_2bp_file(rt_vec,vt_vec,t,mu)
%==========================================================================
%
% Calculates orbital elementsat time t0 and energy and angular momentum
%
% Author: G. Montseny
% Date: October 8, 2025
%
%
% INPUT:               Description                                   Units
%
%  rt_vec  -    [x,y,z] N x 3  posiiton array at times t               km 
%  vt_vec   -    [v_x,v_y,v_z] N x 3  posiiton array at times t       km/s
%  t   -            array of times                                      s 
%  mu   -     mass parameter                                        km^3/s^2
%
% OUTPUT:
%
% In a data file .txt
%    
%  a    -           semi-major axis                                    km
%  e    -           eccentricity                                        -
%  i    -           inclination                                        deg
%  w    -           argument of periapsis                              deg
%  Omega -          longitude of the ascending node                    deg
%  tp    -          time of periapsis passage                           s
%==========================================================================

% Extract arrays
[t,a,e,i,w,Omega,tp,energy,h] = orbelem_2bp(rt_vec,vt_vec,t,mu);
orbelem_e_h = [t(:),a(:),e(:),i(:),w(:),Omega(:),tp(:),energy(:),h(:)];

% Store them in a .txt file separated by tabs
dfile = 'orbelem_e_h.txt';
save(dfile,'orbelem_e_h','-ascii','-tabs')

end