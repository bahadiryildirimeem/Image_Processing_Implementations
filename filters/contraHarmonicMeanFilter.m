function [processedImage] = contraHarmonicMeanFilter(imageName, recSize, filterDegree)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn);

degreeOfContraHarmonicFilter = filterDegree;
contraHarmonicFilterRecSize = recSize;
for i=1:nofColumn
    for j=1:nofRow
        pixVal = zeros(contraHarmonicFilterRecSize);
        countX = 0;
        countY = 0;
        for k=-1*(contraHarmonicFilterRecSize-1)/2:1:(contraHarmonicFilterRecSize-1)/2
            countY = countY + 1;
            countX = 0;
            for l=-1*(contraHarmonicFilterRecSize-1)/2:1:(contraHarmonicFilterRecSize-1)/2
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
                  pixVal(countY, countX) = double(originalImage(indexY, indexX));
            end
        end
        dividend = (sum(sum(pixVal.^(degreeOfContraHarmonicFilter+1))));
        denominator = (sum(sum(pixVal.^(degreeOfContraHarmonicFilter))));
        processedImage(i,j) = dividend/denominator;
    end
end
processedImage = uint8(processedImage);