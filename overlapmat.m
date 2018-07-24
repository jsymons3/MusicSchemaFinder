function [ overm ] = overlapmat( concm,concb, midi, beats )
%Finds overlaps in two concordances 
% nlistdesc should be used as concm for melody
% nlistdesc should be used as concb for bass
% midi is the original nmat with an added final column indicating piece
% number
% beats sets a threshold cooccurence
%matrices output by python application
%mellocs4 = csvread(concm,0,1);   % import csv upper voice (or else use matrix variables) 
%basslocs4 = csvread(concb,0,1);



d1 = size(basslocs4,1);
d2 = size(mellocs4,1);

overm = zeros(d1,d2);%d1,d2);
for jj = 1:size(basslocs4,1)
    
    iBass = basslocs4(jj,:);
    iBassg = iBass(find(iBass>0));
    onset2 = midi((iBassg),1);   %onset2 is your time in beats of bass part
    for kk = 1:1000%size(mellocs4,1)
        iMel = mellocs4(kk,:);
        iMelg = iMel(find(iMel>0));
        onsetmel = midi((iMelg),1); %onsetmel is mel time
        for ii = 1:length(onset2)
             ilength = [];
             isize = find(abs(onsetmel - onset2(ii))<=beats); %beat threshold
             ilength = length(isize);
             totover(ii) = ilength; %number of overlaps
        
        end
        overm(jj,kk) = sum(totover);
        totover = [];
    end
end
