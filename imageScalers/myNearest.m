function scaledImage = myNearest(imageName, sr, sc)

originalImage = imread(imageName);
originalImage = double(originalImage)/256;

nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);

xNew = floor(nofColumn * sc);
yNew = floor(nofRow * sr);

xRatio = (nofColumn - 1)/xNew;
yRatio = (nofRow - 1)/yNew;
scaledImage = zeros(yNew, xNew, 3);

for c=1:3
    for i=1:yNew
        for j=1:xNew
            xLeft = floor(xRatio * j);
            yUp = floor(yRatio * i);
            
            xWeight = abs(xRatio * j - xLeft);
            yWeight = abs(yRatio * i - yUp);
            xPixNo = 0;
            yPixNo = 0;
            if abs(xWeight) > abs(1 - xWeight)
                xPixNo = floor(xRatio * j);
            else
                xPixNo = ceil(xRatio * j);
            end
            
            if abs(yWeight) > abs(1 - yWeight)
                yPixNo = floor(yRatio * i);
            else
                yPixNo = ceil(yRatio * i);
            end
            if yPixNo == 0 || xPixNo == 0 || yPixNo > nofColumn || xPixNo > nofRow
                scaledImage(i, j, c) = 0;
            else
                scaledImage(i, j, c) = originalImage(yPixNo, xPixNo, c);
            end
        end
    end
end