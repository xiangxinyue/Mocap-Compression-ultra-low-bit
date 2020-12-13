% i stands for index, v stands for value
% mat1=[v11,v12,...v1m
%       ........... 
%       vn1,vn2,...vnm]
% mat2=[i1,i2,...ij
%       v1,v2,...vj]
% If kth row of mat1 that mataches values (v1,v2,...vj) at columns number
% (i1,i2,...ij) specified in mat2 then return at most (k-r)th row to (k+r)th row of mat1 as MatOut.
% where (k-r) >=1 and (k+r) <= length(mat1)
% Returns empty matrix if no row is found that matched all values
% (v1,v2,...vj).
function [MatOut]=FindGivenRangeMatchedMat(mat1,mat2,r)
MatOut=[];
k=0;
[r1 c1]=size(mat1);
[r2 c2]=size(mat2);
if (r2~=2)
    disp('Message from FindGivenRangeMatchedMat.m');
    disp('second argument matrix must have two rows');
    return
end

if (c1<c2)
    disp('Message from FindGivenRangeMatchedMat.m');
    disp('numer of columns in second argument matrix must be less than or equal to first argument matrix');
    return
end

for i=1:r1
    flag=1;
  for j=1:c2
      if( mat1(i,mat2(1,j))~=mat2(2,j) )
          flag=0;
          break;
      end      
  end
  if(flag)
      k=i; % found row with values (v1,v2,...vj)
  end
end

if (k~=0)
    x=k-r;
    y=k+r;
    if ( x < 1 )  % backward out of range so we would return from row number 1
        x=1;
    end
    if ( y > r1 ) % forward out of range so we would return until last row
        y=r1;
    end
    MatOut=mat1(x:y,:);       
end





% % % ---------------------------------------------------------------
% % Reference:
% % Reference:
% Murtaza Ali Khan, "An efficient algorithm for compression of motion
% capture signal using multidimensional quadratic Bezier  curve
% break-and-fit method", Multidimensional Systems and Signal Processing,
% Springer journal, August 2014,
% DOI 10.1007/s11045-014-0293-4.
% http://link.springer.com/article/10.1007/s11045-014-0293-4

% % Reference BibTeX
% @Article{Khan2014,
% author="Khan, Murtaza Ali",
% title="An efficient algorithm for compression of motion capture signal using multidimensional quadratic Bezier curve break-and-fit method",
% journal="Multidimensional Systems and Signal Processing",
% year="2014",
% volume="27",
% number="1",
% pages="121--143",
% issn="1573-0824",
% doi="10.1007/s11045-014-0293-4",
% url="http://dx.doi.org/10.1007/s11045-014-0293-4"
% }
% % % ---------------------------------------------------------------
% % This program or any other program(s) supplied with it do(es) not
% % provide any warranty direct or implied.
% % This program is free to use/share for non-commerical purpose only. 
% % Kindly reference the author.
% % Thanking you.
% % @ Copyright: Dr. Murtaza Ali Khan
% % Email: drkhanmurtaza@gmail.com
% % LinkedIn: http://www.linkedin.com/pub/dr-murtaza-khan/19/680/3b3
% % ResearchGate: http://www.researchgate.net/profile/Murtaza_Khan2/
% % % --------------------------------------------------------------- 
