function [processedImage] = myFilter(imageName, filterAttr)
%struct('filterName', filterName, 'filterDia', filterDia, 'filterDegree', filterDegree, 'recSize', recSize, 'sMaxWindow', maxRecSize)
%%processedImageavgFilter(ImageName)
if strcmp(filterAttr.filterName, 'avgFilter')
    processedImage = avgFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'geoMeanFilter')
    processedImage = geoMeanFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'harmonicMeanFilter')
    processedImage = harmonicMeanFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'contraHarmonicMeanFilter')
    processedImage = contraHarmonicMeanFilter(imageName, filterAttr.recSize, filterAttr.filterDegree);
elseif strcmp(filterAttr.filterName, 'medianFilter')
    processedImage = medianFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'maxFilter')
    processedImage = maxFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'minFilter')
    processedImage = minFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'midPointFilter')
    processedImage = midPointFilter(imageName, filterAttr.recSize);
elseif strcmp(filterAttr.filterName, 'alphaTrimFilterFilter')
    processedImage = alphaTrimFilterFilter(imageName, filterAttr.recSize, filterAttr.trimVal);
elseif strcmp(filterAttr.filterName, 'adaptiveMedianFilter')
    processedImage = adaptiveMedianFilter(imageName, filterAttr.recSize, filterAttr.sMaxWindow);
elseif strcmp(filterAttr.filterName, 'idealLowPassFilter')
    processedImage = idealLowPassFilter(imageName, filterAttr.filterDia);
elseif strcmp(filterAttr.filterName, 'butterworthLowPassFilter')
    processedImage = butterworthLowPassFilter(imageName, filterAttr.filterDia, filterAttr.filterDegree);
elseif strcmp(filterAttr.filterName, 'gaussianLowPassFilter')
    processedImage = gaussianLowPassFilter(imageName, filterAttr.filterDia);
elseif strcmp(filterAttr.filterName, 'idealHighPassFilter')
    processedImage = idealHighPassFilter(imageName, filterAttr.filterDia);
elseif strcmp(filterAttr.filterName, 'butterworthHighPassFilter')
    processedImage = butterworthHighPassFilter(imageName, filterAttr.filterDia, filterAttr.filterDegree);
elseif strcmp(filterAttr.filterName, 'gaussianHighPassFilter')
    processedImage = gaussianHighPassFilter(imageName, filterAttr.filterDia);
elseif strcmp(filterAttr.filterName, 'idealBandRejectFilter')
    processedImage = idealBandRejectFilter(imageName, filterAttr.filterDia, filterAttr.filterWidth);
elseif strcmp(filterAttr.filterName, 'butterworthBandRejectFilter')
    processedImage = butterworthBandRejectFilter(imageName, filterAttr.filterDia, filterAttr.filterWidth, filterAttr.filterDegree);
elseif strcmp(filterAttr.filterName, 'gaussianBandRejectFilter')
    processedImage = gaussianBandRejectFilter(imageName, filterAttr.filterDia, filterAttr.filterWidth);
else
    disp('Input Error');
end
