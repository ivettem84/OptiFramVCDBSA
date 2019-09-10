clc;
clear;

load('pacicvdreal.dat')
x=pacicvdreal;
% edad = x(1,:)/100;
% sexo = x(2,:);
% imc= x(3,:)/100;
% sisto= x(4,:)/162;
% dias=x(5,:)/115;
% fuma=x(6,:);
% padre= x(7,:)/2;

sexo = x(1,:);
edad = x(2,:);
sys= x(3,:);
fuma=x(4,:);
diab=x(5,:);
bmi= x(6,:);

paciente=[sexo; edad; sys; fuma; bmi; diab];

for i=1: length(paciente)
    
    sexo = paciente(1,i);
    edad = paciente(2,i);
    sys= paciente(3,i);
    fuma=paciente(4,i);
    diab=paciente(6,i);
    bmi= paciente(5,i);
    
    if sexo==0
        suma=log(edad) * 2.72107 + log(sys)* 2.81291 + (fuma*0.61868) + log(bmi)*0.51125 + (diab*0.77763) ;
        riesgo=1-power(0.94833, exp((suma)-26.0145));
        Riesgo=riesgo*100;

        hedad=exp(-((2.81291*log(sys)+0.61868*fuma+0.51125*log(bmi)+0.77763*diab)-26.0145)/2.72107);
        coef=power((-log(0.94833)),(1/2.72107));
        hedad1=(hedad)*(1/coef);
        hedad2=1*(1/2.72107);
        hedad4=power((-log(1-riesgo)),hedad2);

    else 
        
        suma=log(edad) * 3.11296 + log(sys)* 1.85508  + (fuma*0.70953) + log(bmi)*0.79277 + (diab*0.5316) ;
        riesgo=1-power(0.88431, exp((suma)-23.9388));
        Riesgo=riesgo*100;

        hedad=exp(-((1.85508*log(sys)+0.70953*fuma+0.79277*log(bmi)+0.5316*diab)-23.9388)/3.11296);
        coef=power((-log(0.88431)),(1/3.11296));
        hedad1=(hedad)*(1/coef);
        hedad2=1*(1/3.11296);
        hedad4=power((-log(1-riesgo)),hedad2);

    end
    Riesgo1(i)=round(Riesgo,1);
    edadc(i)=round(hedad1*hedad4);
    

end