% EXERCISE2 applies filters of excercise 2 on image sequence.
%
%   EXERCISE2(INPUT_DIRECTORY, OUTPUT_DIRECTORY) reads all files in
%   the INPUT_DIRECTORIES with the name frameXXXX.png and applies the 
%   implemented filters on these images. The finally processed frames 
%   are stored in OUTPUT_DIRECTORY.
%
%   EXERCISE2({INPUT_DIRECTORY1, INPUT_DIRECTORY2}, OUTPUT_DIRECTORY) reads
%   first all files in the INPUT_DIRECTORY1 and then all files in the
%   INPUT_DIRECTORY2 with the name frameXXXX.png and applies the 
%   implemented filters on these images. The finally processed frames 
%   are stored in OUTPUT_DIRECTORY.
%
%   EXERCISE2(INPUT_DIRECTORY, OUTPUT_DIRECTORY, START_FRAME, END_FRAME) only
%   processes the images from START_FRAME to END_FRAME.
%
% Example 1:
%   EXERCISE2('../images', '../output') processes all images frameXXXX.png in 
%   '../images' and stores the output in '../output'.
%
% Example 2:
%   EXERCISE2('../images', '../output', 1, 25) processes only frames 1 to 25.
%
% Example 3:
%   EXERCISE2({'../images1','../images2'}, '../output') reads all images from
%   2 input directories '../images1' and '../images2' (in this order) and 
%   applies the filters on all images.
function exercise2(input_directory, output_directory, start_frame, end_frame)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SETTINGS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    show = 1;   % show original and final frame output
    close all;  % close all figures
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE VIDEO STRUCTURE AND FILTERS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    video.BUFFER_FRAMES     = 3;            % last X frames are buffered for temporal filters (frame(1) is current frame, frame(2) previous frame, ...)
    video.frame             = [];           % initialize frame buffer
    video.output_directory  = output_directory;
    for i = 1:1:video.BUFFER_FRAMES
        video.frame(i).original             = [];     % original frame content as RGB data (H x W x 3), this array is NOT modified by any filter!
        video.frame(i).filtered             = [];     % filtered frame content as RGB data (H x W x 3), all filters use this array as input and output
        video.frame(i).original_frame_nr    = -1;     % frame number of this frame in the input directory (is not modified by any buffer!)
        video.frame(i).frame_nr             = -1;     % frame number of this frame (can change if frames are inserted/removed by a filter)
        video.frame(i).scene                =  1;     % scene number (always 1 except told otherwise by our scene detection)  
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % READ ALL THE FILE NAMES IN A FOLDER ENDING ON .png 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    video.input_files = [];
    if (iscell(input_directory) == 0)
        % single input directory  
        add_list      = dir([input_directory '/*.png']); 
        for j = 1:numel(add_list)
            video.input_files(end+1).name             = [input_directory '/' add_list(j).name];
            video.input_files(end).frame_nr  = numel(video.input_files);
        end
    else
        % multiple input directories
        video.input_files = [];
        for i = 1:numel(input_directory)
            add_list      = dir([input_directory{i} '/*.png']); 
            for j = 1:numel(add_list)
                video.input_files(end+1).name = [input_directory{i} '/' add_list(j).name];
            end
        end    
    end
    
    if (numel(video.input_files) == 0)
        disp('No image files found in input directory.')
        return;
    end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CREATE OUTPUT DIRECTORY
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    warning off;
    if(~mkdir([video.output_directory])) 
        disp(['Cannot create output directory [' video.output_directory ']']);
        return;
    end
    warning on;
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % OPTIONAL PARAMETERS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (~exist('start_frame'))
        video.start_frame   = 1;
    else
        video.start_frame   = min(numel(video.input_files), start_frame);        
    end
    
    if (~exist('end_frame'))
        video.end_frame     = numel(video.input_files);
    else
        video.end_frame     = min(numel(video.input_files), end_frame);
    end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % APPLY ALL FILTERS THAT ALTER THE FRAME NUMBER/ORDER (EXERCISE 2)  
    % OR REQUIRE THE UNFILTERED IMAGE CONTENT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     video = effect_add_text(video, {{'../text/scene_text1.png', 1, 5}, {'../text/scene_text1.png', 3, 3}});  % add text frames at position X1 in original input files, text is displayed for Y1 frames
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % START FRAME PROCESSING
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for frame_counter = video.start_frame:1:video.end_frame + video.BUFFER_FRAMES
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % SHIFT FRAME BUFFER
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (video.BUFFER_FRAMES > 1)
            video.frame(2:end) = video.frame(1:end-1);
        end        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % READ IN NEXT FRAME
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (frame_counter <= video.end_frame)
            video.frame(1).original      = double(imread(video.input_files(frame_counter).name))./255;  % ORIGINAL IMAGE DATA -> NOT MODIFIED BY ANY FILTER
            video.frame(1).filtered             = video.frame(1).original;                        % EACH FILTER USES THIS ARRAY AS INPUT AND FOR STORING ITS RESULTS 
            video.frame(1).original_frame_nr    = frame_counter;     
            video.frame(1).frame_nr             = frame_counter;                                                       
            video.frame(1).scene                = 1;            
            disp(sprintf('Adding frame [%d] to filter queue', video.frame(1).frame_nr));                        
        else
            % Here we flush the buffer after all files in the input list have been processed - not further frames are read in 
            video.frame(1).original             = [];
            video.frame(1).filtered             = [];
            video.frame(1).original_frame_nr    = -1;     
            video.frame(1).frame_nr             = -1;
            video.frame(1).scene                = 1;            
        end        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % APPLY BASIC FILTERS (EXERCISE 1)
        % These filters only work on the current frame 1 
        % in the queue and are applied to every frame
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (video.frame(1).frame_nr ~= -1) 
%             video      = filter_remove_color(video, 'bw');          % 
%             video      = filter_unsharp(video, 3, 3);                  % 
%             video      = filter_rand_illumination(video, 0.7, 0.8);    % 
%             video      = filter_highcontrast(video, 0.3, 0.2);         % 
%             video      = filter_iris(video, 100, 0.8, 0.85, 0, 0);     % 
%             video      = effect_irising_in_out(video, 100, 0.6, 0.65, 0, 0, {{720, 20}, {740,20}});            %
%             video      = filter_low_framerate(video, 25, 19);          % 

        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % APPLY SPECIAL EFFECTS (EXERCISE 2)
        % These filters work on multiple frames and use
        % information from the whole frame queue
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %video = effect_soft_focus(video,720,0.5,25); %, {{1, 8}, ...           % at frame X1 apply soft focus for Y1 frames
        %                                  {100, 10}});          % at frame X2 apply soft focus for Y2 frames
        video = effect_fast_motion(video, {{1, 10, 8}, ...         % at frame X1 reduce the next Y1 frames to Z1 frames (randomly remove)
                                          {22, 25, 10}});        % at frame X2 reduce the next Y2 frames to Z2 frames (randomly remove) 

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % STORE FRAMES AT THE END OF PROCESSING BUFFER
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (video.frame(end).frame_nr ~= -1) 

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % SHOW ORIGINAL AND FINAL FRAME
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if (show == 1)
                figure(1);                
                subplot(2,1,1);                
                imshow(video.frame(end).original);            
                title(sprintf('Input frame %d', video.frame(end).frame_nr));
                subplot(2,1,2);
                imshow(video.frame(end).filtered);
                title(sprintf('Output frame %d', video.frame(end).frame_nr));
            end
            
            frame_number = int2str(video.frame(end).frame_nr); 
            frame_str    = '00000';  frame_str(end-numel(frame_number)+1:end) = frame_number;      
            warning off;
            imwrite(video.frame(end).filtered, sprintf('%s/frame%s_scene%d.png', video.output_directory, frame_str, video.frame(end).scene));
            warning on;
            disp(sprintf('Storing frame [%d]', video.frame(end).frame_nr));                        
        end        
                
    end

end
