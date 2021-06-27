function [output1] = constrictLat(startIndex,arr1,arr2,arr3)
%this function is for finding the point where h==1
%this is done for three arrays at the same time
%also the startIndex is 1
    
    for i=startIndex:1400-1
        [h,p]=ttest(arr1(:,i),arr1(:,i+1));
        if h==1     
            break;
        end
    end
    
    for j=startIndex:1400-1
        [h,p]=ttest(arr2(:,j),arr2(:,j+1));
        if h==1
            break;
        end
    end
    
    for k=startIndex:1400-1
        [h,p]=ttest(arr3(:,k),arr3(:,k+1));
        if h==1
            break;
        end
    end
    
   
output1 = [i,j,k];

end
