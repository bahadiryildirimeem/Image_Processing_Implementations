%debug script
clear all; clc;
attr = struct('filterName', 'gaussianBandRejectFilter', 'filterDia', 40, 'filterDegree', 2, 'filterWidth', 10, 'recSize', 9, 'trimVal', 4, 'sMaxWindow', 15);

filteredImage = myFilter('noisyImage.jpg', attr);
% filteredImage = avgFilter('cameraman.tif', 3);
% filteredImage = geoMeanFilter('cameraman.tif', 3);
% filteredImage = harmonicMeanFilter('cameraman.tif', 3);
% filteredImage = contraHarmonicMeanFilter('cameraman.tif', 3, 1);
% filteredImage = medianFilter('cameraman.tif', 3);
% filteredImage = maxFilter('cameraman.tif', 3);
% filteredImage = minFilter('cameraman.tif', 3);
% filteredImage = midPointFilter('cameraman.tif', 3);
% filteredImage = alphaTrimFilterFilter('cameraman.tif', 3, 4);
% filteredImage = adaptiveMedianFilter('cameraman.tif', 3, 9);
% filteredImage = idealLowPassFilter('noisyImage.jpg', 20);
% filteredImage = butterworthLowPassFilter('noisyImage.jpg', 70, 2);
% filteredImage = gaussianLowPassFilter('noisyImage.jpg', 90);
% filteredImage = idealHighPassFilter('noisyImage.jpg', 90);
% filteredImage = butterworthHighPassFilter('noisyImage.jpg', 90, 2);
% filteredImage = gaussianHighPassFilter('noisyImage.jpg', 90);
% filteredImage = idealBandRejectFilter('noisyImage.jpg', 40, 10);
% filteredImage = butterworthBandRejectFilter('noisyImage.jpg', 40, 10, 2);
% filteredImage = gaussianBandRejectFilter('noisyImage.jpg', 40, 10);
figure;
imshow('noisyImage.jpg');
figure;
imshow(filteredImage);
