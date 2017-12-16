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
    
    rand_picpos = randperm(size(video.frame(1).filtered,2), nr_of_scratches);
    rand_bright = randi([230 250],1,floor(size(rand_picpos,2)/2));
    rand_dark = randi([50 80],1,floor(size(rand_picpos,2)/2));
    rand_arraypos = randperm(size(rand_picpos,2));
    bcolpos = rand_picpos(rand_arraypos(1:size(rand_arraypos,2)/2));
    dcolpos = rand_picpos(rand_arraypos(size(rand_arraypos,2)/2 + 1:size(rand_arraypos,2)));
    for a = 1 : size(rand_arraypos,2)/2
        if randi([0 1])== 1
        video.frame(1).filtered(:,bcolpos(a),:) = double(rand_dark(a)/intmax('uint8'));
        end
        if randi([0 1])== 1
        video.frame(1).filtered(:,dcolpos(a),:) = double(rand_bright(a)/intmax('uint8'));
        end
    end
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

    