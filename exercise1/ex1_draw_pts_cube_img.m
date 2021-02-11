%% draw a cube on a single image
clc;clear;close all;
addpath('utils/');

%% setup
% load image
img = imread("./data/images_undistorted/img_0001.jpg");
img_gray = rgb2gray(img);

% load parameters
% intrinsic
K= load('./data/K.txt');
% extrinsic (pose)
poses = load('./data/poses.txt');
init_pose = poses(1,:);
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

%% projection
[R, T] = pose_vector_to_transformation_matrix(init_pose);
grid_pts_pixel = project_points(grid_pts_w, K, R, T);

%% visualization points
imshow(img_gray);
hold on
scatter(grid_pts_pixel(1,:), grid_pts_pixel(2,:), 40, 'r', 'filled');

%% cube parameters
% board_sz=[5,8];
% grid_sz = 0.04; % (m)
cube_x = 4; cube_y = 1;
start_pt = [cube_y,cube_x];
cube_grid = 2;
XYZ = true;
draw_cube(start_pt, cube_grid, grid_sz, K, R, T, XYZ);