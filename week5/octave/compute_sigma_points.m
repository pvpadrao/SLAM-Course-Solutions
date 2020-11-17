function [sigma_points, w_m, w_c] = compute_sigma_points(mu, sigma, lambda, alpha, beta)
% This function samples 2n+1 sigma points from the distribution given by mu and sigma
% according to the unscented transform, where n is the dimensionality of mu.
% Each column of sigma_points should represent one sigma point
% i.e. sigma_points has a dimensionality of nx2n+1.
% The corresponding weights w_m and w_c of the points are computed using lambda, alpha, and beta:
% w_m = [w_m_0, ..., w_m_2n], w_c = [w_c_0, ..., w_c_2n] (i.e. each of size 1x2n+1)
% They are later used to recover the mean and covariance respectively.

n = length(mu);
sigma_points = zeros(n,2*n+1);

% TODO: compute all sigma points

%sigma_point(0) = mean
sigma_points(:,1) = mu;
%Also possible through Cholesky decomposition using chol
sqrtm_term = sqrtm((n+lambda)*sigma);
for i = 1:n
  sigma_points(:,i+1) = mu + sqrtm_term(:,i);
endfor

for i = n + 1: 2*n
  sigma_points(:,i+1) = mu - sqrtm_term(:,i-n);
endfor

% TODO compute weight vectors w_m and w_c

%initialization of weight vectors
w_m = zeros(1, 2*n + 1);
w_c = zeros(1, 2*n + 1);

%defining w_m(0) and w_c(0)
w_m(1,1) = lambda / (n + lambda);
w_c(1,1) = w_m(1,1) + (1 - alpha^2 + beta);

%computing the remaining weight vectors
for i = 2:2*n
  w_m(1,i) = 1 / (2*(n + lambda));
  w_c(1,i) = w_m(1,i);
endfor

end
