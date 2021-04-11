function [processedImage] = medianFilter(imageName, recSize)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

medianFilterRecSize = recSize;
for i=1:nofColumn
    for j=1:nofRow
        pixVal = zeros(1, medianFilterRecSize^2);
        counter = 0;
        for k=-1*(medianFilterRecSize-1)/2:1:(medianFilterRecSize-1)/2
            for l=-1*(medianFilterRecSize-1)/2:1:(medianFilterRecSize-1)/2
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
        processedImage(i,j) = pixVal(ceil((medianFilterRecSize^2)/2));
    end
end
processedImage = uint8(processedImage);