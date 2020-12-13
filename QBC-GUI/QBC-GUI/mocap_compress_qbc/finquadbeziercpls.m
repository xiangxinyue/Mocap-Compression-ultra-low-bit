% % Find the middle Control Point of Quadratic Bezier Curve by
% % least square method to fit the given data
% % INPUT
% % Data: A set of "n" points (p1,p2,...pn).
% % Each point can be in N-dimension vector space
% % i.e. points to be approximated by Cubic Bezier Curve
% %       e.g. p for 3D p=[0   5   0;      % p1
% %                        1   5   0.5;    % p2
% %                        1.3 4.5 1.5;    % p3
% %                        2   5   2]      % p4
% % ptype(optional arg): parameterization type, defualt is chord-length
% % parameterization. user can pass 'u' or 'uniform', for uniform parameterization.
% 
% % OUTPUT
% % P0, P1, P2: Three Control Points, each in N-dimension space
% % t: parameterized values 

% % SOLUTION
% % Least Square Method Uniform/Chord-length Parameterization.
% % (P0 & P2) are end points of a bezier curve segment. So they
% % are taken equal to first and last point of data. 
% % P1 is are obtained by partially differeciating the Sum of Square
% % distance between original data and parametric curve w.r.t P1  then
% % solving for unknown P1.

function [P0, P1, P2, t]= finquadbeziercpls(p,varargin)

%%% Default Values %%%
ptype='';
defaultValues = {ptype};
%%% Assign Valus %%%
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[ptype] = deal(defaultValues{:});
%%%------------------------------

n=size(p,1);              % number of rows in p

if (strcmpi(ptype,'u') || strcmpi(ptype,'uniform') )
    t=linspace(0,1,n);      % uniform parameterized values (normalized b/w 0 to 1)
else
    t=ChordLengthNormND(p); % chord-length parameterized values (normalized b/w 0 to 1)
end

P0=p(1,:);     % (at t=0 => P0=p1)
P2=p(n,:);     % (at t=1 => P2=pn)

if (n==1)      % if only one value in p
   P1=P0;      % P1=P0   
elseif (n==2)  % if only two values in p
   P1=P0;      % P1=P0
elseif (n==3)  % if only three values in p
   P1=p(2,:);    % middle point is P1
else           
    Denom=0; %Denominator
    Num=0;   %Numerator
    for i=1:n      
        % Quadratic Bezier Basis 
        B0 = (1-t(i))^2         ;        
        B1 = ( 2*t(i)*(1-t(i)) );
        B2 = t(i)^2             ;
        
        Denom=Denom+B1;
        Num = Num + ( p(i,:) - B0*P0 - B2*P2 ); 
    end           
    if(Denom==0)
        P1=P0;
    else
        P1=Num/Denom;
    end
end            % END of if-elseif-else conditon

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
