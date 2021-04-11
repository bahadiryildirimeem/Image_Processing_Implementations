function [processedImage] = geoMeanFilter(imageName, recSize)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

geoMeanFilterRecSize = recSize;
for i=1:nofColumn
    for j=1:nofRow
        pixVal = 1.0;
        for k=-1*(geoMeanFilterRecSize-1)/2:1:(geoMeanFilterRecSize-1)/2
            for l=-1*(geoMeanFilterRecSize-1)/2:1:(geoMeanFilterRecSize-1)/2
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
                  pixVal= pixVal * double(originalImage(indexY, indexX));
            end
        end
        processedImage(i,j) = (pixVal)^(1/(geoMeanFilterRecSize^2));
    end
end
processedImage = uint8(processedImage);