function e_hat = e_vec_hat(i,w,Omega)
        e_hat = [cosd(w)*cosd(Omega)-cosd(i)*sind(w)*sind(Omega),
        cosd(w)*sind(Omega)+cosd(i)*sind(w)*cosd(Omega),
        sind(w)*sind(i)];
end
