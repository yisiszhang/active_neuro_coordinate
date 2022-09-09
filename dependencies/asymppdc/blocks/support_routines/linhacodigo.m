function x=linhacodigo(T);
x=' ';
[a,b]=find(T'~=0);
for i=1:11, 
    if i==1, 
        bold=b(i);
        x=[x int2str(T(b(i),a(i))) ' '];
    else
         if bold~=b(i)
             bold=b(i);
             x=[x ' | ' int2str(T(b(i),a(i))) ' '];
         else
             x=[x int2str(T(b(i),a(i))) ' '];
         end
    end
   
   % x=[x int2str(T(b(i),a(i))) ' ']
    
    
%      pause

end