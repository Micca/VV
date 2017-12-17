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
%       Initializing the map with zero values, each frame we add a random
%       pixel with a 50% probability, further we create disk as a
%       structural element which will be applied with imdilate to apply a
%       morphological operation (in other words, we just let the burn holes
%       in our burn_map grow), then the burn_map will be inverted and a
%       gaussian filter will be applied to round the corners of the disks
%       which are the result of the morphological operation. Then, we use
%       alpha blending (multiply every color channel with the burn map) and
%       we finally get our result.
%   
%   PHYSICAL BACKGROUND:
%       Very old film projectors often used a candle as the light source,
%       which was quite dangerous if the candle fire was put very closely
%       to the film itself, this was actually necessary to get good
%       projector results (sharp video etc.)
function video = distortion_burn(video, start_frame)
    
    if ((video.frame(1).frame_nr == -1)   || (video.frame(1).frame_nr < start_frame)) 
        return; 
    end
    
    % width/height of the current frame
    y_size = size(video.frame(1).original, 1);
    x_size = size(video.frame(1).original, 2);  
        
    if (~isfield(video, 'distortion_burn'))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize burn map
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    video.distortion_burn.counter = 0;
    video.distortion_burn.burn_map = zeros(y_size, x_size);               
    end
    
    %video.distortion_burn.counter = video.distortion_burn.counter + 0.15;
    
    % 50% probability that a pixel will be generated
    p = randperm(2,1);
    if(p == 1)
        % get random pixel and set it in the burn_map
        x_rand = randsample(1:x_size, 1);
        y_rand = randsample(1:y_size, 1);
        video.distortion_burn.burn_map(y_rand, x_rand) = 1;
    end

    %% Apply morphological operation to extend the "burning holes".
        
    % Use disk as structing element
    se = strel('disk', 5);
    % Use imdilate to apply the morphological operation on the frame.
    video.distortion_burn.burn_map = imdilate(video.distortion_burn.burn_map,se);
        
    %% Take the complement of the burn_map to use it for alpha blending and unsharp image with guassian filter.
    burn_map = imcomplement(video.distortion_burn.burn_map);
    sizeG = 20;
    gauss_kernel= fspecial('gaussian', [sizeG sizeG], 200);
    burn_map = imfilter(burn_map, gauss_kernel);
    %% Perform alpha blending to apply burning wholes on the current video frame
    
    red = video.frame(1).filtered(:,:,1) .* burn_map;
    green = video.frame(1).filtered(:,:,2) .* burn_map;
    blue = video.frame(1).filtered(:,:,3) .* burn_map; 
  
    video.frame(1).filtered = cat(3, red, green, blue);
end
