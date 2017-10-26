% FILTER_IRIS(VIDEO, PARAM1, ..) achieves an iris effect by overlaying an alpha mask 
% on the current frame video.frame(1). The size of the iris can be defined by using
% appropriate parameters.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame.
%
%   TRANSITION_SIZE:  distance in pixels between iris size and end of
%   transition effect.
%
%   MIN_SIZE:  minimal iris size (percentage of image width).
%
%   MAX_SIZE:  maximal iris size (percentage of image width).
%
%   DIST_X:  horizontal distance in pixels between iris and image center.
%
%   DIST_Y:  vertical distance in pixels between iris and image center.
% 
%   VIDEO = FILTER_UNSHARP(VIDEO, PARAM1, ...) returns the original video structure
%   with the updated current video.frame(1).filtered. 
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
function video = filter_iris(video, transition_size, min_size, max_size, dist_x, dist_y);   


end