function [ B ] = AssembleLoad2D( p,t,f )
%From book "The Finite Element Method:Theory, Implementation, and Practice"
%by Mats G. Larsson and Fredrik Bengzon
np = size(p,2);
nt = size(t,2);
B = zeros(np,1);
for i = 1:nt
    loc2glb = t(1:3,i);
    x1 = p(1,loc2glb);
    x2 = p(2,loc2glb);
    area = polyarea(x1,x2);
    Bi = [f(x1(1),x2(1)); f(x1(2),x2(2)); f(x1(3),x2(3))]*area/3;
    B(loc2glb) = B(loc2glb)+Bi;

end
end

