

for k1= 1 : 1
%if nargin < 1
    %FitFunc = @Sphere;
 M =[58 52 47 42 39 36 33 31 29 27 26 24 23 22 21 20 19 19 18 17 17 16 16 15 15 14 14 13 13];
    pop = [16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74]; %se tienen que poner arriba de 10 individuos para que no marque error
    dim = 3;   
    FQ = randi([1,15],1,1);  
    c1 = [0.4 0.6 1.4 1.8 0.2 1.9 2 3.48 1.22 3.2 3.15 0.8 2.84 0.5 1.44 4 0.9 ...
           1.18 2.4 3 0.9 2 1.88 3.12 2.5 3.44 3.7 2.83 1.56 4];
    c2 = [0.4 0.6 1.4 1.8 0.2 1.9 2 3.48 1.22 3.2 3.15 0.8 2.84 0.5 1.44 4 0.9 ...
           1.18 2.4 3 0.9 2 1.88 3.12 2.5 3.44 3.7 2.83 1.56 4];
    a1 = [0.2 1.33 0.9 0.4 0.1 1.2 1 1.42 0.75 1.25 1.95 0.6 1.3 0.9 1.6 1.4 0.9 0.6 2 1 ... 
          0.4 0.9 1.6 0.4 1.2 1.8 0.7 0.5 2 1.7];
    a2 = [0.2 1.33 0.9 0.4 0.1 1.2 1 1.42 0.75 1.25 1.95 0.6 1.3 0.9 1.6 1.4 0.9 0.6 2 1 ... 
          0.4 0.9 1.6 0.4 1.2 1.8 0.7 0.5 2 1.7];
%end

M=M(k1);
pop=pop(k1);
c1=c1(k1);
c2=c2(k1);
a1=a1(k1);
a2=a2(k1);

comienza=now;

% set the parameters
lb= [1 1 1];   % Lower bounds
ub= [2 30 30];    % Upper bounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s1=pwd; %Identify current folder
% s2=['\erroresBSA1408-' num2str(k1) '.txt'];
% %s2='\erroresBSA2610(2).txt';
% dir = strcat(s1,s2);
% %--crear arhivo para guardar errores
% errord= fopen(dir, 'wt');
tic;

[ bestX, fMin, bestnn, bestnnall ] = BSA2( M, pop, dim, FQ, c1, c2, a1, a2, lb,ub )

tiempo = toc/60; 
tiempos = toc; 
arquitec(k1).nn = bestnn;
arquitec(k1).best = fMin;
arquitec(k1).capas = bestX;
arquitec(k1).tiempo = tiempo;
arquitec(k1).M= M;
arquitec(k1).pop = pop;
arquitec(k1).FQ = FQ;
arquitec(k1).c1 = c1;
arquitec(k1).c2 = c2;
arquitec(k1).a1= a1;
arquitec(k1).a2 = a2;
arquitec(k1).bestnnall = bestnnall;
save('redesBSA0909.mat','arquitec');


termina=now;%%%%%%%%% TIEMPO FINAL
%fprintf(errord,['\n----------------------------------------\n\n']);
%fprintf(errord,['Best Solution:' num2str(bestX) ' fmin=',num2str(fMin) '   BSA time:', datestr(termina-comienza,'HH:MM:SS') '\n']);
disp(['Total number of evaluations: ',num2str(M*pop)]);
disp(['Best solution=',num2str(bestX),'   fmin=',num2str(fMin) '   BSA time:', datestr(termina-comienza,'HH:MM:SS')]);

%filename = [ 'nnBSA1409-' num2str(k1) ];
%save(filename)





end
