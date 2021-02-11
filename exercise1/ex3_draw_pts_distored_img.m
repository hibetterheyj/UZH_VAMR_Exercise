%% Accounting for lens distortion
clc;clear;close all;
addpath('utils/');

%% setup
% load image
img = imread("./data/images/img_0001.jpg");
img_gray = rgb2gray(img);

% load parameters
% intrinsic
K= load('./data/K.txt');
% extrinsic (pose)
poses = load('./data/poses.txt');
init_pose = poses(1,:);
% distortion
D = load('./data/D.txt');
% checkerboard size
row = 5;
col = 8;
board_sz = [row, col];
% positions of all the checkerboard corners
[X, Y, Z] = meshgrid(0:col,0:row,0);
grid_sz = 0.04; % (m)
x = reshape(X * grid_sz, [],1);
y = reshape(Y * grid_sz, [],1);
z = reshape(Z * grid_sz, [],1);
grid_pts_w = [x, y, z];

%% projection with distortion
[R, T] = pose_vector_to_transformation_matrix(init_pose);
grid_pts_pixel = project_points_distorted(grid_pts_w, K, R, T, D);

%% visualization points
imshow(img_gray);
hold on
scatter(grid_pts_pixel(1,:), grid_pts_pixel(2,:), 40, 'r', 'filled');

%%
function pts_pixel = project_points_distorted(pts_w, K, R, T, D)
    % (x_w, y_w)
    pts_w_homo = [pts_w'; ones(1, size(pts_w, 1))];
    % (x_c, y_c)
    pts_c_homo = [R T] * pts_w_homo;
    % (x,y)
    pts_img = K * pts_c_homo;
    % (u,v)
    pts_pixel = pts_img(1:2,:) ./ pts_img(3,:);
    % (u_d, v_d)
    delta_u = pts_pixel(1,:) - K(1,3);
    delta_v = pts_pixel(2,:) - K(2,3);
    r = cal_seq_norm(delta_u, delta_v);
    pts_pixel = round(repmat(1 + D(1) * r.^2 + D(2) * r.^4, 2, 1) .* [delta_u;delta_v] +K(1:2,3));
end

function norm_vec = cal_seq_norm(X, Y)
    for i = 1:length(X)
        norm_vec(i) = norm(X(i), Y(i));
    end
end