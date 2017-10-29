% FILTER_HIGHCONTRAST(VIDEO, DX, DY) increases the contrast of the current
% frame (video.frame(1).filtered) by moving the intensity values v of the image 
% towards 0 and 1 using a mapping functions f(v).
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   DX/DY:  settings for constructing the mapping function f(v) 
%
%   VIDEO = FILTER_HIGHCONTRAST(VIDEO, DX, DY) returns the original video 
%   structure with the updated current video.frame(1).filtered. Each filter
%   takes video.frame(1).filtered as input and writes the result back to this
%   array.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       A function is implemented to calculate the step function on a 2D
%       picture. To do this the slope and the y-intercept is calculated for
%       all three parts of the step function and all three linear equations
%       are used to define the transfer function.
%       As the image is given in 0-1 range it is converted into the HSV
%       color space and the value is given to the transfer function to
%       increase the contrast.
%       After the transformation it is transformed back into RGB.       
%       Picture stays in 0-1 range (contrary to excercise description) as
%       it is given from the video object in the format!
%
%   PHYSICAL BACKGROUND:
%       .....
%
%   RANGE VALUES FOR PARAMETERS:
%       0 < dx, dy < 0.5
%       Both dx,dy= 0 and dx,dy= 0.5 have no effect on the image at all.
%       Both values lead to a linear mapping that does not change values at
%       all.
%
%       Dx defines the range of light and dark values that are changed
%       (bigger dx - bigger range of change).
%       Dy defines how much they are changed (smaller dy - bigger change.
function video = filter_highcontrast(video, dx, dy)
    img_hsv= rgb2hsv(video.frame(1).filtered);
    img_intensity3= intFunction(img_hsv(:,:,3), dx, dy);
    img_nhsv= cat(3, img_hsv(:,:,1), img_hsv(:,:,2), img_intensity3);
    video.frame(1).filtered= hsv2rgb(img_nhsv);
end

function result = intFunction(img, dx, dy)
    imgx0= ones(size(img,1),size(img,2)) * dx;
    imgx1= ones(size(img,1),size(img,2)) * (1-dx);
    imgy0= ones(size(img,1),size(img,2)) * dy;
    imgy1= ones(size(img,1),size(img,2)) * (1-dy);
    
    imgx0(img < dx)= 0;
    imgx1(img < dx)= dx;
    imgy0(img < dx)= 0;
    imgy1(img < dx)= dy;
    
    imgx0(img > 1-dx)= 1-dx;
    imgx1(img > 1-dx)= 1;
    imgy0(img > 1-dx)= 1-dy;
    imgy1(img > 1-dx)= 1;
    
    m= (imgy1 - imgy0) ./ (imgx1 - imgx0);
    d= imgy0 - (m .* imgx0);
    result= m .* img + d;
end