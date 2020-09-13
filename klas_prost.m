% Klasyfikacja punktow(obrazow) nalezacych do prostokata
%
%       (1,3) o----------------o (4,3)
%             |                |
%             |                |
%             |                |
%       (1,1) o----------------o (4,1)
%


% METODA ANALITYCZNA

net = newff([-10 10; -10 10], [4 1], {'hardlim', 'hardlim'});

net.IW{1}(:,1) = [2;-1;0;0];               % wagi od wejsc do pierwszej warstwy
net.IW{1}(:,2) = [0;0;2;-1];
net.LW{2,1}(1, :) = [1 1 1 1] ;           % wagi od pierwszej do drugiej warstwy
% net.LW{3,2} = ...            % byc moze przydadza sie wagi od drugiej do trzeciej warstwy
net.b{1} = [-2; 3.9; -2; 3];               % wartosci progowe neuronow pierwszej warstwy
net.b{2} = -4;
% new.b{3} = ...

[X,Y] = meshgrid(0:0.1:6);
ZA = X;
ZA(:) = sim(net,[X(:) Y(:)]');
surf(X,Y,ZA);
title('Klasyfikacja punktow nalezacych do prost. metoda analityczna')

% UCZENIE

% obrazy 2-wymiarowe (w kolumnach) i ich klasy  (nale¿y podaæ maksymalnie 20 obrazów ucz¹cych, 
% pozwalaj¹cych (wraz z odpowiedni¹ architektur¹ sieci i jej parametrami) na jak najwierniejsze odwzorowanie 
% zadanej funkcji klasyfikacji gdy x i y sa z przedzialu <0,6>):    

obrazy = [X(:)' ; Y(:)'];  
%obrazy = {[1;1] [1:3] [4;3] [4;1] };
klasy = (obrazy(1,:)>1) .* (obrazy(1,:)<4) .* (obrazy(2,:)>1) .* (obrazy(2,:)<3);
%zeros = [0 0 0 0];
%klasy = [klasy; zeros;zeros];
net = newff([-10 10; -10 10], [10 1],{'tansig', 'tansig'});
net.trainParam.epochs = 1000;
net.trainParam.show = 1000;
net.trainParam.goal=0.0000000001;

%t = obrazy(1, 1:4);
net = init(net);
net = train(net,obrazy,klasy);

............................
   
[X,Y] = meshgrid(0:0.1:6);
ZU = X;

ZU(:) = sim(net,[X(:) Y(:)]');
surf(X,Y,ZU);
title('Klasyfikacja punktow nalezacych do prost. metoda uczenia')


% srednia roznica pomiedzy funkcja klasyfikacji uzyskana analitycznie i metoda
% uczenia:
disp(sprintf('srednia roznica pomiedzy funkcja uzyskana analitycznie i met. uczenia = %f',mean(mean(abs(ZU-ZA)))))