function [t,a,e,i,w,Omega,tp,energy,h_x] = orbelem_2bp_ctper(rt_vec,vt_vec,t,mu,g)
%==========================================================================
%
% Calculates orbital elements at time t0 and energy and angular momentum
% taking the constant force in the x axis into account. 
% The perturbation potential is
%               R = g * dot( vec(r) , [1,0,0]).
%
% Author: G. Montseny
% Date: October 31, 2025
%
%
% INPUT:               Description                                   Units
%
%  rt_vec  -       [x,y,z] N x 3  posiiton array at times t           km 
%  vt_vec   -      [v_x,v_y,v_z] N x 3  posiiton array at times t     km/s
%  t   -           array of times                                      s 
%  mu              mass parameter                                   km^3/s^2
%  g   -           constant acceleration                             km^2/s
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
%  angular momentum about the x axis
%==========================================================================

% Create list
a = zeros(size(t));
e = zeros(size(t));
i = zeros(size(t));
w = zeros(size(t));
Omega = zeros(size(t));
tp = zeros(size(t));
energy = zeros(size(t));
h_x = zeros(size(t));

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

    if abs(i(k)) > 1e-8 && abs(i(k))<179
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
        
            % Compute time of periapsis passage for an ellipse
            tp(k) = t0 - (E-e(k)*sin(E))*sqrt(a(k)^3/mu);
        
        elseif e > 1 
            F = 2*atanh(tan(f0/2)*sqrt((e-1)/(1+e)));
            
            % Compute the time of periapsis passage for a hyperbola
            tp(k) = t0 + (F-e*sinh(F))*sqrt(abs(a)^3/mu);
        elseif e == 1
        
            % Compute the time of periapsis passage for a parabola
            tp(k) = t0 - 0.5*sqrt(p^3/mu)*tan(f0/2)*(1+(tan(f0/2)^2)/3);
        end
        
    else

        % Add w_tilde to w list and set rest of elements to NaN
        if e(k) > 1e-10
            w_tilde = atan2d(e_vec(2),e_vec(1));
        else
            w_tilde = -90;
        end
        
        w(k) = w_tilde;

        Omega(k) = NaN;
        tp(k) = NaN;

    end

    % Calculate energy for the J2 perturbation case
    energy(k) = 0.5*norm(v0_vec)^2-mu/norm(r0_vec)-g*r0_vec(1);
        
    % Calculate angular momentum about the x-axis
    h_x(k) = dot([1,0,0],h_vec);
end


end
