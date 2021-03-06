% DISTORTION_VINEGAR(VIDEO, NR_OF_BLOBS) adds nr_of_blobs white randomly
% growing regions to an existing frame in VIDEO.FRAME(1).FILTERED. 
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
%       The vinegar blobs are implemented by first calculating random seed
%       point for each blob that are uniformly distributed. After that the
%       seed points are grown to blobs on the alpha map. The random blob function
%       calculates random uniform distributed movement for the size of the
%       blob. The blob tries to grow to positions it are not already
%       occupied by only accepting random movement onto new positions. If
%       all positions around it are already used the algorithm allows the
%       blob to move onto an occupied position to escape the enclosure.
%       After that the alpha map is blurred with a gaussian filter and is
%       used to blend the original image with a white image (by interpolation).
%   
%   PHYSICAL BACKGROUND:
%       Vinegar damage on films is caused by poor storage of films.
%       As old film roles are on cellulose acetate, they degrade with 
%       exposure to moisture, heat or acids. The deterioration starts with 
%       the typical vinegar smell and spots on the film. Advanced stages 
%       of deterioration then make the film brittle and let the film shrink
%       making the film unusable for showing, as the film would shatter
%       with the slightest tension.
%
function video = distortion_vinegar(video, number_of_blobs, max_blob_size)

    if(video.frame(1).frame_nr == -1)
        return
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate alpha map 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    alpha_map = zeros(size(video.frame(1).filtered, 1), size(video.frame(1).filtered, 2));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate the seed points of the regions randomly
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand_xpos = randi([1 size(video.frame(1).filtered, 1)], 1, number_of_blobs);
    rand_ypos = randi([1 size(video.frame(1).filtered, 2)], 1, number_of_blobs);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %generate seed points
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %generate a new blob
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for a = 1 : number_of_blobs
        alpha_map = generateblob(alpha_map, rand_xpos(a), rand_ypos(a), max_blob_size);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Apply unsharpen filter on alhpa map
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fsize=[15 15];
    gauss_kernel= fspecial('gaussian', fsize, 3);
    blurred_map= imfilter(alpha_map, gauss_kernel);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Alpha-Blending between alpha map and 'white' image
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    video.frame(1).filtered = (1-blurred_map) .* video.frame(1).filtered + blurred_map .* ones(size(video.frame(1).filtered));
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for generating a new blob
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function map = generateblob(map, x, y, max_blob_size)

% if x y are valid position -> set them and go into for loop

if map(x, y) == 0
    map(x, y) = 1;
    valid_x = x;
    valid_y = y;
    for i = 2 : max_blob_size
        valid_move = false;
        % calc random all random movements
        rand_move = randi([1 4], 1, max_blob_size);
        index = 1;
        while ~valid_move
            if index > size(rand_move,2)
                rand_move = randi([1 4], 1, max_blob_size);
                index = 1;
                valid_move = true;
            end
        
            dir_vec = getDirection(rand_move(index));
            new_x = valid_x + dir_vec(1);
            new_y = valid_y + dir_vec(2);
            if new_x > 0 && new_x < size(map,1) && new_y > 0 && new_y < size(map,2)
                if map(new_x, new_y) == 0 
                    valid_move = true;
                    map(new_x, new_y) = 1;
                    valid_x = new_x;
                    valid_y = new_y;
                end
            end
            index = index + 1;
        end
    end
end

end

function dir = getDirection(number)
    if number == 1
        dir = [0 -1];
    elseif number == 2
        dir = [1 0];
    elseif number == 3
        dir = [0 1];
    elseif number == 4
        dir = [-1 0];
    end
end