function [processedImage th1 th2] = myOtsoMultiTh(imageName)
originalImage = imread(imageName);

nofRow = size(originalImage, 1);
nofColumn = size(originalImage, 2);
processedImage = zeros(nofRow, nofColumn, 3);
nofPixel = nofRow * nofColumn;

maxIntensityLevel = 256; % matrix index begins from 1

weigth0 = 0;
weigth1 = 0;
weigth2 = 0;
nu0 = 0;
nu1 = 0;
nu2 = 0;
variance0 = 0;
variance1 = 0;
variance2 = 0;
varianceB = 0;
th1 = 0;
th2 = 0;
maxVal = 0;

imageFreq = zeros(1, maxIntensityLevel);
avgOfTotal = sum(sum(double(originalImage))) / nofPixel;
totalVar = 0;
for i=1:maxIntensityLevel
    totalVar = totalVar + ((i-1) - avgOfTotal)^2;
end
totalVar = totalVar / (maxIntensityLevel - 1);

for i=1:nofRow
    for j=1:nofColumn
        imageFreq(1, originalImage(i,j)+1) = imageFreq(1, originalImage(i,j) + 1) + 1;
    end
end
pdfOfAll = imageFreq / nofPixel;

for i=1:maxIntensityLevel
    for j=(i+1):maxIntensityLevel
        for k=(j+1):maxIntensityLevel
            weigth0 = 0;
            weigth1 = 0;
            weigth2 = 0;
            nu0 = 0;
            nu1 = 0;
            nu2 = 0;
            variance0 = 0;
            variance1 = 0;
            variance2 = 0;
            for counter1=1:i
                weigth0 = weigth0 + pdfOfAll(1, counter1);
                nu0 = nu0 + counter1 * pdfOfAll(1, counter1);
            end
            for counter2=(i+1):j
                weigth1 = weigth1 + pdfOfAll(1, counter2);
                nu1 = nu1 + counter2 * pdfOfAll(1, counter2);
            end
            
            for counter3=(j+1):maxIntensityLevel
                weigth2 = weigth2 + pdfOfAll(1, counter3);
                nu2 = nu2 + counter3 * pdfOfAll(1, counter3);
            end
            if weigth0 == 0
                nu0 = 0;
            else
                nu0 = nu0 / weigth0;
            end
            
            if weigth1 == 0
                nu1 = 0;
            else
                nu1 = nu1 / weigth1;
            end
            if weigth2 == 0
                nu2 = 0;
            else
                nu2 = nu2 / weigth2;
            end
            
            %%%
            for counter1=1:i
                variance0 = variance0 + (((counter1 - nu0)^2) * pdfOfAll(1, counter1)) / weigth0;
            end
            for counter2=(i+1):j
                variance1 = variance1 + (((counter2 - nu1)^2) * pdfOfAll(1, counter2)) / weigth1;
            end
            for counter3=(j+1):maxIntensityLevel
                variance2 = variance2 + (((counter3 - nu2)^2) * pdfOfAll(1, counter3)) / weigth2;
            end
            %%%
            varianceB = weigth0 * ((nu0 - avgOfTotal)^2) + weigth1 * ((nu1 - avgOfTotal)^2) + weigth2 * ((nu2 - avgOfTotal)^2);
            nuVal = varianceB / totalVar;
            if nuVal > maxVal
                maxVal = nuVal;
                th1 = i;
                th2 = j;
            end
        end
    end
end

for i=1:nofRow
    for j=1:nofColumn
        if originalImage(i,j) > th1
            processedImage(i, j, 1) = 255;
        end
        if originalImage(i,j) > th2
            processedImage(i, j, 2) = 255;
        end
    end
end