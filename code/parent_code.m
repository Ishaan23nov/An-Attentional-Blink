size_ParticipantData=size(ParticipantData,2);

%each of the below matrix will hold every DataEvent corresponding to the
%written condition for every participant
SOA1allsame=[];
SOA1allopp=[];
SOA1allperp=[];

SOA2allsame=[];
SOA2allopp=[];
SOA2allperp=[];

SOA3allsame=[];
SOA3allopp=[];
SOA3allperp=[];

incSOA1allsame=[];
incSOA1allopp=[];
incSOA1allperp=[];

incSOA2allsame=[];
incSOA2allopp=[];
incSOA2allperp=[];

incSOA3allsame=[];
incSOA3allopp=[];
incSOA3allperp=[];

%the below matrix will have all index for 2nd response correct or not
secCor=[];
secInc=[];


for i=1:size_ParticipantData
%    We are excluding these participant nos and hence just skipping them   
     if( i==8 ||i==9 || i==14 || i==17 || i==20 || i==10 || i==21 )
         continue;
     end
   
    X=ParticipantData{i};
    size_DataEvents=size(X.DataEvents,2);
    
    %each of the below matrix is a temp matrix will hold every DataEvent corresponding to the
    %written condition for a participant on each loop iteration
    sameSOA1index=[];
    oppSOA1index=[];
    perpSOA1index=[];
    sameSOA2index=[];
    oppSOA2index=[];
    perpSOA2index=[];
    sameSOA3index=[];
    oppSOA3index=[];
    perpSOA3index=[];

    incsameSOA1index=[];
    incoppSOA1index=[];
    incperpSOA1index=[];
    incsameSOA2index=[];
    incoppSOA2index=[];
    incperpSOA2index=[];
    incsameSOA3index=[];
    incoppSOA3index=[];
    incperpSOA3index=[];

    corrSecindex=[];
    incorrSecindex=[];

    if strcmp(X.DataEvents,'No Eye Data') == 0 %since we 2 student data was not recorded so checking it
       for j=1:size_DataEvents
           
            temp_DataEvent=X.DataEvents{j};
            
            %check if corrRes1 and corrRes3 exists as in some cases it
            %doesn't exists
            checkRes1=isfield(temp_DataEvent, 'GivenRes1');
            checkRes3=isfield(temp_DataEvent, 'GivenRes3');
            
            checkRes2=temp_DataEvent.GivenRes2;
             if(checkRes1==0 || (checkRes3==0 && checkRes2~=5))
                 %since checking two as there can be cases when GivenRes3 is not
                 %present and when GivenRes2 being 5
                 continue;
             end
            
            temp_SOA=temp_DataEvent.SOA;%taking SOA
            
            %Correct answer for each response
            temp_CorrRes1=temp_DataEvent.CorrRes1;
            temp_CorrRes2=temp_DataEvent.CorrRes2;
            temp_CorrRes3=0;
            
            temp_T1Dir=temp_DataEvent.T1Dir;
            temp_T2Dir=temp_DataEvent.T2Dir;
            
            %finding the answer to corrRes3 by the direction given to us
            %Also checking if the answer for the second is no or not
            if temp_CorrRes2==6
                %Giving temp_CorrRes3 value according to opposite,same and
                %perpendicular direction 
                if temp_T2Dir==temp_T1Dir
                    temp_CorrRes3=7;%same direction
                elseif abs(temp_T2Dir-temp_T1Dir)==180
                    temp_CorrRes3=8;%opposite direction
                elseif abs(temp_T2Dir-temp_T1Dir)==270 || abs(temp_T2Dir-temp_T1Dir)==90
                    temp_CorrRes3=9;%perpendicular direction
                end 
            end 
            
         
            %Given response for each DataEvent
            temp_GivenRes1=temp_DataEvent.GivenRes1;
            temp_GivenRes2=temp_DataEvent.GivenRes2;
            temp_GivenRes3=0;
            %check if there is a third response or not
            if temp_GivenRes2==6
                temp_GivenRes3=temp_DataEvent.GivenRes3;
            end
               
            %Only need to check only if the first response is correct
            if temp_CorrRes1==temp_GivenRes1
                %checking if the person has given correct response to
                %question2 ie is there a second target ?(only when the
                %correct answer is there is second target)
                if (temp_CorrRes2==5)
                    if temp_GivenRes2==temp_CorrRes2
                        corrSecindex=[corrSecindex,j];
                    else
                        incorrSecindex=[incorrSecindex,j];
                    end
                 %if there is second target check if particpant has given
                 %correct response or not
                 %here incorrect response is corresponding to situation
                 %when the participant havn't seen the 2nd target
                elseif(temp_CorrRes2==6)
                    if(temp_CorrRes3==temp_GivenRes3)%Correct answer for 2nd target direction
                        %explaination of findIndex in its function file
                        if temp_SOA==1
                            [sameSOA1index,oppSOA1index,perpSOA1index]=findIndex(temp_CorrRes3,j,sameSOA1index,oppSOA1index,perpSOA1index);   
                        elseif temp_SOA==2
                            [sameSOA2index,oppSOA2index,perpSOA2index]=findIndex(temp_CorrRes3,j,sameSOA2index,oppSOA2index,perpSOA2index);  
                        elseif temp_SOA==3 
                            [sameSOA3index,oppSOA3index,perpSOA3index]=findIndex(temp_CorrRes3,j,sameSOA3index,oppSOA3index,perpSOA3index);
                        end% temp_SOA==1 
                    elseif(temp_GivenRes2==5)%if answer given is wrong which is when particpant reported there is no second target
                        if temp_SOA==1
                            [incsameSOA1index,incoppSOA1index,incperpSOA1index]=findIndex(temp_CorrRes3,j,incsameSOA1index,incoppSOA1index,incperpSOA1index);
                        elseif temp_SOA==2
                            [incsameSOA2index,incoppSOA2index,incperpSOA2index]=findIndex(temp_CorrRes3,j,incsameSOA2index,incoppSOA2index,incperpSOA2index);
                        elseif temp_SOA==3
                            [incsameSOA3index,incoppSOA3index,incperpSOA3index]=findIndex(temp_CorrRes3,j,incsameSOA3index,incoppSOA3index,incperpSOA3index);
                        end
                    end  
                end     
            end% if on line no 120 checking if first response if correct or not
       end%if on line no 69 looping over all the Data_Events for each participant
            
       %now the matrices sameSOA1 and all will be have all indexes which is
       %following that condition
       
          %explanation of temp in its function file
          %this is for 3rd response
         [tempSOA1allsame,tempSOA1allopp,tempSOA1allperp]= temp(X,sameSOA1index,oppSOA1index,perpSOA1index);   
         [tempSOA2allsame,tempSOA2allopp,tempSOA2allperp]= temp(X,sameSOA2index,oppSOA2index,perpSOA2index);
         [tempSOA3allsame,tempSOA3allopp,tempSOA3allperp]= temp(X,sameSOA3index,oppSOA3index,perpSOA3index);
        
         [inctempSOA1allsame,inctempSOA1allopp,inctempSOA1allperp]=temp(X,incsameSOA1index,incoppSOA1index,incperpSOA1index); 
         [inctempSOA2allsame,inctempSOA2allopp,inctempSOA2allperp]=temp(X,incsameSOA2index,incoppSOA2index,incperpSOA2index);
         [inctempSOA3allsame,inctempSOA3allopp,inctempSOA3allperp]=temp(X,incsameSOA3index,incoppSOA3index,incperpSOA3index);

          %explanation of check in its function file
          %this is for 2nd response
         [tempsecCor,tempsecInc]=check(X,corrSecindex,incorrSecindex);
            
         secCor=[secCor;tempsecCor];
         secInc=[secInc;tempsecInc];
       
       
        SOA1allsame=[SOA1allsame;tempSOA1allsame];     
        SOA1allopp=[SOA1allopp;tempSOA1allopp];
        SOA1allperp=[SOA1allperp;tempSOA1allperp];
        
        SOA2allsame=[SOA2allsame;tempSOA2allsame];     
        SOA2allopp=[SOA2allopp;tempSOA2allopp];
        SOA2allperp=[SOA2allperp;tempSOA2allperp];
        
        SOA3allsame=[SOA3allsame;tempSOA3allsame];     
        SOA3allopp=[SOA3allopp;tempSOA3allopp];
        SOA3allperp=[SOA3allperp;tempSOA3allperp];
        
        incSOA1allsame=[incSOA1allsame;inctempSOA1allsame];     
        incSOA1allopp=[incSOA1allopp;inctempSOA1allopp];
        incSOA1allperp=[incSOA1allperp;inctempSOA1allperp];
        
        incSOA2allsame=[incSOA2allsame;inctempSOA2allsame];     
        incSOA2allopp=[incSOA2allopp;inctempSOA2allopp];
        incSOA2allperp=[incSOA2allperp;inctempSOA2allperp];
        
        incSOA3allsame=[incSOA3allsame;inctempSOA3allsame];     
        incSOA3allopp=[incSOA3allopp;inctempSOA3allopp];
        incSOA3allperp=[incSOA3allperp;inctempSOA3allperp];
        


    end
    


end

%so what I have done is as per the task I have written the code for
%generating the graphs and commented it so it would be easy just to
%uncomment it and plot graphs for that


% %these below lines are finding the dilate and constrict latency graphs

% ----------------------------------------------------------
%explaination of constrictLat in its file 
% latSame=constrictLat(1,SOA1allsame,SOA2allsame,SOA3allsame);
% latOpp=constrictLat(1,SOA1allopp,SOA2allopp,SOA3allopp);
% latPerp=constrictLat(1,SOA1allperp,SOA2allperp,SOA3allperp);
%    
% %explaination of dilateLat in its file 
% dilateSame=dilateLat(SOA1allsame,SOA2allsame,SOA3allsame);
% dilateOpp=dilateLat(SOA1allopp,SOA2allopp,SOA3allopp);
% dilatePerp=dilateLat(SOA1allperp,SOA2allperp,SOA3allperp);
% 

% x=[1,2,3];
% plot(x,latSame,'-r',x,latOpp,'-g',x,latPerp,'-b');
% title('Constrict Lat Correct');
% legend('SOA1','SOA2','SOA3');
% figure;
% plot(x,dilateSame,'-r',x,dilateOpp,'-g',x,dilatePerp,'-b');
% title('Dilate Lat Correct');
% legend('SOA1','SOA2','SOA3');

%-----------------------------------------------------------------

SOA1allsame=mean(SOA1allsame);
SOA1allopp=mean(SOA1allopp);
SOA1allperp=mean(SOA1allperp);

SOA2allsame=mean(SOA2allsame);
SOA2allopp=mean(SOA2allopp);
SOA2allperp=mean(SOA2allperp);

SOA3allsame=mean(SOA3allsame);
SOA3allopp=mean(SOA3allopp);
SOA3allperp=mean(SOA3allperp);

incSOA1allsame=mean(incSOA1allsame);
incSOA1allopp=mean(incSOA1allopp);
incSOA1allperp=mean(incSOA1allperp);
  
incSOA2allsame=mean(incSOA2allsame);
incSOA2allopp=mean(incSOA2allopp);
incSOA2allperp=mean(incSOA2allperp);
  
incSOA3allsame=mean(incSOA3allsame);
incSOA3allopp=mean(incSOA3allopp);
incSOA3allperp=mean(incSOA3allperp);




%generating graphs for one target vs two targets
%-------------------------------------------------------------------------

%Tar2=(SOA1allsame+SOA2allsame+SOA3allsame)+(SOA1allopp+SOA2allopp+SOA3allopp)+(SOA1allperp+SOA2allperp+SOA3allperp);
% Tar2=Tar2/9;
% 
%  Tar2ndSame=(SOA1allsame+SOA2allsame+SOA3allsame);
%  Tar2ndOpp=(SOA1allopp+SOA2allopp+SOA3allopp);
%  Tar2ndPerp=(SOA1allperp+SOA2allperp+SOA3allperp);
%   
%  Tar2ndSame=Tar2ndSame/3;
%  Tar2ndOpp=Tar2ndOpp/3;
%  Tar2ndPerp=Tar2ndPerp/3;
%  
%  secCor=mean(secCor);
%  time=[1:1:1401];
%  
% % plot(time,secCor,time,Tar2);
% % 
%  plot(time,secCor,'k',time,Tar2ndSame,'-r',time,Tar2ndOpp,'-g',time,Tar2ndPerp,'-b');
% title('One target vs Two target');
% legend('one target', 'two Target');

%--------------------------------------------------------------------------



plot(time,SOA1allsame,'-r',time,SOA1allopp,'-g',time,SOA1allperp,'-b',time,incSOA1allsame,'-.r',time,incSOA1allopp,'-.g',time,incSOA1allperp,'-.b');
% % xline(200);
% % %xline(406,'-.r');
% % %xline(613,'-.g');
% % %xline(819,'-.b');
% % yline(0);
% % ylim([-0.04 0.02]);
% % title('SOA1');
% % legend('Same','Opp','Perp','incSame','incOpp','incPerp','T1start');
figure;
%  
plot(time,SOA2allsame,'-r',time,SOA2allopp,'-g',time,SOA2allperp,'-b',time,incSOA2allsame,'-.r',time,incSOA2allopp,'-.g',time,incSOA2allperp,'-.b');
% % xline(200);
% % xline(406,'-.r');
% % xline(613,'-.r');
% % xline(819,'-.b');
% % yline(0);
% % ylim([-0.04 0.02]);
% % title('SOA2');
% % legend('Same','Opp','Perp','incSame','incOpp','incPerp','T1start');
figure;
%       
plot(time,SOA3allsame,'-r',time,SOA3allopp,'-g',time,SOA3allperp,'-b',time,incSOA3allsame,'-.r',time,incSOA3allopp,'-.g',time,incSOA3allperp,'-.b');
% % xline(200);
% % yline(0);
% % xline(406,'-.r');
% % xline(613,'-.g');
% % xline(819,'-.r');
% % ylim([-0.04 0.02]);
% % title('SOA3');
% % legend('Same','Opp','Perp','incSame','incOpp','incPerp','T1start');



