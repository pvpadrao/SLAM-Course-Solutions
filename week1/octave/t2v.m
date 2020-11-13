function [p] = t2v(M)

p = [M(1,end); M(2, end); acos(M(1,1))];
end