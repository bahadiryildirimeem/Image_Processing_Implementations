function [processedImage] = myGlobalTh(imageName, thToleranceIm, recSize)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);
nofPixel = nofRow * nofColumn;

recSizeOfWindow = recSize;
thTolerance = thToleranceIm;

avgIntensity = 0;
oldTh = 0;

for i=1:nofRow
    for j=1:nofColumn
        avgIntensity = avgIntensity + double(originalImage(i,j));
    end
end

avgIntensity = avgIntensity / nofPixel;
imageTh = uint8(avgIntensity);

if imageTh > 255
    imageTh = 255;
end
generalTh = imageTh;
nofWindow = 0;
adaptiveWindowSizeRow = recSizeOfWindow - 1;
adaptiveWindowSizeColumn = recSizeOfWindow - 1;
areaSize = recSizeOfWindow^2;
rowShiftingValue = 0;
columnShiftingConst = nofColumn / recSizeOfWindow;
columnCounter = 0;
while (nofWindow * areaSize) < nofPixel
    % burasi tekrar etmeli.
    
    avgIntensity = 0;
    oldTh = 0;
    if ((rowShiftingValue + 1) * adaptiveWindowSizeRow) > nofRow
        adaptiveWindowSizeRow = abs(rowShiftingValue * adaptiveWindowSizeRow - nofRow);
    end
    if ((columnCounter + 1) * adaptiveWindowSizeColumn) > nofColumn
        adaptiveWindowSizeColumn = abs(columnCounter * adaptiveWindowSizeColumn - nofColumn);
    else
        adaptiveWindowSizeColumn = recSizeOfWindow;
    end
    for i=1:adaptiveWindowSizeRow
        for j=1:adaptiveWindowSizeColumn
            avgIntensity = avgIntensity + double(originalImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow ));
        end
    end
    avgIntensity = avgIntensity / (adaptiveWindowSizeRow * adaptiveWindowSizeColumn);
    imageTh = avgIntensity;
    toleranceDiff = thTolerance + 1;
    while toleranceDiff > thTolerance
        avgIntensityOfG1 = 0;
        avgIntensityOfG2 = 0;
        thG1 = 0;
        thG2 = 0;
        counterG1 = 0;
        counterG2 = 0;
        for i=1:adaptiveWindowSizeRow
            for j=1:adaptiveWindowSizeColumn
                if double(originalImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow)) > imageTh
                    avgIntensityOfG1 = avgIntensityOfG1 + double(originalImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow));
                    counterG1 = counterG1 + 1;
                else
                    avgIntensityOfG2 = avgIntensityOfG2 + double(originalImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow));
                    counterG2 = counterG2 + 1;
                end
            end
        end
        avgIntensityOfG1 = avgIntensityOfG1 / counterG1;
        avgIntensityOfG2 = avgIntensityOfG2 / counterG2;
        oldTh = imageTh;
        imageTh = (avgIntensityOfG1 + avgIntensityOfG2) / 2;
        toleranceDiff = abs(double(oldTh) - double(imageTh));
    end
    
    for i=1:adaptiveWindowSizeRow
        for j=1:adaptiveWindowSizeColumn
            if imageTh < originalImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow)
                processedImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow) = 255;
            else
                processedImage(i + recSizeOfWindow * rowShiftingValue, j + columnCounter * recSizeOfWindow) = 0;
            end
        end
    end
    nofWindow = nofWindow + 1;
    columnCounter = columnCounter + 1;
    if columnCounter >= columnShiftingConst
        adaptiveWindowSizeRow = recSizeOfWindow;
        columnCounter = 0;
        rowShiftingValue = rowShiftingValue + 1;
    end
end
