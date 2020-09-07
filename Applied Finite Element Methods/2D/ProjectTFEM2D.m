clear all
geometry = @circleg;
hmax = 1/2;
[p,e,t] = initmesh(geometry, 'hmax', hmax);
f = @(x1,x2) 8*(pi^2)*sin(2*pi*x1)*sin(2*pi*x2);
np = size(p,2);

for i = 1:length(p)
    u_exact(i) = sin(2*pi*p(1,i))*sin(2*pi*p(2,i));
end
        

Stiff = AssembleStiffness2D(p,t);
Load = AssembleLoad2D(p,t,f);
boundaryNode = unique([e(1,:) e(2,:)]);
interiorNode = setdiff(1:length(p),boundaryNode);
l1 = length(Load);
Load = Load(interiorNode)-Stiff(interiorNode,boundaryNode)*u_exact(1:length(e))';
l2 = length(Load);
u_h(interiorNode) = Stiff(interiorNode,interiorNode)\Load;
u_h(boundaryNode) = u_exact(1:length(e));
err = u_exact-u_h;
EnE = sqrt(err*Stiff*err');
trisurf(t(1:3,:)',p(1,:)',p(2,:)',u_h)
v =[-0.1377 -0.1527 -0.1041 -0.0191 0.0885 0.2106 0.3423 0.4803 0.6225 0.7672 0.9133 1.0600 1.2067 1.3531 1.4986 1.6432 1.7866 1.9286 2.0692 2.2083 2.3458 2.4817 2.6159 2.7485 2.8794 3.0086 3.1361 3.2620 3.3863];