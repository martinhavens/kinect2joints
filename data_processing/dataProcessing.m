clear; clc;%JointPositions = matfile('dataPointsTesting.mat','JointPositions');
JointPositionsStructure = load('dataPointsTesting','JointPositions')
clear JointPositions
JointPositions=JointPositionsStructure.JointPositions
clear JointPositionsStructure


%JointPositions is in the format  
                      %1st column is x  %2nd column is y  %3rd column is z
%1st row is shoulder   
%2nd row is elbow
%3rd row is wrist
%4th row is hand

% each page is one trigger (~0.9s)


%datcesd=implementDataProcessing(JointPositions,1)





function angles=pointsToAngles(TotalJoints4x3xTrig,linklength)

trig=numel(TotalJoints4x3xTrig)/12;     %isolating the number of columns for counting triggers
for j = 1 : trig
for i = 1 : 4
    x=TotalJoints4x3xTrig(i,1,j)   %4by3bTrig matricx
    y=TotalJoints4x3xTrig(i,2,j)
    z=TotalJoints4x3xTrig(i,3,j)
end
end

coords=[x,y,z]    
%assigning x(1) as origin point
end

function dataProcessed=implementDataProcessing(Joints,length)
%check for rapid position change
trig=numel(Joints)/12;     %isolating the number of columns for counting triggers

for t=1:trig
    for c=1:3
        for r=1:4   %checking for variations of positions too large
          %magnitudes(r,c,trig) = Joints(r,c,trig) < 9
          magnitudes = Joints 
        end
    end
end
dataProcessed=magnitudes
end
