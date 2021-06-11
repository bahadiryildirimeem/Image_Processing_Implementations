function scaledImage = myBilinear(imageName, sr, sc)

originalImage = imread(imageName);
originalImage = double(originalImage)/256;

nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);

xNew = floor(nofColumn * sc);
yNew = floor(nofRow * sr);

xRatio = (nofColumn - 1)/xNew;
yRatio = (nofRow - 1)/yNew;
scaledImage = zeros(yNew, xNew, 3);

for c = 1:3
    for i = 1:yNew
        for j = 1:xNew
            xLeft = floor(xRatio * j);
            if xLeft == 0
                xLeft = 1;
            end
            xRight = ceil(xRatio * j);

            yUp = floor(yRatio * i);
            if yUp == 0
                yUp = 1;
            end
            yDown = ceil(yRatio * i);

            xWeight = (xRatio * j - xLeft);
            yWeight = (yRatio * i - yUp);
            pointA = originalImage(yUp, xLeft, c);
            pointB = originalImage(yUp, xRight, c);
            pointC = originalImage(yDown, xLeft, c);
            pointD = originalImage(yDown, xRight, c);

            pixVal = pointA * (1 - xWeight) * (1 - yWeight) + pointB * xWeight * (1 - yWeight) + pointC * (1 - xWeight) * yWeight + pointD * xWeight * yWeight;
            scaledImage(i, j, c) = pixVal;
        end
    end
end