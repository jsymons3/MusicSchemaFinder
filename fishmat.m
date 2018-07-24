function [ pmat ] = fishmat( mat )

% input is the overlap matrix
% output gives you a pmat of the first 10 X 10 

%        R       NR
%  pos   a        c       K
%  neg   b        d       -
% total  N        -       M
%
% a,b,c,d are the numbers of positive and negative results for the cases
% and controls. K, N, M are the row, column and grand totals.
%
% This function returns a pvalue against the null hypothesis that a
% responders out of K sampled is likely if the population sample has N out
% of M. A small p-value is taken as evidence that a/K differs from N/M.
%
%
% usage
%   p = fexact(X,y)
%       y is a vetor of status (1=case/0=control). X is a MxP matrix of
%       binary results (pos=1/neg=0). P can be very large for
%       genotyping assays, each of which can be considered a different way
%       to categorize the cases and controls.
%
%  p = fexact( a,M,K,N, options)
%      This version is intended for use when you start with a contingency
%      matrix rather than raw test results and outcomes. N is the number of
%      positive outcomes (scalar). M is the total number of observations. a
%      and K are P-vectors. No checks for valid input are made.
%
M = sum(sum(mat));

pmat = zeros(10);
for ii = 1:10    % feel free to change this to a larger number to get a bigger matrix. 
    %Setting too large introduces issues for hypothesis testing. (Either
    %test one by one or use correction.)
    K = sum(mat(ii,:));

    for jj = 1:10 % feel free to change this as well. 
        N = sum(mat(:,jj));
        a = mat(ii,jj);
        pmat(ii,jj) = fexact( a,M,K,N);
        
  
    end

end

