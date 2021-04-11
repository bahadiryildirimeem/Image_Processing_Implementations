function [processedImage] = avgFilter(imageName, recSize)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

avgFilterRecSize = recSize;
avgFilter = zeros(avgFilterRecSize);
for i=1:avgFilterRecSize
    for j=1:avgFilterRecSize
        avgFilter(i,j) = 1/ avgFilterRecSize^2;
    end
end
for i=1:nofColumn
    for j=1:nofRow
        pixVal = zeros(avgFilterRecSize);
        countX = 0;
        countY = 0;
        for k=-1*(avgFilterRecSize-1)/2:1:(avgFilterRecSize-1)/2
            countY = countY + 1;
            countX = 0;
            for l=-1*(avgFilterRecSize-1)/2:1:(avgFilterRecSize-1)/2
                countX = countX + 1;
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
                  pixVal(countY, countX) = originalImage(indexY, indexX);
            end
        end
        processedImage(i,j) = sum(sum(pixVal))/(avgFilterRecSize^2);
    end
end
processedImage = uint8(processedImage);