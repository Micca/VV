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
%       The unsharpening effect can be easily done by the Matlab provided
%       functions fspecial and imfilter.
%       Fspecial creates a gaussian filter of provided size and standart
%       deviation, the imfilter function convolves the img with the filter.
%   PHYSICAL BACKGROUND:
%       .....
%
%   RANGE VALUES FOR PARAMETERS:
%       .....
function video = filter_unsharp(video, std, size)
    fsize=[size size];
    gauss_kernel= fspecial('gaussian', fsize, std);
    
    video.frame(1).filtered= imfilter(video.frame(1).filtered, gauss_kernel);
end