% FILTER_IRIS(VIDEO, PARAM1, ..) achieves an iris effect by overlaying an alpha mask 
% on the current frame video.frame(1). The size of the iris can be defined by using
% appropriate parameters.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame.
%
%   TRANSITION_SIZE:  distance in pixels between iris size and end of
%   transition effect.
%
%   MIN_SIZE:  minimal iris size (percentage of image width).
%
%   MAX_SIZE:  maximal iris size (percentage of image width).
%
%   DIST_X:  horizontal distance in pixels between iris and image center.
%
%   DIST_Y:  vertical distance in pixels between iris and image center.
% 
%   VIDEO = FILTER_UNSHARP(VIDEO, PARAM1, ...) returns the original video structure
%   with the updated current video.frame(1).filtered. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       To compute the distance map the iris position is necessary.
%       This is done by calculating the middle of the picture and adding the       
%       given distance to the iris center.
%       
%       The euclidean distance to the center is then calculated by creating
%       a position map that holds the x,y position of each pixel in a
%       channel. These positions are subtracted (dimension wise) from the position of the
%       iris. The result is squared and then the dimension wise results are
%       summed up and the square rooted.
%
%       After the dist map is computed, the iris outer and inner border are
%       calculated. These values are then used to create the linear
%       interpolation between inner and outer border. This is done by 
%       scaling the value range of inner border - outer border to 0 - 1. 
%       Values beyond 0 and 1 are cut of and the whole matrix is inverted 
%       to create the brightness map.
%
%       After that the image only has to be multiplied with the brightness
%       map.
%   PHYSICAL BACKGROUND:
%       .....
%
%   RANGE VALUES FOR PARAMETERS:
%       transition size: >0 - < (img width/2) - iris outer position
%       min_size: >0 - <1
%       min_size: bigger than min_size - <1
%       dist_x: 0 - < img width /2 -> assuming iris mid should be in img
%       dist_y: 0 - < img width /2 -> assuming iris mid should be in img
%
function video = filter_iris(video, transition_size, min_size, max_size, dist_x, dist_y)

    % computation distance map
    img= video.frame(1).filtered;
    center_x= floor(size(img ,1)/2);
    center_y= floor(size(img ,2)/2);
    iris_x= center_x + dist_x;
    iris_y= center_y + dist_y;
    dist_map= euclidean_dist_map(size(img, 1), size(img, 2), iris_x, iris_y);
    
    % computation iris size
    min_pixel=(size(img ,1)) * min_size;
    max_pixel=(size(img ,1)) * max_size;
    iris_outer= min_pixel + (max_pixel - min_pixel) .* rand(1, 1);
    iris_inner= iris_outer - transition_size;
    
    % computation brightness map
    i_map=(dist_map-iris_inner) ./ (iris_outer - iris_inner);
    i_map(i_map>1)= 1;
    i_map(i_map<0)= 0;
    bright_map= 1 - i_map;
   
    video.frame(1).filtered= img .* repmat(bright_map, [1 1 3]);
end

function dist_map =  euclidean_dist_map(size_x, size_y, iris_x, iris_y)
    pos_mapx= repmat((1:size_x)',[1 size_y]);
    pos_mapy= repmat(1:size_y,[size_x 1]);
    pos_map= cat(3, pos_mapx, pos_mapy);
    
    iris_mapx= ones(size_x, size_y) * iris_x;
    iris_mapy= ones(size_x, size_y) * iris_y;
    iris_map= cat(3, iris_mapx, iris_mapy);
    
    phyt= power(pos_map-iris_map,2);
    dist_map= sqrt(phyt(:,:,1)+phyt(:,:,2));
end