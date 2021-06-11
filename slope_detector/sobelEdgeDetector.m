function [processedImageV, processedImageH, processedImageCombined] = sobelEdgeDetector(imageName)
% sobel edge detector script

originalImage = imageName;
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImageV = zeros(nofRow, nofColumn);
processedImageH = zeros(nofRow, nofColumn);
processedImageCombined = zeros(nofRow, nofColumn);

sobelKernelV = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
sobelKernelH = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

sobelKernelSize = 3;
for i=1:nofRow
    for j=1:nofColumn
        pixValH = zeros(sobelKernelSize);
        pixValV = zeros(sobelKernelSize);
        counter = 0;
        kernelRowCount = 0;
        kernelColumnCount = 0;
        for k=-1*(sobelKernelSize-1)/2:1:(sobelKernelSize-1)/2
            kernelRowCount = kernelRowCount + 1;
            kernelColumnCount = 0;
            for l=-1*(sobelKernelSize-1)/2:1:(sobelKernelSize-1)/2
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
                  pixValH(kernelRowCount, kernelColumnCount) = double(originalImage(indexY, indexX)) * sobelKernelH(kernelRowCount, kernelColumnCount);
                  pixValV(kernelRowCount, kernelColumnCount) = double(originalImage(indexY, indexX)) * sobelKernelV(kernelRowCount, kernelColumnCount);
            end
        end
        processedImageV(i,j) = sum(sum(pixValV));
        processedImageH(i,j) = sum(sum(pixValH));
        processedImageCombined(i,j) = processedImageV(i,j) + processedImageH(i,j);
    end
end
processedImageV = uint8(processedImageV);
processedImageH = uint8(processedImageH);
processedImageCombined = uint8(processedImageCombined);