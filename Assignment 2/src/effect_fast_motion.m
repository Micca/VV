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
%       .....   
%   
%   USE OF THE EFFECT:
%       .....
%
function video = effect_fast_motion(video, drop_frames)

    new_input = video.input_files;

    for a = 1:length(drop_frames)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate a list of all input frames we want to remove
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    startFrame = cell2mat(drop_frames{1,a}(1));
    domain = cell2mat(drop_frames{1,a}(2));
    rm_num = domain - cell2mat(drop_frames{1,a}(3));

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
    video.end_frame = length(new_input);
end