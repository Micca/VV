% EFFECT_ADD_TEXT(VIDEO, TEXT) adds additional images to the input image list. 
% This can be used for adding images with text description of the next scene.
% 
%   VIDEO:  a structure containing an array of frames where frame(1)
%           contains the most current frame. 
%
%   TEXT:   is a cell array containing 3 entires. The
%           i-th cell array has the format:
%
%     text{i}{1} = Name of image file containing the scene text
%
%     text{i}{2} = Number of the input file where we want to add the additional
%                  images. e.g. 1 -> text images are inserted before the 
%                  first input image
%
%     text{i}{3} = Duration of the text scene. 
%
%
% Example:
%     >> effect_add_text(video, {{'../text/scene_text1.png', 1, 5}});
%
%     adds the image in file '../text/scene_text1.png' before input image 1
%     and displays it for 5 frames. 
%
%     Original image order (Ix is the x-th input frame):
%
%       I1, I2, I3, I4, .... 
%
%     New image order (Tx is the image added for the x-th text insertion):
%
%       T1, T1, T1, T1, T1, I1, I2, I3, I4, ...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   IMPLEMENTATION:
%       .....
%   
%   USE OF THE EFFECT:
%       .....
%
function video = effect_add_text(video, text)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get positions/durations of text scenes
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Insert entries into video.input_files array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
