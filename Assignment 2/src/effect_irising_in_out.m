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
%       .....   
%   
%   USE OF THE EFFECT:
%       .....
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


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % APPLY IRIS FILTER WITH IRISING PARAMETERS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
