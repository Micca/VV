% FILTER_RAND_ILLUMINATION(VIDEO, MIN_BRIGHTNESS, MAX_BRIGHTNESS) varies the
% illumination of the most current frame and returns a random illuminated
% frame of a video structure.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   VIDEO = FILTER_RAND_ILLUMINATION(VIDEO, MIN_BRIGHTNESS, MAX_BRIGHTNESS) returns
%   the original video structure with the updated current video.frame(1).filtered.
%   Each filter takes video.frame(1).filtered as input and write the result back to this array.
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
function video = filter_rand_illumination(video, min_brightness, max_brightness)


end