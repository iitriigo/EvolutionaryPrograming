clc;
clear all;
close all;

%DOIC - ALINEA 1 

Pmin = xlsread('trabalho1.xlsx','Folha1','B3:B6');
Pmax = xlsread('trabalho1.xlsx','Folha1','C3:C6');
a = xlsread('trabalho1.xlsx','Folha1','D3:D6');
b = xlsread('trabalho1.xlsx','Folha1','E3:E6');
c = xlsread('trabalho1.xlsx','Folha1','F3:F6');
sigma = xlsread('trabalho1.xlsx','Folha1','G3');
Pc = xlsread('trabalho1.xlsx','Folha1','H3');
i = xlsread('trabalho1.xlsx','Folha1','I3');
j = xlsread('trabalho1.xlsx','Folha1','J3');
k = xlsread('trabalho1.xlsx','Folha1','K3');
pop = xlsread('trabalho1.xlsx','Folha1','L3');
M1 = xlsread('trabalho1.xlsx','Folha1','M3');
M2 = xlsread('trabalho1.xlsx','Folha1','N3');
tau = xlsread('trabalho1.xlsx','Folha1','O3');
nger = xlsread('trabalho1.xlsx','Folha1','P3');
niter_max = xlsread('trabalho1.xlsx','Folha1','Q3');


superpop=pop*2;
count=0;
P=zeros(nger,pop);
custo_sp=zeros(1,pop);
custo_cp=zeros(1,pop);
sigma=zeros(1,pop);
Pmelhor=zeros(nger,pop);
sigmamelhor=zeros(1,pop);
customelhor=zeros(1,pop);
sigma_iter=zeros(1,pop);
vec_P11=zeros(1,pop);
vec_P12=zeros(1,pop);
vec_P41=zeros(1,pop);
vec_P42=zeros(1,pop);


t1 = cputime;


%Gerar solução inical
for j = 1: pop
    for i = 1:nger  
        P(i,j)=rand()*(Pmax(i,1)-Pmin(i))+Pmin(i);
        sigma(1,j)=0.1;
    end
end

%correcao da geracao de maneira a Pg=Pc
for j = 1: pop
    total=0;
    for i=1:nger
        total=total+P(i,j);
    end
    
    if (total ~= Pc)   
       for i=1:nger
            P(i,j)=P(i,j)*(Pc/total);
       end
    end
end

%calculo do custo sem penalizações de cada coluna
for j=1:pop
    custo_sp(1,j)=0;
    for i = 1:nger
        custo_sp(1,j)=custo_sp(1,j)+a(i)+b(i)*P(i,j)+c(i)*P(i,j)*P(i,j);
    end
end

 custo_cp(1,j)=custo_sp(1,j);

%calculo do custo com penalizações de cada coluna
for j=1:pop
    custo_cp(1,j)=0;
    for i = 1:nger
        if (P(i,j) > Pmax(i,1))
            custo_cp(1,j)=custo_sp(1,j)+M1*(P(i,j)-Pmax(i,1));
        end
        if (P(i,j)<Pmin(i))
            custo_cp(1,j)=custo_sp(1,j)+M2*(Pmin(i)-P(i,j));
        end
    end
end


for k = 1: niter_max

superpop=pop*2;
%************clonar***********
    for j = 1 : pop
        for i = 1 : nger
              P(i,pop+j)= P(i,j);
        end
        sigma(1,pop+j)=sigma(1,j);
        custo_cp(1,pop+j)=custo_cp(1,j);
    end

%**********mutar*************
    for j = (pop+1):superpop
        sigma(1,j)=sigma(1,j)*(1+tau*norminv(rand(),0,1));
        for i = 1 : nger
             P(i,j)=P(i,j)+sigma(1,j)*norminv(rand(),0,1);
        end
    end
    %corrigir de maneira a pc=pg
    for j = (1+pop) : superpop
    tot=0;
    
        for i=1: nger
            tot=tot+P(i,j);
        end
    
       if (tot ~= Pc)   
            for i=1:nger
              P(i,j)=P(i,j)*(Pc/tot);
            end
       end
    end

%calcular o custo sem penalizações depois de mutado
    for j=(pop+1):superpop
        custo_sp(1,j)=0;
        for i = 1:nger
              custo_sp(1,j)=custo_sp(1,j)+a(i)+b(i)*P(i,j)+c(i)*P(i,j)*P(i,j);
        end
    end

%calculo do custo com penalizações depois de mutado
    for j=(pop+1):superpop
        custo_cp(1,j)=0;
        for i = 1:nger
            if (P(i,j) > Pmax(i,1))
                 custo_cp(1,j)=custo_sp(1,j)+M1*(P(i,j)-Pmax(i,1));
            end
            if (P(i,j)<Pmin(i))
                custo_cp(1,j)=custo_sp(1,j)+M2*(Pmin(i,1)-P(i,j));
            end
        end
    end
 
%**********avaliar*************
for j=1:superpop
     soma=0;   
   %Verificar limite máximo dos geradores
    for i=1:nger
        if P(i,j)>Pmax(i,1)
            excesso=P(i,j)-Pmax(i,1);
            soma=soma+excesso;
            P(i,j)=Pmax(i,1);
        end
   end
    
     if soma>0
        folga=sum(Pmax)-sum(P(:,j));
        for i=1:nger
            P(i,j)=P(i,j)+(Pmax(i,1)-P(i,j))*soma/folga;
        end
    end
    
    %Verificar limite minimo dos geradores
    soma = 0;
    for i=1:nger
        if P(i,j)<Pmin(i,1)
            excesso=Pmin(i,1)-P(i,j);
            soma=soma+excesso;
            P(i,j)=Pmin(i,1);
        end
    end
    
    if soma>0
        folga=sum(P(:,j))-sum(Pmin);
        for i=1:nger
            P(i,j)=P(i,j)-(P(i,j)-Pmin(i,1))*soma/folga;
        end
    end
end

    for j=1:superpop
        custo_cp(1,j)=0;
        for i=1:nger
             custo_cp(1,j)=custo_cp(1,j)+a(i,1)+b(i,1)*P(i,j)+c(i,1)*P(i,j)^2;
        end
    end

    
%***********SELECIONAR*****************    
aux=inf;
pos=0;

for aux2 = 1 : pop 
    
        %ver qual o valor minimo do vetor custo e guardar a posição
        for j = 1 : superpop
             if (custo_cp(1,j) < aux)
                aux = custo_cp(1,j);
                pos = j;
             end
        end
            %copiar para vetor auxiliar

        for i= 1: nger
            Pmelhor(i,aux2) = P(i,pos);
        end

        sigmamelhor(1,aux2) = sigma(1,pos);
        customelhor(1,aux2) = custo_cp(1,pos);

        %apagar coluna correspondente ao minimo encontrado (na potencia, sigma e
        %custo)
        P(:,pos)=[];
        sigma(:,pos)=[];
        custo_cp(:,pos)=[];

        superpop = superpop-1;
        aux=inf;
    end
    
    P = Pmelhor;
    sigma = sigmamelhor;
    custo_cp = customelhor;
    
    %guardar o custo de cada iteração
   
    
         G_aux = [P;custo_cp;sigma];
         G_aux = transpose(G_aux);
         G_aux = sortrows (G_aux,nger+2);
         G_aux = transpose (G_aux);
         
         custo_cp = G_aux(nger+1,1:(pop));
         P = G_aux(1:nger,1:(pop));
         sigma = G_aux(nger+2,1:(pop));

      custo_iter(1,k)=custo_cp(1,1); 
      sigma_iter(1,k)=sigma(1,1);
      
    vec_P11(1,k)=P(1,1);
    vec_P12(1,k)=P(2,1);
    vec_P41(1,k)=P(3,1);
    vec_P42(1,k)=P(4,1);
    num_iter(1,k)=k;
      
    %CRITÉRIO DE PARAGEM
if k>=2
    if custo_iter(k-1)~=custo_iter(k)
        count=0;
    elseif custo_iter(k-1)==custo_iter(k)
        count=count+1;
    end
    if count==100
        break;
    end
end
end
tempo=cputime-t1


disp('DOIC 2013/1014 - Programação Evolucionária')
disp('Trabalho 1 - Alínea 1')

disp('Melhor solução:')
disp('P =')
disp(P(1:4,1))
disp('Custo [R/MWh] =')
disp(custo_cp(1,1))

figure(1)
plot(num_iter,custo_iter)
title('Evolução do Custo do Melhor Indivíduo')
xlabel('Nº da Iteração')
ylabel('Custo [R/MWh]')
figure(2)
plot(num_iter, vec_P11, num_iter, vec_P12, num_iter, vec_P41, num_iter, vec_P42)
title('Evolução do Despacho do Melhor Indivíduo')
legend('G11', 'G12','G41','G42')
xlabel('Nº da Iteração')
ylabel('Taxa de Mutação')
figure(3)
plot(sigma_iter)
title('Evolução da Taxa de Mutação do Melhor Indivíduo')
xlabel('Nº da Iteração')
ylabel('Taxa de Mutação')

