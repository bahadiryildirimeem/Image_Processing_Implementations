clear all; clc;
scaleRatio = 0.25;
originalImage = odev1_bilinear('gorsel_4.jpeg', 0.25, 0.25);
gostermelik = originalImage;
originalImage = rgb2gray(originalImage);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
totalPixel = nofRow * nofColumn;
imHEdges = zeros(nofRow, nofColumn);
imGreenCh = zeros(nofRow, nofColumn, 3);

figure;
imshow(originalImage);


imGreenCh(:,:, 2) = originalImage;
[blank1 imAllEdges sa] = sobelEdgeDetector(imGreenCh(:, :, 2));


[imAllEdges greenChVariance] = myOtsoTh(imAllEdges);
figure;
imshow(imAllEdges);

ignoranceRatio = 0.37;
radRes = 0.1;
radVector = -3.1415:radRes:3.1415;

radVectorLength = size(radVector, 2);
imDistances = zeros(1, radVectorLength);
maxDistance = ((nofRow + 1)^2 + (nofColumn + 1)^2)^(1/2);
votingMatrix = zeros(maxDistance + 1, radVectorLength);
comparingMatrix = zeros(maxDistance + 1, radVectorLength);
lineVals = zeros(1, 2); % column1 dist, column2 theta
lineImg = zeros(1, 2); % column1 x, column2 y
slopeAndConstants = zeros(1, 2); % column 1 slope, column 2 constant
drawLine = zeros(nofRow, nofColumn);

for i=1:nofRow
    for j=1:nofColumn
        if imAllEdges(i, j) ~= 0
            for l=1:radVectorLength
                imDistances(1, l) = abs(ceil(i * sin(radVector(1, l)) + j * cos(radVector(1, l))));
                votingMatrix(imDistances(1, l)+1, l) = votingMatrix(imDistances(1, l)+1, l) + 1;
            end
        end
    end
end

dominantLine = max(max(votingMatrix));
limitVal = dominantLine * ignoranceRatio;
counter = 1;

figure;
imshow(gostermelik);

for i=1:maxDistance
    for j=1:radVectorLength
        if  votingMatrix(i, j) >= limitVal
            lineVals(counter, :) = [i radVector(1, j)];
            counter = counter + 1;
        end
    end
end
hold on;
for i=1:size(lineVals, 1)
    lineImg(i,1) = abs(round(lineVals(i, 1) *  cos(lineVals(i, 2))));
    lineImg(i,2) = abs(round(lineVals(i, 1) *  sin(lineVals(i, 2))));
    cosRatio = cos(lineVals(i, 2));
    sinRatio = sin(lineVals(i, 2));
    x1 = (nofRow / 2) + (nofRow / 2);
    x2 = (nofRow / 2) - (nofRow / 2);
    if sinRatio ~= 0
        y1 = (lineVals(i, 1) - x1 * cos(lineVals(i, 2))) / sinRatio;
        y2 = (lineVals(i, 1) - x2 * cos(lineVals(i, 2))) / sinRatio;
    else
        y1 = (lineVals(i, 1) - x1 * cos(lineVals(i, 2))) / 0.0001;
        y2 = (lineVals(i, 1) - x2 * cos(lineVals(i, 2))) / 0.0001;
    end
    plot([x1, x2],[y1, y2], 'r-');
    slopeAndConstants(i, 1) = (y1 - y2) / (x1 - x2);
    slopeAndConstants(i, 2) = y2;
    hold on;
end

% figure;
% imshow(votingMatrix/(max(max(votingMatrix))));
% figure;
% imshow(drawLine);