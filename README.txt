README:

V1.0.1

This is a grammar induction algorithm built in Matlab to analyze patterns in music MIDI files converted to note matrices. Part 1 builds a list of all the regular (i.e. isochronous) interval patterns in a piece. Part 2 finds unusual coincidences of melody and bass patterns and calculates the probability of these items occurring together as an artifact of chance. If the probability is low, we can assume that that combination is important to the workings of that style of music. 

First, run concordancer on a note matrix. Then run overlapmat on the output of concordancer. Finally test for significance using fishmat (This performs a Fisher exact test to compute a p-value for the bass/melody combination in question).
