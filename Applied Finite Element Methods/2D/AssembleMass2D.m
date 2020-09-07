function [M] = AssembleMass2D(p,t)
%From book "The Finite Element Method:Theory, Implementation, and Practice"
%by Mats G. Larsson and Fredrik Bengzon
np = size(p,2);
nt = size(t,2);
M = sparse(np,np);
for i = 1:nt
    loc2glb = t(1:3,i);
    x1 = p(1,loc2glb);
    x2 = p(2,loc2glb);
    area = polyarea(x1,x2);
    Mi =  [2 1 1; 1 2 1; 1 1 2]*area/12;
    M(loc2glb,loc2glb) = M(loc2glb,loc2glb)+Mi;
end
end

