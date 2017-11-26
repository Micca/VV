% EFFECT_ADD_TEXT(VIDEO, TEXT) adds additional images to the input image list. 
% This can be used for adding images with text description of the next scene.
% 
%   VIDEO:  a structure containing an array of frames where frame(1)
%           contains the most current frame. 
%
%   TEXT:   is a cell array containing 3 entires. The
%           i-th cell array has the format:
%
%     text{i}{1} = Name of image file containing the scene text
%
%     text{i}{2} = Number of the input file where we want to add the additional
%                  images. e.g. 1 -> text images are inserted before the 
%                  first input image
%
%     text{i}{3} = Duration of the text scene. 
%
%
% Example:
%     >> effect_add_text(video, {{'../text/scene_text1.png', 1, 5}});
%
%     adds the image in file '../text/scene_text1.png' before input image 1
%     and displays it for 5 frames. 
%
%     Original image order (Ix is the x-th input frame):
%
%       I1, I2, I3, I4, .... 
%
%     New image order (Tx is the image added for the x-th text insertion):
%
%       T1, T1, T1, T1, T1, I1, I2, I3, I4, ...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   IMPLEMENTATION:
%       Text images are added into the input_file struct sequentially.
%       First, the data is read out of the cell array, based on that
%       an array of repeating text frames is construced.
%       Secondly, the position of the frame is found by using the matlab function
%       find. Then the data that would be overwritten by the insertion is
%       saved.
%       Lastly, all arrays are put back together, and the end_frame of the 
%       video is modified to accomodate for the new frames.
%       
%   USE OF THE EFFECT:
%       Silent films popularized the use of onscreen intertiles.
%       As motion pictures increased in length they were helpfull to
%       narrate key story points. This effect can be used in the same way
%       by narrating the story, presenting key dialogue or comment on the
%       action on screen.
%
%       To apply the effect on the video, use a struct (as discussed in the description)
%       where the first is the path to the image.
%
%       The second variable defines the frame position where the text image 
%       sequence should be inserted. This parameter should be in between 
%       the start and end frame of the video. 
%
%       The third variable is the duration of the text insertion in frames,
%       that value should be >0 and an integer.
%
%       When a user adds multiple text images onto the same frame they are
%       inserted in the order they were added to the cell array. 
function video = effect_add_text(video, text)
    
    new_input = video.input_files;
    added_frames = 0;
    for a = 1:length(text)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get positions/durations of text scenes
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        imgPath = cell2mat(text{1,a}(1));
        insertPos = cell2mat(text{1,a}(2));
        duration = cell2mat(text{1,a}(3));
        
        % create insertion data
        insert.name = imgPath;
        insert.frame_nr = insertPos;
        insertArray = repmat(insert, [duration, 1]);
        
        % find insertion position
        newPos= find([new_input.frame_nr] == insertPos);
        if newPos <= video.end_frame
            added_frames = added_frames + duration;
        end
        if ~isempty(newPos)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Insert entries into video.input_files array
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            shiftArray = new_input(newPos:end);
            new_input(newPos:newPos + duration - 1) = insertArray;
            new_input(newPos + duration : newPos + duration + length(shiftArray) - 1) = shiftArray;
        end
    end

    video.input_files = new_input;
    video.end_frame = video.end_frame + added_frames;
end