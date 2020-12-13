% % Interpolation of Quadratic Bezier Curve for given three control points and
% % optionally with given parameter 't'. 
% % Each control point can be in N-Dimensional vector space.

% INPUT:
% P0,P1,P2 : Three control points of bezier curve
% t : vector values of t paramter at which bezier curve is evaluated 
%   (optional argument) default 101 values between 0 and 1.

% OUTPUT:
% Q: Evaluated values of bezier curve . Number of columns of Q are equal to
% number of coordinates in control point. For example for 2-D, Q has two
% columns. Column 1 for x value and column 2 for y values. Similarly for
% 3-D, Q will have three columns

function Q=quadbezierintrp(P0,P1,P2,varargin)

% % % Default Values
t=linspace(0,1,101); % uniform parameterization 
defaultValues = {t};
% % % Assign Values 
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[t] = deal(defaultValues{:});
% % % -----------------------------------------------------------

% % Equation of Quadratic Bezier Curve at for paramter 't' 
% % Q(t)=(1-t)^2*P0 + 2*t*(1-t)*P1 + t^2*P2

for i=1:length(t)
    Q(i,:)=(1-t(i))^2.*P0 + 2*t(i)*(1-t(i)).*P1 + t(i)^2.*P2;
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


