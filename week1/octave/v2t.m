%Takes as input the vector form of the robot pose and outputs the corresponding
%homogeneous transformation

% A robot pose in a given frame is compactly represented as: 
% v_3x1 = (x; y; theta;)

function [M] = v2t(v)
  
 % M = [R t; 0 1]
  
  theta = v(3);
  
  M = [cos(theta) -sin(theta) v(1);
       sin(theta) cos(theta)  v(2);
       0         0            1];
       
endfunction
