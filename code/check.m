function[valueCorr,valueIncorr]=check(X,corr2index,incorr2index)


%In this function file we are reading the values of each participant till
%1400 points. We are also doing convolution and normalization in this file
%only.

%valueCorr,valueIncorr will be containing all the values. We are
%adding new row for each DataEvent which is following that condition.
%For Example if sameSOAindex have 5 indexes then valueSame would be having
%5 rows each row containing data till 1400 points    

    BCfilter=0.1*ones(1,10);
    valueCorr=[];
    for i=1:size(corr2index,2)
        tempIndex=corr2index(i);
        tempEP=X.DataEvents{tempIndex}.EP;
        tempStart=tempEP.T1_start;
        SmoothData1=conv(tempEP.PD,BCfilter,'Same');
        
        tempValue=SmoothData1(tempStart-200:tempStart+1200);
        divide=mean(SmoothData1(1:tempStart));%taking mean of points for normalizing
        %to check if PD values are zeros or not since we are dividing by
        %divide so we can get Nan
        if(divide~=zeros(1))
            tempValue=(tempValue-divide)/divide;
        end
        valueCorr=[valueCorr;tempValue];%adding next 1400 point to next line
    
    end

    valueIncorr=[];
    for i=1:size(incorr2index,2)
        tempIndex=incorr2index(i);
        tempEP=X.DataEvents{tempIndex}.EP;
        tempStart=tempEP.T1_start;
        SmoothData2=conv(tempEP.PD,BCfilter,'Same');
        
        tempValue=SmoothData2(tempStart-200:tempStart+1200);
        divide=mean(SmoothData2(1:tempStart));%taking mean of points for normalizing
        %to check if PD values are zeros or not since we are dividing by
        %divide so we can get Nan
        if(divide~=zeros(1))
            tempValue=(tempValue-divide)/divide;
        end
        valueIncorr=[valueIncorr;tempValue];%adding next 1400 point to next line
    end

    
end 