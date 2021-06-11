function [votingMatrix, lineVals, lineImg, slopeAndConstants] = myHoughTr(imageName, radRes, ignoranceRat)

originalImage = imageName;
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
totalPixel = nofRow * nofColumn;
imHEdges = zeros(nofRow, nofColumn);

ignoranceRatio = ignoranceRat;
radRes = radRes;
radVector = -3.1415:radRes:3.1415;

radVectorLength = size(radVector, 2);
imDistances = zeros(1, radVectorLength);
maxDistance = ceil(((nofRow + 1)^2 + (nofColumn + 1)^2)^(1/2));
votingMatrix = zeros(maxDistance, radVectorLength);
lineVals = zeros(1, 2); % column1 dist, column2 theta
lineImg = zeros(1, 2); % column1 x, column2 y
slopeAndConstants = zeros(1, 2); % column 1 slope, column 2 constant

for i=1:nofRow
    for j=1:nofColumn
        if originalImage(i, j) ~= 0
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

for i=1:maxDistance
    for j=1:radVectorLength
        if  votingMatrix(i, j) >= limitVal
            lineVals(counter, :) = [i radVector(1, j)];
            counter = counter + 1;
        end
    end
end
figure;
imshow(imageName);
for i=1:size(lineVals, 1)
    lineImg(i,1) = round(lineVals(i, 1) *  cos(lineVals(i, 2)));
    lineImg(i,2) = round(lineVals(i, 1) *  sin(lineVals(i, 2)));
    sinRatio = sin(lineVals(i, 2));
    x1 = nofColumn;
    x2 = 0;
    if sinRatio ~= 0
        y1 = (lineVals(i, 1) - x1 * cos(lineVals(i, 2))) / sinRatio;
        y2 = (lineVals(i, 1) - x2 * cos(lineVals(i, 2))) / sinRatio;
    else
        y1 = (lineVals(i, 1) - x1 * cos(lineVals(i, 2))) / 0.0001;
        y2 = (lineVals(i, 1) - x2 * cos(lineVals(i, 2))) / 0.0001;
    end
    hold on;
    plot([x1 x2], [y1 y2]);
    slopeAndConstants(i, 1) = (y1 - y2) / (x1 - x2);
    slopeAndConstants(i, 2) = y2;
end
