function pts_pixel = project_points(pts_w, K, R, T)
    % (x_w, y_w)
    pts_w_homo = [pts_w'; ones(1, size(pts_w, 1))];
    % (x_c, y_c)
    pts_c_homo = [R T] * pts_w_homo;
    % (x,y)
    pts_img = K * pts_c_homo;
    % (u,v)
    pts_pixel = round(pts_img(1:2,:) ./ pts_img(3,:));
end