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
%       In an initialization step the double_frame array is created with
%       the lenght target_fps. In it is noted whether a frame is replaced
%       or not. Random numbers between 1-25 are generated for the number of
%       frames that need to be skipped and and placed in the double_frame
%       array.
%
%       Each time the filter is called it is determined where the video is
%       in the 25 frame cycle. This position is then read out of the
%       double_frame array to determine wheter to replace or not.
%   PHYSICAL BACKGROUND:
%       To save money early films were filmed by hand cranked cameras
%       in ~14fps As each frame was a picture on a tape roll it was kept as 
%       low as possible so the movement is still perceived fluently. 
%       
function video = filter_low_framerate(video, source_fps, target_fps)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check if we process the first frame and init filter 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (~isfield(video, 'filter_low_framerate'))
        video.filter_low_framerate.start_frame = video.start_frame;
        video.filter_low_framerate.double_frame = zeros(1, source_fps);
        skip_num = (source_fps - target_fps);
        rand = randperm(25, skip_num);
        video.filter_low_framerate.double_frame = zeros(1, source_fps);
        for a = 1: skip_num
            video.filter_low_framerate.double_frame(rand(a))=1;
        end
        %{
        skip = source_fps / skip_num;
        if skip >=2
            skip_index = round(skip);
            video.filter_low_framerate.double_frame = zeros(1, source_fps);
            video.filter_low_framerate.double_frame(skip_index : skip_index : skip_index*skip_num) = 1;
            video.filter_low_framerate.double_frame=video.filter_low_framerate.double_frame(1,1 : source_fps);
        else
            keep_index = round(source_fps / target_fps);
            video.filter_low_framerate.double_frame = ones(1, source_fps);
            video.filter_low_framerate.double_frame(1 : keep_index : (keep_index * target_fps)-1) = 0;
            video.filter_low_framerate.double_frame=video.filter_low_framerate.double_frame(1,1 : source_fps);
        end
        frames= sum(video.filter_low_framerate.double_frame);
        target= frames + target_fps;
        %}
    end
    
    frame_pos = mod(video.frame(1).frame_nr, source_fps);
    if frame_pos == 0
        frame_pos = 25;
    end
    
    if video.filter_low_framerate.double_frame(frame_pos) == 1
        video.frame(1).filtered = video.frame(2).filtered;
    end
end