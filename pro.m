clear
clc



size1=100;
size2=100;
vid = videoinput('winvideo',1, 'MJPG_1280x720');

 while(size1<=100 && size2<=100)
%vid = videoinput('winvideo',1, 'MJPG_1280x720');
%preview(vid);
  vid1 = vid;
  num_frames=2;
  triggerconfig(vid, 'Manual');
  set(vid,'FramesPerTrigger',num_frames);
 
  frame = getsnapshot(vid);
  
[aa,bb,cc,dd]=size(frame);
 binarization_threshold = 6;
NumberOfFrames=dd;
nFrames = NumberOfFrames;
FrameRate=5;
rate = FrameRate;
rate;

image=frame;

%using first
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,image); %step between 2 levels at specified time
[rr,kk]=size(BB);
   if (rr~=1)
        continue
   end;
face=imcrop(image,BB);
 figure,
 imshow(face);
 size1 = size(face,1);
 size2 = size(face,2);
 end;
 
load chirp.mat;
sound(y);
   

% % % %.Cutting
j = int64(.23*size1);
l = int64(.15*size2);
length = int64(.68*size2);
height = int64(.25*size1);
Eyes = imcrop(face,[l,j,length,height]);
figure,imshow(Eyes);

% % % 
% % % %..........Working........
Eyes = rgb2ycbcr(Eyes);
Eyes = rgb2gray(Eyes);
figure,imshow(Eyes);
val1  = min(Eyes(:));
val1;
counter1=0;

for i = 1:size(Eyes,1)
    for j = 1:size(Eyes,2)
        if Eyes(i,j) <= val1+binarization_threshold;
            Eyes(i,j) = 0;
            counter1=counter1+1;
        else
            Eyes(i,j) = 255;
        end
    end
end
% % % 
figure,imshow(Eyes);
% % % %counter1
% % % 
% % % %-----------------
eyespercentage = (counter1*100)/(size(Eyes,1)*size(Eyes,2));

% % % %------------------------

% % % %---o--------
thresholdnumberofframes = 25;
initial=2;
final = 2;
counter = 0;
thresholdpercentage =6;



NumberOfFrames=num_frames;

prolong=0;

while(1)
   
start(vid1);
 trigger(vid1);

 [data1,time1] = getdata(vid1,num_frames);
% array2(NumberOfFrames) = zeros;
% array3(int64(NumberOfFrames/15)) = zeros;
for t = 1:2:NumberOfFrames
    
    image = data1(:,:,:,t);
    %figure,imshow(image);
    FDetect = vision.CascadeObjectDetector;
   
 
    BB1 = step(FDetect,image);
    bitlevel1=1;
   % bitlevel2=1;
   [tt,gg]=size(BB1);
   if (tt~=1)
        continue
   end;
   
    if size(BB1,1)~= 0 && size(BB1,2) ~= 0
%          if( size(BB1,1)==(2*4))
%         return
%         end;
        face=imcrop(image,BB1);
        size1 = size(face,1);
        size2 = size(face,2);
      %  figure,imshow(face);
        
        j = int64(.23*size1);
        l = int64(.15*size2);
        length = int64(.68*size2);
        height = int64(.25*size1);
        Eyes = imcrop(face,[l,j,length,height]);
        
        
        %figure,imshow(mouth);

        Eyes = rgb2ycbcr(Eyes);
        Eyes = rgb2gray(Eyes);
        val1  = min(Eyes(:));
        val1;
        counter1=0;
        for i = 1:size(Eyes,1)
            for j = 1:size(Eyes,2)
                if Eyes(i,j) <= val1+binarization_threshold
                    Eyes(i,j) = 0;
                    counter1=counter1+1;
                else
                    Eyes(i,j) = 255;
                end
            end
        end
        
       %figure,imshow(Eyes)
        %counter1
        
        %-- of black pixels--%
        eyespercentage1 = (counter1*100)/(size(Eyes,1)*size(Eyes,2));
        if eyespercentage1 > eyespercentage-thresholdpercentage && eyespercentage1 < eyespercentage+thresholdpercentage
            bitlevel1=0;
       
        end;
        
        
        %-working on mouth in frame-%
        %mouth = rgb2ycbcr(mouth);
       % mouth = rgb2gray(mouth);
       
   
    end;
    if bitlevel1 == 0 % && bitlevel2 == 0
        bitlevel = 0;
     else
        bitlevel = 1;
    end;

    array(t) = bitlevel;
%if{array(t)==30}
 if bitlevel == 1
        prolong = prolong+1;
        if prolong>=3;
        load train.mat;
 sound(y);
  
%           
        end;
        
else
    prolong=0;
end;
    
    
%     if bitlevel == 1
%         counter = counter + 1;
%     end;
% 
%     if t-initial >= 30
%        




end;
end;



