function draw_cube(start_pt, cube_grid, grid_sz, K, R, T, XYZ)
    unit_cube = [0 0 0; 0 0 -1; 0 1 0; 0 1 -1;
                        1 0 0; 1 0 -1; 1 1 0; 1 1 -1]';
    cube_pts_w = grid_sz * (cube_grid * unit_cube + [start_pt'; 0]);
    cube_pts_pixel = project_points(cube_pts_w', K, R, T);
    % hold on
    % scatter(cube_pts_pixel(1,:), cube_pts_pixel(2,:), 40, 'bs', 'filled');
    lines_idx = [1 2; 1 3; 1 5; 2 4;
        2 6; 3 4; 3 7; 4 8;
        5 6; 5 7; 6 8; 7 8];
    for i = 1:size(lines_idx, 1)
        plot(cube_pts_pixel(1, lines_idx(i,:)), cube_pts_pixel(2, lines_idx(i,:)), 'magenta', 'LineWidth', 5)
    end
    if XYZ
        origin = [0,0,0];
        x_max = [9,0,0];
        y_max = [0,6,0];
        z_max = [0,0,-3];
        coor_pts_w = [origin; x_max; y_max; z_max] * grid_sz;
        coor_pts_pixel = project_points(coor_pts_w, K, R, T);
        plot(coor_pts_pixel(1, 1:2), coor_pts_pixel(2, 1:2), 'r', 'LineWidth', 5)
        plot(coor_pts_pixel(1, 1:2:3), coor_pts_pixel(2, 1:2:3), 'g', 'LineWidth', 5)
        plot(coor_pts_pixel(1, 1:3:4), coor_pts_pixel(2, 1:3:4), 'b', 'LineWidth', 5)
    end
end