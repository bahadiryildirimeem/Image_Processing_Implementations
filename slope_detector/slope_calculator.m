clear all; clc;
scaleRatio = 0.25;
ignoranceRatio = 0.41;
radRes = 0.1;
nofCluster = 5;
slopeTolerance = 0.01;
originalImage = odev1_bilinear('gorsel_1.jpeg', scaleRatio, scaleRatio);

nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
imHEdges = zeros(nofRow, nofColumn);
imGreenCh = zeros(nofRow, nofColumn, 3);

imGreenCh(:,:, 2) = gaussianLowPassFilter(originalImage(:,:,2), 80);

[blank1 imHEdges blank2] = sobelEdgeDetector(imGreenCh(:, :, 2));

[imGreenCh(:, :, 2) greenChVariance] = myOtsoTh(imHEdges);

imGreenCh(:, :, 2) = myErosion(imGreenCh(:, :, 2));

[votingMatrix, lineVals, lineImg, slopeAndConstants] = myHoughTr (imGreenCh(:, :, 2), radRes, ignoranceRatio);

xVector = 1:nofColumn;
nofLines = size(slopeAndConstants, 1);

counter = 0;
if size(slopeAndConstants, 1) <= nofCluster
    nofCluster = size(slopeAndConstants, 1) - 2;
end
clusteredLines = myKmeans(slopeAndConstants, nofCluster, 10);

figure;
subplot(2, 1, 1);
stem(slopeAndConstants(:, 1), slopeAndConstants(:, 2));
hold on
stem(clusteredLines(:, 1), clusteredLines(:, 2), '-r', '*');
weightedSlopes = zeros(size(clusteredLines, 1), 1);

for i=1:size(clusteredLines, 1)
    for j=1:size(clusteredLines, 1)
        if (clusteredLines(j, 1) >= (clusteredLines(i, 1) - slopeTolerance)) &&  (clusteredLines(j, 1) <= (clusteredLines(i, 1) + slopeTolerance)) 
            weightedSlopes(j, 1) = weightedSlopes(j, 1) + 1;
        end
    end
end

%figure;
subplot(2, 1, 2);
imshow(originalImage);
for i=1:nofLines
    hold on;
    yVector = slopeAndConstants(i, 1) .* xVector + slopeAndConstants(i, 2);
    plot(xVector, yVector);
end

for i=1:size(clusteredLines, 1)
    hold on;
    yVector = clusteredLines(j, 1) .* xVector + clusteredLines(j, 2);
    plot(xVector, yVector, '-y');
end

errState = 0;
val = weightedSlopes(1, 1);
for i=1:size(weightedSlopes, 1)
    if weightedSlopes(i, 1) ~= val
        errState = 1;
    end
end

if errState == 1
    title('FAIL', 'Color', 'red');
else
    title('PASS', 'Color', 'green');
end





