function [processedImage] = alphaTrimFilterFilter(imageName, recSize, trimVal)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

alphaTrimFilterRecSize = recSize;
dVal = trimVal;
for i=1:nofColumn
    for j=1:nofRow
        pixVal = zeros(1, alphaTrimFilterRecSize^2);
        counter = 0;
        for k=-1*(alphaTrimFilterRecSize-1)/2:1:(alphaTrimFilterRecSize-1)/2
             for l=-1*(alphaTrimFilterRecSize-1)/2:1:(alphaTrimFilterRecSize-1)/2
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
        pixVal = sort(pixVal');
        pixVal(1:dVal/2, 1) = 0;
        pixVal((alphaTrimFilterRecSize^2 - (dVal/2-1)):alphaTrimFilterRecSize^2, 1) = 0;
        processedImage(i,j) = sum(sum(pixVal))/(alphaTrimFilterRecSize^2-dVal);
    end
end
processedImage = uint8(processedImage);