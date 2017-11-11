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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate a list of all input frames we want to remove
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Remove frames from input list
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
