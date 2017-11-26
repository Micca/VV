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
%       First of all we check if there is a frame which is affected by this
%       effect, if so, then we easily compute a scaled factor between [0,1] based on
%       the distance to the starting point. We use this linear factor to successively
%       reduce the blur_factor. At the end, we multiply the factor *
%       blur_factor for unsharping the image and call the filter_unsharp
%       function from exercise 1 to unsharp the image.
%  
%   USE OF THE EFFECT:
%       The blur_factor corresponds to the sigma value for the gaussian
%       filter, the higher the blur_factor, the more unsharp the starting
%       image will be. To achieve a smooth interpolation also consider
%       taking multiple frames into account for that effect.
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
    factor = -1; % Init factor
    frameNr = video.frame(1).frame_nr;
    % Loop through all iris effects and run until one is in range.
    for i = 1:numel(focus)
        
        current_soft_focus_pos_start = video.effect_soft_focus.pos_start(i);
        current_soft_focus_end = video.effect_soft_focus.pos_end(i);
        current_soft_focus_duration = video.effect_soft_focus.duration(i);
        
        % Check if frame is affected by effect.
        if(current_soft_focus_pos_start <= frameNr &&  frameNr <= current_soft_focus_end)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % GET THE FRAME DEPENDENT FOCUS PARAMETERS FOR THE BLUR FILTER
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            factor = (frameNr - current_soft_focus_pos_start) / ( current_soft_focus_duration );
            % We want to decrease the value, so we have to flip it.
            factor = (1 - factor);
            break;
        end
    end
    % If factor is -1, then no iris effect should be applied.
    if(factor == -1 || factor == 0)
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % APPLY CIRCULAR AVERAGE FILTER WITH CHANGING RADIUS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    video = filter_unsharp(video, blur_factor * factor, 120);
        
 end

    