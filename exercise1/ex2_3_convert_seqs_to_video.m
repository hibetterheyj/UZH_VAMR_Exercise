%% convert image seqs to video
% ref: https://www.mathworks.com/help/matlab/import_export/convert-between-image-sequences-and-video.html
clc;clear;close all;
addpath('utils/');

%% setup
working_dir = './data/';
save_dir =  'hyj_draw/';

%% convert into video
% ref: https://www.mathworks.com/help/matlab/ref/videowriter.html#d122e1429897
outputVideo = VideoWriter(fullfile(working_dir,'hyj_draw_cube.avi'));
outputVideo.FrameRate = 30;
open(outputVideo)

imageNames = dir(fullfile(working_dir,save_dir,'*.png'));
imageNames = {imageNames.name}';
img_1 = imread(fullfile(working_dir,save_dir,imageNames{1}));
w = size(img_1, 2);
h = size(img_1, 1);

fprintf("Start Converting!\n");
for ii = 1:length(imageNames)
   img = imread(fullfile(working_dir,save_dir,imageNames{ii}));
   if size(img,2) == w && size(img,1) == h
       writeVideo(outputVideo,img)
   end
end

close(outputVideo);
disp("Finish Converting!\n");