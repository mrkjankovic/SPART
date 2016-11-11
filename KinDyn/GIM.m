function [H0, H0m, Hm] = GIM(M0_tilde,Mm_tilde,Bij,Bi0,P0,pm,robot) %#codegen
% Computes the Generalized Inertia Matrix of a Serial Manipulator.
%
% Input ->
%   M0_tilde -> Base-spacecraft mass matrix of composite body.
%   Mm_tilde -> Manipulator mass matrix of composite body.
%   Bij -> Twist-propagation matrix (for manipulator i>0 and j>0).
%   Bi0 -> Twist-propagation matrix (for i>0 and j=0).
%   P0 -> Base-spacecraft twist-propagation vector.
%   pm -> Manipulator twist-propagation vector.
%   robot -> Robot model
%
% Output ->
%   H0 -> Base-spacecraft inertia matrix.
%   H0m -> Base-spacecraft - manipulator coupling inertia matrix.
%   Hm -> Manipulator inertia matrix.

%=== LICENSE ===%


%=== CODE ===%

%--- Number of links and Joints ---%
n=robot.n_links;

%--- H Martix ---%
%Base-spacecraft Inertia matrix
H0 = P0'*M0_tilde*P0;
if not(isempty(coder.target)) %Only use during code generation (allowing symbolic computations)
    %Pre-allocate Hm
    Hm=zeros(n,n);
end
%Manipulator Inertia matrix Hm
for j=1:n
    for i=j:n
        Hm(i,j)=pm(1:6,i)'*Mm_tilde(1:6,1:6,i)*Bij(1:6,1:6,i,j)*pm(1:6,j);
        Hm(j,i)=Hm(i,j);
    end
end
if not(isempty(coder.target)) %Only use during code generation (allowing symbolic computations)
    %Pre-allocate H0m
    H0m=zeros(6,n);
end
%Coupling Inertia matrix
for i=1:n
    H0m(1:6,i)=(pm(1:6,i)'*Mm_tilde(1:6,1:6,i)*Bi0(1:6,1:6,i)*P0)';
end

end