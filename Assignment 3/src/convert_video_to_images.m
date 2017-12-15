% convert_video_to_images extracts the images of a video frame by frame.
%
%   convert_video_to_images(INPUT_FILE, OUTPUT_DIRECTORY) extracts all frames of the
%   input file and saves them in the output directory.
%
%   convert_video_to_images(INPUT_FILE, OUTPUT_DIRECTORY, START_FRAME, END_FRAME) only
%   extracts the frames between START_FRAME to END_FRAME.

function convert_video_to_images(input_file, output_directory, start_frame, end_frame)
    if (~exist('start_frame'))
        start_frame   = 1;  
    end
    
    if (~exist('end_frame'))
        end_frame     = -1;
    end
    
    shuttleVideo = VideoReader(input_file);
    i = 1;

    while hasFrame(shuttleVideo) && ((i <= end_frame) || (end_frame < 0))
       img = readFrame(shuttleVideo);
       if i >= start_frame
            filename = [sprintf('%04d',i) '.png'];
            fullname = fullfile(output_directory, filename);
            imwrite(img,fullname);
       end
       i = i+1;
    end
end