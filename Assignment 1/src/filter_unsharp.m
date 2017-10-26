% FILTER_UNSHARP(VIDEO, GAUSSIAN_SIZE, GAUSSIAN_STD) changes the sharpness 
% of the current frame video.frame(1). GAUSSIAN_SIZE and GAUSSIAN_STD
% effect the size respectively the standard deviation of the applied
% filter.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   VIDEO = FILTER_UNSHARP(VIDEO, GAUSSIAN_SIZE, GAUSSIAN_STD) returns the original video structure
%   with the updated current video.frame(1).filtered. The unsharpness of the final image can
%   be modified by PARAM1...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       .....
%
%   PHYSICAL BACKGROUND:
%       .....
%
%   RANGE VALUES FOR PARAMETERS:
%       .....
function video = filter_unsharp(video, PARAM1, ...)


end