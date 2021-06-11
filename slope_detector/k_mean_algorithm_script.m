% k mean algorithm script
itemMatrix = slopeAndConstants;
nofClusters = 5;
nofIter = 50;
nofItems = size(slopeAndConstants, 1);
clusterCenters = zeros(nofClusters, 1);
newClusters = zeros(nofClusters, nofItems);
clusterDistances = zeros(nofClusters, nofItems);
if nofItems < nofClusters
    disp('ERROR! Dimension is smaller than number of clusters.');
else
    clusterCenters = itemMatrix(1:nofClusters, :);
    for l = 1:nofIter
        newClusters = zeros(nofClusters, nofItems, nofItems);
        newCulesterIndexCounters = ones(nofClusters, 1);
        clusterDistances = zeros(nofClusters, nofItems);
        for i = 1:nofItems
            closestCluster = 1;
            minDist = 99999999999;
            for j = 1:nofClusters
                clusterDistances(j, i) = ((clusterCenters(j, 1) - itemMatrix(i, 1))^2 +  (clusterCenters(j, 2) - itemMatrix(i, 2))^2)^(1/2);
                if minDist > clusterDistances(j, i)
                    closestCluster = j;
                    minDist = clusterDistances(j, i);
                end
            end
            newClusters(closestCluster, newCulesterIndexCounters(closestCluster, 1), 1) = itemMatrix(i, 1);
            newClusters(closestCluster, newCulesterIndexCounters(closestCluster, 1), 2) = itemMatrix(i, 2);
            newCulesterIndexCounters(closestCluster, 1) = newCulesterIndexCounters(closestCluster, 1) + 1;
            
        end
        for k = 1:nofClusters
            if (newCulesterIndexCounters(k, 1) - 1) == 0
                clusterCenters(k, 1) = sum(newClusters(k, :, 1)) / (0.0000001);
                clusterCenters(k, 2) = sum(newClusters(k, :, 2)) / (0.0000001);
            else
                clusterCenters(k, 1) = sum(newClusters(k, :, 1)) / (newCulesterIndexCounters(k, 1) - 1);
                clusterCenters(k, 2) = sum(newClusters(k, :, 2)) / (newCulesterIndexCounters(k, 1) - 1);
            end
        end
    end
end

figure;
stem(itemMatrix(:, 1), itemMatrix(:, 2));
hold on;
stem(clusterCenters(:, 1), clusterCenters(:, 2), '-r', 'filled');
figure;
imshow(originalImage);
vectorss = zeros(nofClusters, 400);
for i=1:nofClusters
    hold on;
    if clusterCenters(i, 2) > 0
        yVector = clusterCenters(i, 1) .* xVector  + clusterCenters(i, 2);
        plot(xVector, yVector);
    end
end