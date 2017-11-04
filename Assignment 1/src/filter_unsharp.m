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
%       For aestethic reasons, gaussian filter are often used to smooth out
%       noise out of frames, which often appears if the images were
%       done under bad lighting circumstances. Furthermore, it is also
%       commonly used to hide a particular area in a frame. Gaussian filter
%       plays a big role in anti-aliasing. 
%
%   RANGE VALUES FOR PARAMETERS:
%       Size should be an uneven number so that the filter has a center. 
%       (3-(1/4 * size of image))
%       
%       The unsharpening effect depends strongly on both parameters to get
%       a strongly blurred image the size of the filter has be big enough
%       (>3) and the std also (>1). The standard deviation defines how
%       strongly the value is influenced by surrounding pixels and the size
%       defines how many pixels are considered to blurr.
function video = filter_unsharp(video, std, size)
    fsize=[size size];
    gauss_kernel= fspecial('gaussian', fsize, std);
    
    video.frame(1).filtered= imfilter(video.frame(1).filtered, gauss_kernel);
end