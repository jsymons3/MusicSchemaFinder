function [  ngramfreq, nlistdesc] = concordancer( midi, ngramsize, int, bassormel )
% This algorithm takes an nmat with an extra final column added for piece number
%  midi: refers to the nmat used
%  ngramsize: set to 4 for four part ngram e.g. (0,-1,-3,-5) etc, set to 3
%  for 3-grams, etc.
%  int: interval size in beats
%  bassormel: set to on or 0 
% nlistdesc is ngram types (rows), along with corresponding positions (columns).
% ngramfreq is a list of ngram types, with the final column indicating the
% total frequency of the type

midi(:,9) = 1:size(midi,1);
bassmel= midi((midi(:,3) > bassormel - .001 & midi(:,3) < bassormel + .001 ),:);  % isolates the parts of the nmat that are tracks 1 or 0
A = bassmel(:,1);  % note onsets in beats
B = bassmel(:,4);  % note onset pitches
P = bassmel(:,8);  % piece number
Indx = bassmel(:,9);   % find the original index in the file
n =0;   
C=[0,0,0,0];
for ii = 1:length(bassmel(:,3));
    z = int;
    count = 0;
    for k = 0:(ngramsize-1)
        if ~isempty(A(find(A > A(ii)+z*k-.001 & A < A(ii)+z*k+.001)))
            ca = find(A > A(ii)+z*k-.001 & A < A(ii)+z*k+.001); % get indices
            if ~isempty(ca(find(P(ca) > P(ii)-.001 & P(ca) < P(ii)+.001)))   % make sure that the piece is the same
                result = ca(find(P(ca) > P(ii)-.001 & P(ca) < P(ii)+.001));   % make sure there is one result
                %for jj = 1:length(result)   % allow for expansion for multiple
                %simultaneous tracks
                    res1 = result(1);
                    C(1,k+1)  =  B(ii)-B(res1) ;% 
               % end
                count = count +1 ;
                if count==ngramsize
                    n = n+1 ;
                    
                    bassormeltypes(n,1:ngramsize) = C(1,1:ngramsize);
                    bassormelplace(n) = Indx(ii);
                end                
            end
        end
        if mod(ii,1000) == 1
            ii/length(bassmel(:,3)) % display progress
        end
    end
end
[gC,ia,ic] = unique(bassormeltypes,'rows');
% we must find the frequency of the unique types
nlist = zeros(size(gC,1), 1);
for ii = 1:length(bassormelplace)      
indx = (ic(ii)); 
    if ~isempty(find( nlist(indx, :) == 0))   
        aaa = find( nlist(indx, :) == 0);     
        bbb = min(aaa);
         nlist(indx, bbb) = bassormelplace(ii);
    else
	nlist = horzcat(nlist, zeros(length(gC),1));
    nlist(indx, size(nlist,2)) = bassormelplace(ii);
    end
end
for ii = 1:size(nlist,1)    
as(ii) = nnz(nlist(ii,:));    
end
[B2,I2]= sort(as);  
sortmat = zeros(size(gC));
sortnlist = zeros(size(nlist));
for ii = 1:size(gC,1)
sortmat(ii,:) = (gC(I2(ii),:));
sortnlist(ii,:) = (nlist(I2(ii),:));
end
ngramfreq = horzcat(flipud(sortmat), rot90(B2));  % reorient and combine
nlistdesc = flipud(sortnlist);

