function [t,a,e,i,w,Omega,sigma,energy,h_z] = orbelem_2bp_J2_v2(rt_vec,vt_vec,t,mu,R_0,J_2)
%==========================================================================
%
% Calculates orbital elements at time t0 and energy and angular momentum
% taking the J2 perturbation into account
%
% Author: G. Montseny
% Date: October 29, 2025
%
%
% INPUT:               Description                                   Units
%
%  rt_vec  -    [x,y,z] N x 3  posiiton array at times t               km 
%  vt_vec   -    [v_x,v_y,v_z] N x 3  posiiton array at times t       km/s
%  t   -            array of times                                      s 
%  mu   -     mass parameter                                        km^3/s^2
%  R_0               - radius of   planet                          km
%  J_2               -   constant
%
% OUTPUT:       
%    
%  a    -           semi-major axis                                    km
%  e    -           eccentricity                                        -
%  i    -           inclination                                        deg
%  w    -           argument of periapsis                              deg
%  Omega -          longitude of the ascending node                    deg
%  tp    -          time of periapsis passage                           s
%  energy
%  angular momentum about the z axis
%==========================================================================

% Create list
a = zeros(size(t));
e = zeros(size(t));
i = zeros(size(t));
w = zeros(size(t));
Omega = zeros(size(t));
sigma = zeros(size(t));
energy = zeros(size(t));
h = zeros(size(t));

for k = 1 : length(t)

    % Initialize position and velocity vectors
    r0_vec = rt_vec(k,:);
    v0_vec = vt_vec(k,:);
    t0 = t(k);

    % Calculate the position unit vector
    r0_hat = r0_vec/norm(r0_vec);
    
    % Compute the the angular momentum and the eccentricity vector
    h_vec = cross(r0_vec,v0_vec);
    e_vec = cross(v0_vec,h_vec)/mu-r0_hat;
    
    % Calculate the orbit parameter and eccentricity
    p = norm(h_vec)^2/mu;
    e(k) = norm(e_vec);
    
    % Define new unit vectors under some conditions
    if norm(h_vec) ~= 0
        h_hat = h_vec/norm(h_vec);
    end

    % Compute semi-major axis
    a(k) = p/(1-e(k)^2);
    
    % Compute the inclination
    z_hat = [0,0,1];
    i(k) = acosd(dot(h_hat,z_hat));
    
    % Define the node vector
    n_Omega = cross(z_hat,h_hat);
    n_Omega_hat = n_Omega/norm(n_Omega);
    
    % Compute the longitude of the ascending node
    x_hat = [1,0,0];
    y_hat = [0,1,0];
    Omega(k) = atan2d(dot(y_hat,n_Omega_hat),dot(x_hat,n_Omega_hat));
    %Omega(k) = mod(Omega(k),360);
    
    % Define the perpendicular vector to n_Omega_hat in the plane
    n_Omega_hat_perp = cross(h_hat,n_Omega_hat);
    
    % The argument of periapsis can be computed as
    w(k) = atan2d(dot(n_Omega_hat_perp,e_vec),dot(n_Omega_hat,e_vec));
    
    % Compute the normal to the eccentricity vector
    e_hat_perp = e_vec_hat_perp(i(k),w(k),Omega(k));

    % Compute e_hat
    e_hat = e_vec_hat(i(k),w(k),Omega(k));
    
    % Compute the true anomaly at t0
    f0 = atan2(dot(r0_vec,e_hat_perp),dot(r0_vec,e_hat));
    
    % Compute the eccentric or hyperbolic anomaly:
    if e < 1 
    
        E = 2*atan2(tan(f0/2)*sqrt((1-e(k))),sqrt((1+e(k))));

        n = sqrt(mu/a(k)^3);

        sigma(k) = E-e(k)*sin(E)-n*t0;

    
    elseif e > 1 
        F = 2*atanh(tan(f0/2)*sqrt((e-1)/(1+e)));
        
        % Compute the time of periapsis passage for a hyperbola
        tp(k) = t0 + (F-e*sinh(F))*sqrt(abs(a)^3/mu);
    elseif e == 1
    
        % Compute the time of periapsis passage for a parabola
        tp(k) = t0 - 0.5*sqrt(p^3/mu)*tan(f0/2)*(1+(tan(f0/2)^2)/3);
    end

    
    % Calculate energy for the J2 perturbation case
    energy(k) = 0.5*norm(v0_vec)^2-mu/norm(r0_vec)-mu*(R_0^2)*J_2*(1-3*r0_vec(3)^2/norm(r0_vec)^2)/(2*norm(r0_vec)^3);
    
    % Calculate angular momentum about the z-axis
    h_z(k) = dot([0,0,1],h_vec);

end

% Make sigma plottable with 2pi offsets
sigma = rad2deg(unwrap(sigma));


end
