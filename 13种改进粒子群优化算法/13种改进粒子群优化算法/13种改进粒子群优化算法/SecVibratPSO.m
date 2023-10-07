function [xm,fv] = SecVibratPSO(fitness,N,w,c1,c2,M,D)

format long;

%------��ʼ����Ⱥ�ĸ���------------

for i=1:N

    for j=1:D

        x(i,j)=randn;  %�����ʼ��λ��
        
        xl(i,j)=randn;

        v(i,j)=randn;  %�����ʼ���ٶ�

    end

end

%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg----------------------

for i=1:N

    p(i)=fitness(x(i,:));

    y(i,:)=x(i,:);

end

pg = x(N,:);             %PgΪȫ������

for i=1:(N-1)

    if fitness(x(i,:))<fitness(pg)

        pg=x(i,:);

    end

end

%------������Ҫѭ�������չ�ʽ���ε���------------

for t=1:M

    for i=1:N
        phi1 = c1*rand();
        phi2 = c2*rand();
        if t < M/2  
            ks1 = (2*sqrt(phi1)-1)*rand()/phi1;
            ks2 = (2*sqrt(phi2)-1)*rand()/phi2;
        else
            ks1 = (2*sqrt(phi1)-1)*(1 + rand())/phi1;
            ks2 = (2*sqrt(phi2)-1)*(1 + rand())/phi2;
        end
            
        v(i,:)=w*v(i,:)+phi1*(y(i,:)-(1+ks1)*x(i,:)+ks1*xl(i,:))+ ...
                 phi2*(pg-(1+ks2)*x(i,:)+ks1*xl(i,:));
        
        xl(i,:) = x(i,:);

        x(i,:)=x(i,:)+v(i,:);

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end

    end
 
    Pbest(t)=fitness(pg);
    
end
xm = pg';
fv = fitness(pg);



