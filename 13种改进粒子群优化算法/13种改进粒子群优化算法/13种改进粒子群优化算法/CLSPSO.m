function [xm,fv] = CLSPSO(fitness,N,c1,c2,w,xmax,xmin,M,MaxC,D)

format long;

%------��ʼ����Ⱥ�ĸ���------------

for i=1:N

    for j=1:D

        x(i,j)=randn;  %�����ʼ��λ��

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
        
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));

        x(i,:)=x(i,:)+v(i,:);
        
        fv(i) = fitness(x(i,:));
        
    end
    
    [sort_fv,index] = sort(fv);
    
    Nbest = floor(N*0.2); 
    
    for n=1:Nbest
        
        tmpx = x(index(n),:);
        
        for k=1:MaxC
            
            for dim=1:D
                
                cx(dim) = (tmpx(1,dim) - xmin(dim))/(tmpx(1,dim) - xmax(dim));
                
                cx(dim) = 4*cx(dim)*(1 - cx(dim));
                
                tmpx(1,dim) = tmpx(1,dim) + cx(dim)*(xmax(dim) - xmin(dim));
                
            end
            
            fcs = fitness(tmpx);
            
            if fcs < sort_fv(n)
                
                x(index(n),:) = tmpx;
                
                break;
                
            end
                       
        end
         
        x(index(n),:) = tmpx;
        
    end
    
    r = rand();
    
    for s=1:D
        
        xmin(s) = max(xmin(s) , pg(s) - r*(xmax(s) - xmin(s)));
        
        xmax(s) = min(xmax(s) , pg(s) + r*(xmax(s) - xmin(s)));
        
    end
    
    x(1:Nbest, :) = x(index(1:Nbest),:);
    
    for i=(Nbest+1):N

        for j=1:D

            x(i,j)= xmin(j) + rand*(xmax(j) - xmin(j));  %�����ʼ��λ��

            v(i,j)= randn;  %�����ʼ���ٶ�

        end

    end
    
    Pbest(t)=fitness(pg);
    
    for i=1:N

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);
            
        end


        if p(i)<fitness(pg)

            pg=y(i,:);

        end
        
    end

end

xm = pg';

fv = fitness(pg);



