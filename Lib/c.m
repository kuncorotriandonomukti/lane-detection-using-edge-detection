function [citra] = c(x)
switch x
    case 1
        citra = imread('im (1).jpg');
    case 2
        citra = imread('im (2).jpg');
    case 3
        citra = imread('im (3).jpg');
    case 4
        citra = imread('im (4).jpg');
end
