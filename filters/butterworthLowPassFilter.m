function [processedImage] = butterworthLowPassFilter(imageName, filterD, filterDeg)
originalImage = imread(imageName);
nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedFFT = zeros(nofRow, nofColumn);
processedImage = zeros(nofRow, nofColumn);

filterDia = filterD;

F1=fft2(originalImage);
F1C=fftshift(F1);

refPointX = floor(-1*nofColumn/2):1:(nofColumn-1)/2;
refPointY  = floor(-1*nofRow/2):1:(nofRow-1)/2;

euclideanDistances = zeros(nofRow, nofColumn);
butterworthLowPassFilter = zeros(nofRow, nofColumn);

for i=1:nofColumn
    if refPointX(1,i)>nofColumn/2
        refPointX(1, i) = refPointX(1, i) - nofColumn;
    end
end

for i=1:nofRow
    if refPointY(1,i)>nofRow/2
        refPointY(1, i) = refPointY(1, i) - nofColumn;
    end
end
refPointY = refPointY';
for i=1:nofRow
    for j=1:nofColumn
        euclideanDistances(i,j) = (refPointY(i,1)^2 + refPointX(1,j)^2)^(1/2);
    end
end

butterworthDegree = filterDeg;
for i=1:nofRow
    for j=1:nofColumn
      butterworthLowPassFilter(i,j) = 1 / (1+(euclideanDistances(i,j) / filterDia)^(2*butterworthDegree));
    end
end

processedFFT = butterworthLowPassFilter .* F1C;
processedImage = ifft2(processedFFT);
processedImage = uint8(abs(processedImage));