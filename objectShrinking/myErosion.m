function [processedImage] = myErosion(imageName)
% sobel edge detector script

originalImage = imageName;
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);
processedImageCombined = zeros(nofRow, nofColumn);

structureElement = [0, 1, 0; 1, 1, 1; 0, 1, 0];


structureElementSize = 3;
for i=1:nofRow
    for j=1:nofColumn
        pixVal = zeros(structureElementSize);
        counter = 0;
        kernelRowCount = 0;
        kernelColumnCount = 0;
        hitState = 255;
        for k=-1*(structureElementSize-1)/2:1:(structureElementSize-1)/2
            kernelRowCount = kernelRowCount + 1;
            kernelColumnCount = 0;
            for l=-1*(structureElementSize-1)/2:1:(structureElementSize-1)/2
                kernelColumnCount = kernelColumnCount + 1;
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
                  if structureElement(kernelRowCount, kernelColumnCount) == 1
                      if originalImage(indexY, indexX) == 0
                          hitState = 0;
                      end
                  end
            end
        end
        processedImage(i,j) = hitState;
    end
end
processedImage = uint8(processedImage);