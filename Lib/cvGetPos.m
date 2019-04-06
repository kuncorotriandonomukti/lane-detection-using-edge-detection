function [linePos] = cvGetPos(hLines)
% Copyright 2015-2016 The MathWorks, Inc.
% Get line and marker positions (output) of houghlines (input) formatted to
% use directly with insertShape and insertObjectAnnotation functions.

linePos = [];
for lidx = 1:length(hLines)
    % Get linePos in [x1 y1;x2 y2...] format. 
    linePos = [linePos;...
               hLines(lidx).point1 hLines(lidx).point2];  
end
end