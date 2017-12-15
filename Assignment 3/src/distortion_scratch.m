% DISTORTION_SCRATCH(VIDEO, NR_OF_SCRATCHES) adds less or equal
% NR_OF_SCRATCHES black and white vertical scratches to an existing frame
% in VIDEO.FRAME(1).FILTERED.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
%
%   VIDEO = DISTORTION_SCRATCH(VIDEO, NR_OF_SCRATCHES) returns the original video structure
%   with the updated current video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTIERUNG:
%   	.....
%   
%   
%   PHYSIKALISCHER HINTERGRUND:
%       .....
function video = distortion_scratch(video,nr_of_scratches)


    if(video.frame(1).frame_nr == -1)
        return
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate a maximum of nr_of_scratches 
    % scratches randomly on the whole image. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate half of nr_of scratches dark and half of
    % them bright intensities and apply them on the
    % intensity image. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    