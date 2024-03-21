function X=mean_inputting(X, maxnan)
if nargin < 2
    maxnan = 100; %default
end
n = nanmean(X);
nn = isnan(X);
ii = sum(nn) < maxnan;
z = X(:,ii);
z(nn(:,ii)) =  nonzeros(bsxfun(@times,nn(:,ii),n(ii)));
X(:,ii) = z;
X=X;