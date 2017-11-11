% convert_images_to_video extracts the images of a video frame by frame.
%
%   convert_images_to_video(INPUT_DIRECTORY, OUTPUT_FILE) combines all frames in
%   the input directory to a video with a frame rate of 25.
%
%   convert_images_to_video(INPUT_DIRECTORY, OUTPUT_FILE, FRAME_RATE)
%   manually defines the frame rate for the output video.

function convert_images_to_video(input_directory, output_file, frame_rate)
    if (~exist('frame_rate'))
        frame_rate     = 25;
    end
    
    add_list = dir([input_directory '\*.png']);
    outputVideo = VideoWriter(fullfile(output_file));
    outputVideo.FrameRate = frame_rate;
    open(outputVideo);
    for i = 1:numel(add_list)
        name = [input_directory '/' add_list(i).name];
        img = imread(name);
        writeVideo(outputVideo,img);
    end
    close(outputVideo);
end