function [A] = AssembleStiffness2D(p,t)
%From book "The Finite Element Method:Theory, Implementation, and Practice"
%by Mats G. Larsson and Fredrik Bengzon

np = size(p,2);
nt = size(t,2);
A = sparse(np,np);
for i = 1:nt
    loc2glb = t(1:3,i);
    x1 = p(1,loc2glb);
    x2 = p(2,loc2glb);
    [area,b,c] = Gradient(x1,x2);
       Ai =(b*b'+c*c')*area;
    A(loc2glb,loc2glb) = A(loc2glb,loc2glb)+Ai;
end
end

