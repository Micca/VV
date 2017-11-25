% EFFECT_IRISING_IN_OUT(VIDEO, TRANSITION_SIZE, MIN_SIZE, MAX_SIZE, DIST_X,
% DIST_Y, PARAM1, ..) applies an irising in / out effect on a sequence of images.
% PARAMS1 should control the beginning and the duration of the effect.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   FADES: settings for controlling the beginning and the duration of
%   the effect. An array, where the start position is held in {1..N}{1},
%   the duration of the effect is stored in {1..N}{2}. There are 'N' 
%   fade outs/ins.
%
%   VIDEO = EFFECT_IRISING_IN_OUT(VIDEO, TRANSITION_SIZE, MIN_SIZE, MAX_SIZE, DIST_X,
%   DIST_Y, FADES) returns the original video structure with the updated current
%   video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%   *) Precondition: Only one iris effect at once can be applied to the video.
%
%   First of all, check if the current frame is affected by any iris
%   effect, this can be simply done by comparing the frameNr with the
%   starting frameNr of the effect.
%   Then, split the duration into two parts. From start to middle, we want
%   our factor to get from 1 to 0 OR if the frame is already after the 
%   middle, the factor should be 0 to 1. This can be easily done by
%   computing the values to an interval of [0,1]. If the duration count is
%   odd, we have to use a ceil function to get rid of the decimal problem. 
%   
%   With the factor which is now in the desired interval, we can multiply
%   the min/max_size parameter and apply the filter_iris function from
%   exercise1. The factor can also be used to compute another target
%   function, instead of linear interpolation, in our case we use the sine
%   function, but we need to multiply the factor by pi/2 to get into the
%   right "space".
%   
%   USE OF THE EFFECT:
%   To apply the effect on the video, use a struct (as discussed in the description)
%   where the first element is the starting effect position and the second frame the duration of the
%   effect. e.g. {{10, 20}, {40,20}}. Multiple in/out effects must not
%   interfere with each other, i.e. only one iris effect can be use at
%   once.
% 
function video = effect_irising_in_out(video, transition_size, min_size, max_size, dist_x, dist_y, fades)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CHECK IF THE FRAMES WE WANT TO WORK ON ARE AVAILABLE IN QUEUE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (video.frame(1).frame_nr == -1)    
        return; 
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE THE FILTER AT THE FIRST CALL
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (~isfield(video, 'effect_irising_in_out'))
        video.effect_irising_in_out.iris_size = rand(1) * [max_size - min_size] + min_size;                   % iris size

        for i = 1:numel(fades)
            pos(i)       = fades{i}{1};         
            duration(i)  = fades{i}{2};
        end

        video.effect_irising_in_out.pos_start = pos;
        video.effect_irising_in_out.duration  = duration;    
        video.effect_irising_in_out.pos_end   = pos+duration-1;
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GET THE IRISING PARAMETERS FOR THE CURRENT FRAME 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    factor = -1; % Init factor
    frameNr = video.frame(1).frame_nr;
    % Loop through all iris effects and run until one is in range.
    for i = 1:numel(fades)
        
        current_iris_pos_start = video.effect_irising_in_out.pos_start(i);
        current_iris_pos_end = video.effect_irising_in_out.pos_end(i);
        current_iris_duration = video.effect_irising_in_out.duration(i);
        
        % Check if frame is affected by effect.
        if(current_iris_pos_start <= frameNr &&  frameNr <= current_iris_pos_end)
            % Check if IN or OUT effect by splitting it up into two halfes.
            % If the duration is odd, use ceil to get rid of decimal
            % problem.
            mid = current_iris_pos_start + ceil(current_iris_duration/2) - 1;
            
            if(frameNr <= mid)
               %IN - 
               % Normalize current value.
               factor = (frameNr - current_iris_pos_start) / ( mid - current_iris_pos_start );
               % We want to decrease the value, so we have to flip it.
               factor = (1 - factor);
            else
               %OUT
               % Normalize current value.
               factor = (frameNr - mid) / ( current_iris_pos_end - mid );
            end
            
            % After these step, we have the linear interpolation values.
            % Now we can apply any function, e.g. sinus, but we have to
            % take care about the right values of course.
          
            % Apply sinus interpolation
            factor = sin(factor * pi/2);
            break;
        end
    end
    
    % If factor is -1, then no iris effect should be applied.
    if(factor == -1)
    return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % APPLY IRIS FILTER WITH IRISING PARAMETERS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Multiply the parameters which affects the effect by the factor.
    % Be aware that, applying the factor also on the
    % transition_size could lead to edge cases where the iris has
    % outliers, so one element could increase/decrease instead of desired
    % effect. 
    min_size = min_size * factor;
    max_size = max_size * factor;
    
    video = filter_iris(video, transition_size, min_size, max_size, dist_x, dist_y);