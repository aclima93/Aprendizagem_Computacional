
mpaper

T2 = pinv(horzcat(Perfect, Perfect, Perfect, Perfect, Perfect));

Wp = T2*pinv(P);
P = pinv(Wp * P);

net=feedforwardnet(1);
%net=newp(P,T) ;

W=rand(10,256);
b=rand(10,1);
net.IW{1,1}=W;
net.b{1,1}=b;


net.performParam.ratio = 0.5; % learning rate 
net.trainParam.epochs = 1000; % maximum epochs 
net.trainParam.show = 35; % show 
net.trainParam.goal = 1e-6; % goal=objective 
net.performFcn = 'sse'; % criterion

net=train(net,P,T);
W=net.IW{1,1};
b=net.b{1,1};

mpaper

a = sim(net,P);