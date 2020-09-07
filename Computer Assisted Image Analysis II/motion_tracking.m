
% Specify Video to be read in
video_in = 'source_sequence.avi';
% Initialize Video Reader
utilities.videoReader = VideoReader(video_in);

% Specify name for output video
video_out = 'Tracks.avi';
% Initialize Video writer
utilities.videoFWriter = vision.VideoFileWriter('video_out.avi','FrameRate',30);

% Compress the output video as it will be very big if you don't. The
% compression options depend on your operating system, so maybe you will
% need to use the following instead of the current settings:
% utilities.videoFWriter.VideoCompressor='DV Video Encoder';
% for further details see:
% https://se.mathworks.com/help/vision/ref/vision.videofilewriter-system-object.html
utilities.videoFWriter.VideoCompressor='DV Video Encoder';

% Initialize video player if you want to watch video with tracking results
% while running the code (will slow down code significantly of course)
utilities.videoPlayer=vision.VideoPlayer('Position',[100,100,500,400]);


% Get number of frames
N_frames=utilities.videoReader.NumberOfFrames;

bwmask = imread('bwmask.png');

%calculate mean image
m = double(read(utilities.videoReader, 1));
nframes = 40;
for i=2:nframes
    frame = double(read(utilities.videoReader,i));
    m = m + frame;end

m = double(m) / double(nframes);


frame = read(utilities.videoReader,i);
frame_gray = rgb2gray(frame);
frame_gray = medfilt2(frame_gray);

bw = im2bw(frame_gray, 0.5);
bw = ~bw;
%finetuning
bw = imopen(bw, strel('rectangle', [3,3]));
bw = imclose(bw, strel('rectangle', [15, 15]));

bw = imfill(bw, 'holes');
blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', true, 'CentroidOutputPort', true, ...
    'MinimumBlobArea', 50);

[~, centroids_ref, bboxes_ref] = blobAnalyser(bw);
c_y_ref = centroids_ref(:,2);
c_x_ref = centroids_ref(:,1);

% Loop through frames
for i=1:N_frames
    % Read in next frame
    frame = read(utilities.videoReader,i);
    frame_gray = rgb2gray(frame);
    frame_gray = medfilt2(frame_gray);
    %remove the mean background
    %foreground = double(frame) - double(m);
    
    
    % Process frame
    %binarize image
    bw = im2bw(frame_gray, 0.5);
    bw = ~bw;
    %finetuning
    bw = imopen(bw, strel('rectangle', [3,3]));
    bw = imclose(bw, strel('rectangle', [15, 15]));
    
    bw = imfill(bw, 'holes');
    
    imshow(bw)
    blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
        'AreaOutputPort', true, 'CentroidOutputPort', true, ...
        'MinimumBlobArea', 50);
    
    [~, centroids, bboxes] = blobAnalyser(bw);
    
    
    % here we have three points wandering through the video, such that you
    % can see how you can do the annotations in the video
    trackedLocation=[1+i,1; 2,2+i; 3+i,3+i];
    
    % mark the position in every tenth frame for example
    %if mod(i,10)
    if ~isempty(bboxes)
        shape = 'rectangle';
        region = bboxes;
        region(:, 3) = 5;
        label=1:1:length(bboxes(:,1));
        %calculate costs
        c_y = centroids(2);
        c_x = centroids(1);
        C = zeros(size(centroids).^2);
        for k = 1:length(c_y_ref)
            C(k,:) = vecnorm([c_x_ref(k)-c_x; c_y_ref(k)-c_y],2,1)';
        end
        M = matchpairs(C,1);
       
        %nc(:,1) = [c_x(M(:,2)); ...
        %            c_x_ref(M(:,1))];
        %nc(:,2) = [c_y(M(:,2)); ...
        %            c_y_ref(M(:,1))];
        
        combinedImage = insertObjectAnnotation(frame,shape,...
            region, label, 'Color', 'red');
        %end
    end
    
    % Take a step in playing the video with tracks if you want to watch it
    % while running the code
    
    step(utilities.videoPlayer, combinedImage);
    step(utilities.videoFWriter,combinedImage);
    
end


% Release and close all video related objects
release(utilities.videoPlayer);
release(utilities.videoFWriter);


