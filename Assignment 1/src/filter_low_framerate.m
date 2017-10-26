% FILTER_LOW_FRAMERATE(VIDEO, SOURCE_FRAMERATE, TARGET_FRAMERATE) is a time based
% filter which changes the framerate from SOURCE_FRAMERATE to TARGET_FRAMERATE.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame.
%
%   VIDEO = FILTER_LOW_FRAMERATE(VIDEO, SOURCE_FRAMERATE, TARGET_FRAMERATE)
%   returns the original video structure with the updated current video.frame(1).filtered. 
% 
% Example:
%   VIDEO = FILTER_LOW_FRAMERATE(VIDEO, 25, 19) returns in total 25 frames per second
%   but only 19 different ones. 6 frames are randomly replaced by their forerunners. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       .....
%
%   PHYSICAL BACKGROUND:
%       .....
function video = filter_low_framerate(video, source_fps, target_fps)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check if we process the first frame and init filter 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (~isfield(video, 'filter_low_framerate'))
        video.filter_low_framerate.start_frame = video.start_frame;
    end


end