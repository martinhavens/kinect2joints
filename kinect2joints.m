%UNorth Florida by Kenny Nguyen, Martin Havens, Don Flores, and Dillon Murray
%Kinect version 2 Joint Track and Display V1.0
%available on Github at github.com/martinhavens/kinect2joints

imaqreset;
%create color and depth kinect videoinput objects
colorVid = videoinput('kinect', 1);
depthVid = videoinput('kinect', 2);
triggerconfig (depthVid,'manual');
framesPerTrig = 1;
depthVid.FramesPerTrigger=framesPerTrig;
depthVid.TriggerRepeat=inf;
src = getselectedsource(depthVid);
src.EnableBodyTracking = 'on';  
start(depthVid);
himg = figure;
% These are the order of joints returned by the kinect adaptor.
%    SpineBase = 1;
%    SpineMid = 2;
%    Neck = 3;
%    Head = 4;
%    ShoulderLeft = 5;
%    ElbowLeft = 6;
%    WristLeft = 7;
%    HandLeft = 8;
%    ShoulderRight = 9;
%    ElbowRight = 10;
%    WristRight = 11;
%    HandRight = 12;
%    HipLeft = 13;
%    KneeLeft = 14;
%    AnkleLeft = 15;
%    FootLeft = 16;
%    HipRight = 17;
%    KneeRight = 18;
%    AnkleRight = 19;
%    FootRight = 20;
%    SpineShoulder = 21;
%    HandTipLeft = 22;
%    ThumbLeft = 23;
%    HandTipRight = 24;
%    ThumbRight = 25;
%Skeleton map to link joints
SkeletonConnectionMap = [ [4 3];  % Neck
                          [3 21]; % Head
                          [21 2]; % Right Leg
                          [2 1];
                          [21 9];
                          [9 10];  % Hip
                          [10 11];
                          [11 12]; % Left Leg
                          [12 24];
                          [12 25];
                          [21 5];  % Spine
                          [5 6];
                          [6 7];   % Left Hand
                          [7 8];
                          [8 22];
                          [8 23];
                          [1 17];
                          [17 18];
                          [18 19];  % Right Hand
                          [19 20];
                          [1 13];
                          [13 14];
                          [14 15];
                          [15 16];
                        ];
                    trig=1;
while ishandle(himg);
    
trigger (depthVid);
[depthMap, ts, depthMetaData] = getdata (depthVid);
%anyBodiesTracked = any(depthMetaData.IsBodyTracked ~= 0);
trackedBodies = find(depthMetaData.IsBodyTracked);
nBodies = length(trackedBodies);
colors = ['r';'g';'b';'c';'y';'m'];
%imshow (depthMap, [0 4096]);
if  sum(depthMetaData.IsBodyTracked) >0
skeletonJoints = depthMetaData.JointPositions (:,:,:);
%hold on;
%Skeleton overlay
for i = 6:8        %tracking from shoulder to hand only
    %hold on;   
    %axis([0 3 0 3])
for body = 1:nBodies
X1 = [skeletonJoints(SkeletonConnectionMap(i,1),1,body); skeletonJoints(SkeletonConnectionMap(i,2),1,body)];
Y1 = [skeletonJoints(SkeletonConnectionMap(i,1),2,body), skeletonJoints(SkeletonConnectionMap(i,2),2,body)];
Z1=  [skeletonJoints(SkeletonConnectionMap(i,1),3,body), skeletonJoints(SkeletonConnectionMap(i,2),3,body)];
%line(X1,Y1, 'LineWidth', 2, 'LineStyle', '-' , 'Marker', '+', 'Color', colors(body));
linklength(trig,i-5)=sqrt((X1(1)^2)+(Y1(1)^2)+(Z1(1)^2))
JointPositions(i-5,:,trig)=[X1(1),Y1(1),Z1(1)]
%hold on;
%plot3(JointPositions(i-5,1,trig),JointPositions(i-5,2,trig),JointPositions(i-5,3,trig),'+')
hold on;
axis([-2 2 -2 2 -2 2])
if i>6
 X1=JointPositions(i-6,1,trig)                %JointPositions is in the format  
 X2=JointPositions(i-5,1,trig)                %1st row is shoulder
 Y1=JointPositions(i-6,2,trig)                %2nd row is elbow
 Y2=JointPositions(i-5,2,trig)                %3rd row is wrist
 Z1=JointPositions(i-6,3,trig)                %4th row is hand
 Z2=JointPositions(i-5,3,trig)
  %line([X1 X2],[Y1 Y2],[Z1 Z2])
  plot3([X1 X2],[Y1 Y2], [Z1 Z2], 'k-')
  xlabel('x')
ylabel('y')
zlabel('z')
end
%axis([1 2 1 2 1 2])
hold off
end

end
%hold off;
%plot(JointPositions(trig,1),JointPositions(trig,2),'o')


trig=trig+1;
end
end
stop(depthVid);
