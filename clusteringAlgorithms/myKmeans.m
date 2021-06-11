function [clusterCenters] = myKmeans(kItems, nClusters, nIter)

itemMatrix = kItems;
nofClusters = nClusters;
nofIter = nIter;
nofItems = size(itemMatrix, 1);
clusterCenters = zeros(nofClusters, 2);
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