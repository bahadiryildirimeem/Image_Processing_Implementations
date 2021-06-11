function [processedImage, hist] = myHistogramEqualization(imageName)

originalImage = imread(imageName);

nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);

totalPixel = nofRow * nofColumn;

intensityRange = 2^8;
processedImage = zeros(nofRow, nofColumn);
imFreq = zeros(1, intensityRange);
hist = zeros(1, intensityRange);
p = zeros(1, intensityRange);
newIntenstyLevels = zeros(1, intensityRange);

for i=1:nofRow
    for j=1:nofColumn
        imFreq(originalImage(i, j) + 1) = imFreq(originalImage(i, j) + 1) + 1;
    end
end


for i=1:intensityRange
    p(i) = imFreq(i) / totalPixel;
end

cumulativeSumIndex = 1;
for i=1:intensityRange
    pixVal = 0;
    for j=1:cumulativeSumIndex
        pixVal = pixVal + p(j);
    end
    pixVal = round(intensityRange * pixVal);
    if(pixVal > 255)
        pixVal = 255;
    end
    newIntenstyLevels(i) = pixVal;
    cumulativeSumIndex = cumulativeSumIndex + 1;
end

for i=1:nofRow
    for j=1:nofColumn
        processedImage(i, j) = uint8(newIntenstyLevels(originalImage(i, j)));
    end
end
processedImage = uint8(processedImage);

for i=1:nofRow
    for j=1:nofColumn
        hist(1, processedImage(i, j) + 1) = hist(1, processedImage(i, j) + 1) + 1;
    end
end