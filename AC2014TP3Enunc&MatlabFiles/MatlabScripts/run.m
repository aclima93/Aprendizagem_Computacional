dataFile = load('92202.mat');
dataTarget = dataFile.Trg;
dataFeatures = dataFile.FeatVectSel;
plot(dataTarget);
axis([0,400000,-1,2]);
figure;
plot(dataFeatures(:,1));