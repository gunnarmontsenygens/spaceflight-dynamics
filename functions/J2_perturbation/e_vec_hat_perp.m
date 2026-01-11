function e_hat_perp = e_vec_hat_perp(i,w,Omega)
        e_hat_perp = [-sind(w)*cosd(Omega)-cosd(i)*cosd(w)*sind(Omega),
        -sind(w)*sind(Omega)+cosd(i)*cosd(w)*cosd(Omega),
        cosd(w)*sind(i)];
end