function Tb=phase(u1,u2,v1,v2)
% phase(u1,u2,v1,v2)
% Computes the bissector orientation field of 
% X = (u1,u2)
% Y = (v1,v2)
a=atan2(u2,u1);
b=atan2(v2,v1);
Tb=mod((a+b)/2,pi);
end
