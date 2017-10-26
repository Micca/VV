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
%       .....
%
%   PHYSICAL BACKGROUND:
%       .....
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
                   

    end
    %%    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CONVERT RGB IMAGE TO SEPIA
    %
    % 1) USE SEPIA CONVERSION MATRIX FOR CONVERTING RGB IMAGE img TO SEPIA
    % 2) RETURN CONVERTED IMAGE 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [sepia] = sepia(img)

        
    end
end


