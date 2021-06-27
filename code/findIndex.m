function [sameSOAindex,oppSOAindex,perpSOAindex] = findIndex(temp_GivenRes3,j,sameSOAindex,oppSOAindex,perpSOAindex)
%   This file is checking current Data Event Direction and updating the
%   matrix according to it with the index of current DataEvent
    if(temp_GivenRes3==7)
        sameSOAindex=[sameSOAindex,j];
    elseif(temp_GivenRes3==8)
        oppSOAindex=[oppSOAindex,j];
    elseif(temp_GivenRes3==9)
        perpSOAindex=[perpSOAindex,j];
    end

end

