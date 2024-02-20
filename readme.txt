Correlation between Heart rate and the slope of diastolic - systolic blood pressure
MATLAB R2011b (7.13.0.564)
64-BIT (WIN64)
August 14, 2011
License Number: 161052

%% matlab code 'Time1_290_410_ECG_BP.m' gives us :
 Figure 1 : subplot of : Original ECG signal raised to the power of 4, Filtered ECG signal raised to the power of 4
 Figure 2 : QRS detection of filtered ECG signal from 290-410 seconds
 Figure 3 : RR interval as a function of beat number -290-410 seconds
 Figure 4 : subplot of : The original BP signal, the filtered BP signal
 Figure 5 : Maxima and Minima peaks detected on BP signal - 290-410 seconds
 Figure 6 : Slope of BP as a function of beat number - 290-410 seconds
 Figure 7 : Close up on 5 seconds BEFORE syncing the 2 signals in order to get a valid comparison in correlation


%% matlab code 'Time2_2040_2160_ECG_BP.m' gives us :
 Figure 1 : subplot of : Original ECG signal raised to the power of 4, Filtered ECG signal raised to the power of 4
 Figure 2 : QRS detection of filtered ECG signal from 2040-2160 seconds
 Figure 3 : RR interval as a function of beat number -2040-2160 seconds
 Figure 4 : subplot of : The original BP signal, the filtered BP signal
 Figure 5 : Maxima and Minima peaks detected on BP signal - 2040-2160 seconds
 Figure 6 : Slope of BP as a function of beat number - 2040-2160 seconds
 Figure 7 : Close up on 5 seconds BEFORE syncing the 2 signals in order to get a valid comparison in correlation

%% matlab code 'Correlation_Time1_290_410.m' gives us : C=0.6037
 Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing : NO DELAY!!
 Figure 2 : Scatter Graph of RR with BP slope: 290-410 secs

%% matlab code 'Correlation_Time2_2040_2160.m' gives us : C=0.5949
 Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing : NO DELAY!!
 Figure 2 : Scatter Graph of RR with BP slope: 2040-2160secs

%% matlab code 'Merged_Correlation_RR_slope.m' gives us : C=0.0873
 Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing for 290-410 secs: NO DELAY!!
 Figure 2 : close up for 5 sec on ECG and BP signal AFTER syncing for 2040-2160 secs: NO DELAY!!
 Figure 3 : Scatter Graph of RR with BP slope for both times 290-410 and 2040-2160 secs