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
%
%
%   PHYSICAL BACKGROUND:
%       .....
%
%   RANGE VALUES FOR PARAMETERS:
%       .....
function video = filter_iris(video, transition_size, min_size, max_size, dist_x, dist_y)
    % TODO: redo function based on given specifications: 
    %       min, max = % of img width
    %       transition_size = pixel

    % computation distance map
    img= video.frame(1).filtered;
    center_x= floor(size(img ,1)/2);
    center_y= floor(size(img ,2)/2);
    iris_x= center_x + dist_x;
    iris_y= center_y + dist_y;
    dist_map= euclidean_dist_map(size(img, 1), size(img, 2), iris_x, iris_y);
    
    % computation iris size
    iris_outer= min_size + (max_size - min_size) .* rand(1, 1);
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
    res= sqrt(phyt(:,:,1)+phyt(:,:,2));
    dist_map= (res - 0) ./ (max(res(:) - 0));
end