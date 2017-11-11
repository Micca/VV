% EFFECT_SOFT_FOCUS(VIDEO, BLUR_FACTOR, FOCUS) applies a soft focus
% effect on a sequence of images beginning with START_FRAME. The sequence lasts
% DURATION seconds. The strongest blur filter is applied to the START_FRAME of a sequence and decreases with 
% each following frame. After DURATION frames the blur stops. BLUR_FACTOR
% determines the 'strongness' of the blur at START_FRAME.
%
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   BLUR_FACTOR: parameter determines the 'strongness' of the blur at
%   START_FRAME
%
%   FOCUS: contains the start position of each blur and the duration of the blur effect until
%   the blur effect vanishes.
%
%   VIDEO = EFFECT_SOFT_FOCUS(VIDEO, BLUR_FACTOR, FOCUS) returns the original video structure
%   with a blur filter applied to video.frame(X).filtered. A circular averaging filter kernel 
%   (fspecial('disk',..) is used for the blur operation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       .....
%  
%   USE OF THE EFFECT:
%       .....
%
function video = effect_soft_focus(video, blur_factor, focus)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZ FILTER AT FIRST CALL
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (~isfield(video, 'effect_soft_focus'))

        for i = 1:numel(focus)
            pos(i)       = focus{i}{1};         
            duration(i)  = focus{i}{2}; 
        end

        video.effect_soft_focus.pos_start = pos;
        video.effect_soft_focus.duration  = duration;    
        video.effect_soft_focus.pos_end   = pos+duration-1;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CHECK IF THE CURRENT FRAME IS PROCESSED BY THIS EFFECT 
    % (frame(x).frame_nr between pos(i) and pos(i)+duration(i)-1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GET THE FRAME DEPENDENT FOCUS PARAMETERS FOR THE BLUR FILTER
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % APPLY CIRCULAR AVERAGE FILTER WITH CHANGING RADIUS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
 end

    