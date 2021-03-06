% EFFECT_FAST_MOTION(VIDEO, DROP_FRAMES) applies a fast motion effect on
% a sequence of images. The array DROP_FRAMES stores the beginning of
% the effect in {i}{1}, the number of frames used before the effect in {i}{2}
% and the number of frames used after the effect in {i}{3}. The effect
% drops {i}{2}-{i}{3} frames randomly. The effect is applied 'i' times.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   EFFECT_FAST_MOTION(VIDEO, DROP_FRAMES) returns the original video
%   structure with the current video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       This method drops frames sequentially based on the given cell
%       array. For this purpose, it reads out the parameters and searches
%       the input_files array for non-text images. To do this the method
%       unique is used to find the last occurence of a certain frame nr,
%       as the last occurence is always the original frame. 

%       To find a certain frame its number has to be searched in the number array.
%       By looking up the same index in the positions array the index in
%       the image frame array is found.
%       These two arrays provide the information to find a frame by its number. 
%
%       Then the randperm matlab function to make a selection the random frames 
%       in the given domain. Lastly these frames are removed.
%       The end_frame in the video struct is also updated to accomodate for
%       the frame cutting.
%       
%   USE OF THE EFFECT:
%       As mentioned in the task description this technique was used in old
%       movies to shorten the tedious actions.
%
%       Frames are dropped in areas of the video randomly, thus the start point of the
%       area, the length and the number of frames to cut from that domain
%       are specified.
%       
%       For the start point, it has to be between the start and end frame
%       of the video. And it has to accomodate for the duration, thus has 
%       to be <end-duration.
%
%       The duration has to be >0 and <= number of video frames.
%       
%       The number of droped frames has to be between 1 and all frames in the
%       selected duration.
%
%       The same frame cannot be droped twice.
%
function video = effect_fast_motion(video, drop_frames)

    new_input = video.input_files;
    end_frame_nr = new_input(video.end_frame).frame_nr;
    removed_frames = 0;

    for a = 1:length(drop_frames)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate a list of all input frames we want to remove
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    startFrame = cell2mat(drop_frames{1,a}(1));
    domain = cell2mat(drop_frames{1,a}(2));
    rm_num = domain - cell2mat(drop_frames{1,a}(3));

    if startFrame <= video.end_frame
        removed_frames = removed_frames + rm_num;
    end
    % positions of image frames (= last frame with certain number)
    [number, position] = unique([new_input.frame_nr], 'last', 'legacy');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Remove frames from input list
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ra = (ones(1, rm_num) * (startFrame - 1)) + randperm(domain, rm_num);
    rm_indexes = position(ismember(number, ra));
    new_input(rm_indexes) = [];
    end
    
    video.input_files = new_input;
    last_frame =  find([new_input.frame_nr] <= end_frame_nr);
    video.end_frame = last_frame(end);
end