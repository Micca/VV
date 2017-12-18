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
%       Each frame a random number of scratches up to the variable is
%       applied to the frame. This is done by calculating a random position
%       for each scratch, and assigning them randomly however evenly to the 
%       dark or bright scratch array. Each scratch has also a random color 
%       based on a range ([200 - 230] for bright, [50 - 80] for dark). After
%       the positions and colors are computed they have a probability of
%       50% to be drawn or not. Each scratch is drawn by setting a collumn
%       of the picture to the calculated value. The value is divided by 255 
%       to convert uint8 values to double. 
%   
%   PHYSIKALISCHER HINTERGRUND:
%       Old movie films often get deteriorated with scratches due to 
%       mechanical contact with the film projector. 
%       This can happen due to film slippage during fast start, stops and
%       rewinding, therfore scratching the film with accumulated dirt particles.
%       Scratches often appear consecutively in several frames at similar 
%       horizontal locations. Because the scratches spread over many frames
%       and appear at same locations during projection, this kind of film
%       damate is readily seen by the viewer.
%
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

    