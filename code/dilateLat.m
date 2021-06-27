function [output1] = dilateLat(arr1,arr2,arr3)
%This file is for finding dilate latency

[x1,I1]=min(min(arr1));
[x2,I2]=min(min(arr1));
[x3,I3]=min(min(arr1));

%sometimes the value is coming out to 1401 so it won't go in loop 
%that's why initliazing the index with 1399 

if(I1>1400)
    I1=1399;
end
if(I2>1400)
    I2=1399;
end
if(I3>1400)
    I3=1399;
end

    for i=I1:1401-1
        [h,p]=ttest(arr1(:,i),arr1(:,i+1));
        if h==1 
            break;
        end
    end
    
    for j=I2:1401-1
        [h,p]=ttest(arr2(:,j),arr2(:,j+1));
        if h==1
            break;
        end
    end
    
    for k=I3:1401-1
        [h,p]=ttest(arr3(:,k),arr3(:,k+1));
        if h==1
            break;
        end
    end
    
    
output1 = [i,j,k];

end

