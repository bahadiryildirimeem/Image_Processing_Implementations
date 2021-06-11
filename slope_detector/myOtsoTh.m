function [processedImage backgroundVar] = myOtsoTh(imageName)
originalImage = imageName;
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);
nofPixel = nofRow * nofColumn;

maxIntensityLevel = 256; % matrix index begins from 1

imageFreq = zeros(1, maxIntensityLevel);
wBackground = zeros(1, maxIntensityLevel);
wForeground = zeros(1, maxIntensityLevel);
meanBackground = zeros(1, maxIntensityLevel);
meanForeground = zeros(1, maxIntensityLevel);
varianceBackground = zeros(1, maxIntensityLevel);

for i=1:nofRow
    for j=1:nofColumn
        imageFreq(1, originalImage(i,j) + 1) = imageFreq(1, originalImage(i,j) + 1) + 1;
    end
end

for i=1:maxIntensityLevel
    wBackground(1, i) = sum(imageFreq(1,1:i)) / nofPixel;
    wForeground(1, i) = sum(imageFreq(1,(i + 1):maxIntensityLevel)) / nofPixel;
    numberVectorBack = 0:(i - 1);
    numberVectorFore = i:(maxIntensityLevel - 1);
    meanBackground(1, i) = (sum(numberVectorBack .* imageFreq(1, 1:i))) / sum(imageFreq(1, 1:i));
    meanForeground(1, i) = (sum(numberVectorFore .* imageFreq(1, (i+1):maxIntensityLevel))) / sum(imageFreq(1, (i+1):maxIntensityLevel));
end


varianceBackground = wBackground .* wForeground .* ((meanBackground - meanForeground).^2);

maxVariance = -1;
maxVarianceIndex = -1;

for i=1:maxIntensityLevel
    if varianceBackground(1, i) > maxVariance
        maxVariance = varianceBackground(1, i);
        maxVarianceIndex = i;
    end
end

for i=1:nofRow
    for j=1:nofColumn
        if originalImage(i,j) > maxVarianceIndex
            processedImage(i,j) = maxIntensityLevel - 1;
        else
            processedImage(i,j) = 0;
        end
    end
end

backgroundVar = varianceBackground;
