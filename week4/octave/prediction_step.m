function [mu, sigma] = prediction_step(mu, sigma, u, mapSigma)
% Updates the belief concerning the robot pose according to the motion model,
% mu: 2N+3 x 1 vector representing the state mean
% sigma: 2N+3 x 2N+3 covariance matrix
% u: odometry reading (r1, t, r2)
% Use u.r1, u.t, and u.r2 to access the rotation and translation values

theta = normalize_angle(u.t);

% TODO: Compute the new mu based on the noise-free (odometry-based) motion model
% Remember to normalize theta after the update (hint: use the function normalize_angle available in tools)
%mu = [x; y; theta];

%x
mu(1,1) = mu(1) + u.t*cos(mu(3) + u.r1);
%y
mu(2,1) = mu(2) + u.t*sin(mu(3) + u.r1);
%theta
mu(3,1) = mu(3) + u.r1 + u.r2;
mu(3,1) = normalize_angle(mu(3,1));



% TODO: Compute the 3x3 Jacobian Gx of the motion model

Gx = eye(3) + [0 0 -u.t*sin(theta + u.r1); 
               0 0 u.t*sin(theta + u.r1);
               0 0 0];
               
    
% TODO: Construct the full Jacobian G
n = size(sigma,2); % = 21
G = [Gx zeros(3, n-3); zeros(n-3, 3), eye(n-3)];

% Motion noise
motionNoise = 0.1;
R3 = [motionNoise, 0, 0; 
     0, motionNoise, 0; 
     0, 0, motionNoise/10];
R = zeros(size(sigma,1));
% motion noise added to the states (x, y, theta)
R(1:3,1:3) = R3; 

% TODO: Compute the predicted sigma after incorporating the motion
sigma = G *sigma * G' + R;

end
