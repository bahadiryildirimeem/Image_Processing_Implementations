function [processedImage] = adaptiveMedianFilter(imageName, recSize, maxRecSize)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

adaptiveMedianFilterRecSize = recSize;
adaptiveMedianFilterMaxRecSize = maxRecSize;
for i=1:nofColumn
    for j=1:nofRow
        adaptiveMedianFilterRecSize = 3;
        while adaptiveMedianFilterRecSize <= adaptiveMedianFilterMaxRecSize
            pixVal = zeros(1, adaptiveMedianFilterRecSize^2);
            counter = 0;
            for k=-1*(adaptiveMedianFilterRecSize-1)/2:1:(adaptiveMedianFilterRecSize-1)/2
                for l=-1*(adaptiveMedianFilterRecSize-1)/2:1:(adaptiveMedianFilterRecSize-1)/2
                    counter = counter + 1;
                    indexX = l+j;
                    indexY = k+i;
                    if indexX < 1
                        indexX = 1;
                    elseif indexX > nofColumn
                        indexX = nofColumn;
                    end
                    if indexY < 1
                        indexY = 1;
                    elseif indexY > nofRow
                        indexY = nofRow;
                    end
                    pixVal(1, counter) = originalImage(indexY, indexX);
                end
            end
            pixVal = sort(pixVal);
            zMin   = min(pixVal);
            zMax   = max(pixVal);
            zMed   = pixVal(ceil((adaptiveMedianFilterRecSize^2)/2));
            a_1    = zMed - zMin;
            a_2    = zMed - zMax;
            levelBState = 0;
            if a_1 > 0 && a_2 < 0
                levelBState = 1;
            else 
                adaptiveMedianFilterRecSize = adaptiveMedianFilterRecSize + 2;
                if adaptiveMedianFilterRecSize > adaptiveMedianFilterMaxRecSize
                    processedImage(i,j) = zMed;
                end
            end
            if levelBState == 1
                b_1 = originalImage(i,j) - zMin;
                b_2 = originalImage(i,j) - zMax;
                if b_1 > 0 && b_2 < 0
                    processedImage(i,j) = originalImage(i,j);
                    break
                else
                    processedImage(i,j) = zMed;
                    break
                end
            end
        end
    end
end
processedImage = uint8(processedImage);