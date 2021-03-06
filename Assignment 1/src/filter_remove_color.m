% FILTER_REMOVE_COLOR(VIDEO, MODE) removes the color information of the current
% frame (video.frame(1).filtered). MODE can be either BW (function returns an RGB
% image where only intensity values are considered) or SEPIA ( function returns
% an RGB image transformed into a yellow-brownish image).
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
% 
%   VIDEO = FILTER_REMOVE_COLOR(VIDEO, MODE) returns the original video structure
%   with the updated current video.frame(1).filtered. Each filter takes
%   video.frame(1).filtered as input and writes the result back to this array.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       To implement the remove color effect (bw) the color channel of the
%       hsv converted image is set to zero.
%
%       For the sepia effect each pixel has to be transformed with a
%       transformation matrix given in the instruction.
%       Instead of the matrix multiplication with a vector, we calculate
%       the dot product of each matrix row with the rgb value and
%       stick the color channels back together.
%       This is done by building a matrix of the size of the image where 
%       each channel holds one element of the row of the transformation
%       matrix. So it is possible to use the dot product along the 3rd dim
%       to calculate all values for one color channel simultaneously            
%       for the whole picture.
%
%   PHYSICAL BACKGROUND:
%       BW: In the past, hobby color photographies were quite rare before the 90s
%       due to expensive technical equipment and material, so it was not an
%       effect, but just the result of the equipment at that time. Nowadays, BW is mostly
%       used as a filter for aestethic reasons; for a lot of computer
%       vision tasks bw only information is sufficient enough (better
%       performance due to less information, etc.)
%
%       Sepia toning was used in the past to enhance black and white
%       photographies and to give them a better warmer tone and to to also enhance its archival qualities.
%       This process was done during the developing of the film with different chemicals.
function [video] = filter_remove_color(video, mode)    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Black / White Mode
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (strcmp(mode,'bw'))                
        video.frame(1).filtered = black_white(video.frame(1).filtered);
        return;
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Sepia Mode
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (strcmp(mode,'sepia'))
        video.frame(1).filtered = sepia(video.frame(1).filtered);
        return;
    end

    disp_error('Only ''bw'' and ''sepia'' mode supported!');




    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % REMOVE COLOUR INFORMATION FROM AN RGB IMAGE
    %
    % 1) CONVERT img FROM RGB TO YCbCr COLORSPACE
    % 2) SET CHROMA CHANNELS APPROPRIATELY (NEUTRAL CHROMA CHANNELS)
    % 3) CONVERT IMAGE BACK TO RGB
    % 4) RETURN 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [bw] = black_white(img)
        hsv= rgb2hsv(img);
        ns= zeros(size(hsv(:,:,1)));
        hsv(:,:,2)= ns;
        bw= hsv2rgb(hsv);
    end
    %%    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CONVERT RGB IMAGE TO SEPIA
    %
    % 1) USE SEPIA CONVERSION MATRIX FOR CONVERTING RGB IMAGE img TO SEPIA
    % 2) RETURN CONVERTED IMAGE 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [sepia] = sepia(img)
        %{
        sepia_mat= [0.4, 0.769, 0.189;
                    0.349, 0.686, 0.168;
                    0.272 0.534, 0.131];
        %}
        
        img_rows= size(img,1);
        img_col= size(img,2);
        
        sepia_r= [0.4, 0.769, 0.189];
        sepia_g= [0.349, 0.686, 0.168];
        sepia_b= [0.272 0.534, 0.131];

        smat_r(1:img_rows,1:img_col,:)= repmat(reshape(sepia_r, [1 1 3]),[img_rows, img_col]);
        smat_g(1:img_rows,1:img_col,:)= repmat(reshape(sepia_g, [1 1 3]),[img_rows, img_col]);
        smat_b(1:img_rows,1:img_col,:)= repmat(reshape(sepia_b, [1 1 3]),[img_rows, img_col]);
        
        res_r= dot(img, smat_r, 3);
        res_g= dot(img, smat_g, 3);
        res_b= dot(img, smat_b, 3);
        
        sepia= cat(3, res_r, res_g, res_b);
    end
end

% imshow(img)
% imshow(result)
