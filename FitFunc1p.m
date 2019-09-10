function [n, red ]= FitFunc1p (x)
warning off

% load pacientestrain.dat
% load pacientestarg.dat
% 
% x=pacientestrain;
% ta=pacientestarg;

load pacicvdtrn.dat
load pacicvdtarg.dat

xx= pacicvdtrn;
%ta= pacitar1;

sexo = xx(1,:);
edad = xx(2,:)/100;
sys= xx(3,:)/162;
fuma=xx(4,:);
diab=xx(5,:);
imc= xx(6,:)/100;
trata=xx(7,:);

x1=[sexo; edad; sys; fuma; diab; imc; trata];
ta1=pacicvdtarg/100;



disp('Iniciando Entrenamiento...');
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIMER MODULO %%%%%%%%%%%%%%%%%%%%%%%%%%
        
          disp('Inicia Modulo 1...');
%           
%           if(Chrom(i,1)==1)%Monolitica
%              display('Red monolitica en construccion')
%           elseif (Chrom(i,1)==2) % Modular
              if(x(1,1)==1)% 1 modulo y  1 capa
                  net=newff(minmax(x1),[x(1,2),2],{'tansig','purelin','logsig'},'trainlm');
              end
              
              if(x(1,1)==2)% 1 modulo y  2 capa
                  net=newff(minmax(x1),[x(1,2),x(1,3),2],{'tansig','tansig','purelin','purelin','logsig'},'trainlm');
              end
              

              net.LW{2,1} = net.LW{2,1}*0.05;
              net.b{2}=net.b{2}*0.01;
              net.trainParam.show=NaN;
              net.trainParam.goal=1e-7;
              net.trainParam.lr=0.001;
              net.trainParam.epochs = 250;
              net.trainParam.showWindow=0;
              [net,tr1]=train(net,x1,ta1);
          
          disp('Fin del entrenamiento de la Red monolitica');
          
   fnob2fpa();

   red=net;
   %filename = [ 'best' num2str(k1) '.mat' ];
% save(filename)
  n=errorestbsa;





