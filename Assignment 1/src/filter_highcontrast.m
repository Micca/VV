% FILTER_HIGHCONTRAST(VIDEO, DX, DY) increases the contrast of the current
% frame (video.frame(1).filtered) by moving the intensity values v of the image 
% towards 0 and 1 using a mapping functions f(v).
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   DX/DY:  settings for constructing the mapping function f(v) 
%
%   VIDEO = FILTER_HIGHCONTRAST(VIDEO, DX, DY) returns the original video 
%   structure with the updated current video.frame(1).filtered. Each filter
%   takes video.frame(1).filtered as input and writes the result back to this
%   array.
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
function video = filter_highcontrast(video, dx, dy)


end