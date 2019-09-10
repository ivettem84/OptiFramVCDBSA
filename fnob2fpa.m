%SIMULACION DE DATOS ENTRENADOS
% at1=sim(net,x);
% at1=(at1*ns);
%TS=(TS*ns)

load pac50trn.dat
load pac50tst.dat

x1=pac50trn;

sexo = x1(1,:);
edad = x1(2,:)/100;
sys= x1(3,:)/162;
fuma=x1(4,:);
diab=x1(5,:);
imc= x1(6,:)/100;
trata=x1(7,:);

pn2=[sexo; edad; sys; fuma; diab; imc; trata];

rtarg=pac50tst;
num=length(rtarg);

%SIMULANDO DATOS PRONOSTICADOS
entr=sim(net,pn2);
sim1 = entr*100;
%sim2=round(sim1);

errorestbsa= mymse(rtarg,sim1);


