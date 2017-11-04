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
%       To generate a random luma_factor between min, max we use the
%       following formula: luma(min, max)= min + (max-min) * rand(1, 1);
%       Min is the lowest value the luma factor can get.
%       The random factor (allways between 0-1) scales the distance between
%       max and min. Thus the luma factor can be at most max.
%       
%       All color channels of the image are then multiplied by the random luma value.
%
%   PHYSICAL BACKGROUND: 
%       This effect is used to imitate old movies, which has mostly different
%       illumination from frame to frame. The reason for this has several
%       reasons like the mechincal process of taking images on a e.g. 8mm
%       film, which can cause a quite high fickleness of brightness.
%       Furthermore, old projectors which were used to present old film
%       used arc lamps as lighting sources. Arc lamps are well known for
%       flickering, even though that many improvements were done in the
%       past to reduce the effect.
%
%   RANGE VALUES FOR PARAMETERS:
%       Valid range values are between >0 to <1.
%       When the range is set under zero the whole picture will be white.
%       Values above one can scale the color values of the picture out of
%       the depictable range, causing a white spot.
%       Pixel in this white spot depict a loss of information, as their
%       values are now indistinguishable form each other.
function video = filter_rand_illumination(video, min_brightness, max_brightness)
    luma_factor= min_brightness + (max_brightness - min_brightness) .* rand(1, 1);
    video.frame(1).filtered= video.frame(1).filtered .* luma_factor;
end