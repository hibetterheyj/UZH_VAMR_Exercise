%% draw a cube on image seqs
% ref: https://www.mathworks.com/help/matlab/import_export/convert-between-image-sequences-and-video.html
clc;clear;close all;
addpath('utils/');

%% parameters
grid_sz = 0.04; % (m)
% load parameters
K= load('./data/K.txt');
poses = load('./data/poses.txt');
% distortion parameters
D = load('./data/D.txt');
% checkerboard size
row = 5;
col = 8;
board_sz = [row, col];
% cube parameters
cube_x = 2; cube_y = 2;
start_pt = [cube_y,cube_x];
cube_grid = 1;
XYZ = false;

%% load image
working_dir = './data/';
img_dir = 'hyj_undistorted/';
save_dir =  'hyj_draw/';
mkdir(working_dir, save_dir)
img_list = dir([working_dir img_dir,'*.jpg']);
len = length(img_list);
start = 13;
for ii = 1:len
    f = figure;
    
    img = imread([working_dir img_dir img_list(ii).name]);
    img_gray = rgb2gray(img);
    imshow(img_gray);
    % read pose
    idx = ii+start-1;
    curr_pose = poses(idx,:);
    [R, T] = pose_vector_to_transformation_matrix(curr_pose);
    draw_cube(start_pt, cube_grid, grid_sz, K, R, T, XYZ);
    filename = ['hyj_cube_' sprintf('%04d',ii) '.png'];
    fullname = fullfile(working_dir,save_dir,filename);
    
    % save image
    % https://www.mathworks.com/help/matlab/ref/exportgraphics.html
    exportgraphics(gca,fullname,'BackgroundColor','none');
    %F= getframe(f);
    %img = F.cdata;
    %imwrite(img, fullname);
    %saveas(gcf,fullname); % png
    close all;
end