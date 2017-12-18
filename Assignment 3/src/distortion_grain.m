% DISTORTION_GRAIN(VIDEO) adds film grain to an existing frame in
% VIDEO.FRAME(1).FILTERED.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
%
%   VIDEO = DISTORTION_GRAIN(VIDEO, PARAM1, ...) returns the original video structure
%   with the updated current video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       Applying the imnoise function with 'gaussian' and parameter, which
%       requires a mean value and a variance. This seems for us to be the
%       best filter type which can be used to yield the desired effect.
%       The noise function is applied seperately on each of the RGB
%       channels, but it doesn't seem to make any big visual difference in
%       contrast to apply the effect on the whole image together.
%   PHYSICAL BACKGROUND:
%      On old analog films, film grain is caused by the accumulation of
%      small silver particles, which are responsible for the fragmentation
%      of consistently blacken surfaces. Usually, films with lower film
%      film speed (Filmempfindlichkeit) are less fine-grained than films
%      with higher film speed. Film grain is not the same as image noise,
%      even though it visually looks very similar.
%       
function video = distortion_grain(video)

    if(video.frame(1).frame_nr == -1)
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Apply imnoise filter on the whole image 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    red = imnoise(video.frame(1).filtered(:,:,1),'gaussian',0,0.005); % Red channel
    green = imnoise(video.frame(1).filtered(:,:,2),'gaussian',0,0.005); % Green channel
    blue = imnoise(video.frame(1).filtered(:,:,3),'gaussian',0,0.005); % Blue channel
    
    video.frame(1).filtered = cat(3, red, green, blue);