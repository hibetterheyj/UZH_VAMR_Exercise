%% Convert Between Image Sequences and Video
% convert the preview.mp4 to image sequences
clc;clear;close all;

%% setup
% Create a temporary working folder to store the image sequence.
working_dir = './data/';
img_dir = 'hyj_undistorted';
%mkdir(workingDir)
mkdir(working_dir, img_dir)

% Create VideoReader'images'
cube_video = VideoReader('preview.mp4');

%% Create the Image Sequence
ii = 1;

while hasFrame(cube_video)
   img = readFrame(cube_video);
   % crop the image to eliminate the white offset in the video
   saved_img = img(5:484,1:752,:);
   filename = ['img_' sprintf('%04d',ii) '.jpg'];
   fullname = fullfile(working_dir,img_dir,filename);
   imwrite(saved_img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end