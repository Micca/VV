% DISTORTION_FILM_BURN(VIDEO, START_FRAME) adds burn holes to an existing
% frame in VIDEO.FRAME(1).FILTERED.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
%
%   VIDEO = DISTORTION_SCRATCH(VIDEO, NR_OF_SCRATCHES) returns the original video structure
%   with the updated current video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       .....
%   
%   PHYSICAL BACKGROUND:
%       .....
function video = distortion_burn(video, start_frame)
    
    if ((video.frame(1).frame_nr == -1)   || (video.frame(1).frame_nr < start_frame)) 
        return; 
    end
    
    if (~isfield(video, 'distortion_burn'))
        video.distortion_burn.burn_map = zeros(size(video.frame(1).original, 1), size(video.frame(1).original, 2));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize burn map
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
end
