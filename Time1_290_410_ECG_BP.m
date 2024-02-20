%Segment 290-410 seconds 
%close up on 2 minutes  - 290-410sec , threshold:0.30, filter:8-20 Hz


clear all; close all;clc;
% reading the signal with Fs=1000 Hz
M=dlmread('ecg_bp.txt');
% Fs=250 Hz
M=M(1:4:length(M),:);
BP=M(:,2);
ECG=M(:,4).^4; %raising the ECG signal to the power of 4
T1=M(:,1);
T2=M(:,3);

%  Butterworth Filter
[b,a]= butter(2,[8/125 20/125],'bandpass');
% filtered signal
filteredECG = filter(b,a,ECG);

 %displaying the original and filtered ECG signal for the whole 2400 second
 figure;
 subplot(2,1,1); plot(T1,ECG); title('The original ECG signal raised to the power of 4'); xlabel('time [sec]'); ylabel('Voltage [mV]');
 subplot(2,1,2); plot(T1,filteredECG,'m'); title('The filtered ECG signal raised to the power of 4'); xlabel('time [sec]'); ylabel('Voltage [mV]');


%close up on 2 minutes : 290-410 seconds
Time1=T1(72500:102500);
ECG1=filteredECG(72500:102500);


%QRS detection algorithm : FD1
X=ECG1;
Y=zeros();
for n=3:length(ECG1)-3
    Y(n)=-2*X(n-2)-X(n-1)+X(n+1)+2*X(n+2);
end
Sth=0.3*abs(max(Y));
for i=1:length(Y)
    if Y(i)>Sth
        X(i)=200000000;
        
    else
        X(i)=0;
    end
end

figure;
plot(Time1,X,'r',Time1,ECG1);
title('QRS detection on filtered signal from 290 - 410 seconds');
xlabel('time[sec]');
ylabel('ECG signal with QRS detection [mV]');
xlim([290 410]);


%Calculation of R-R interval;
ind=find(X>0);
RR=diff(ind);
RR=RR/250;
P=find(RR>0.65 );
RR=RR(P);
P1=find(RR<1);
RR=RR(P1);

figure;
plot(RR)
title('RR interval as a function of beat number : 290 - 410 seconds');
xlabel('Beat Number');
ylabel('RR length');
ylim([-3 3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BP-SIGNAL

%  Fir lowpass filter, wc=5 Hz
b=fir1(100, 5/125, 'low');
filteredBP=filter(b,1,BP);

%displaying the original and filtered BP signal for the whole 2400 second
figure;
subplot(2,1,1); plot(T1,BP); title('The original BPsignal'); xlabel('time [sec]'); ylabel('Pressure [mmHg]');
subplot(2,1,2); plot(T1,filteredBP,'m'); title('The filtered BP signal'); xlabel('time [sec]'); ylabel('Pressure [mmHg]');

%close up on 2 minutes : 290-410 seconds
Time2=T2(72500:102500);
part_BP=filteredBP(72500:102500);

%Finding minimum and maximum peaks on BP signal
% offset values of peak heights for plotting
figure;
[pks,locs] = findpeaks(part_BP,'MinPeakDistance',120);
plot(Time2,part_BP); hold on;
plot(Time2(locs),pks+0.05,'k^','markerfacecolor',[1 0 0]);hold on;
InvBP =  (-1)* part_BP;
[pks2,locs2] =findpeaks(InvBP,'MinPeakDistance',120);
pks2=abs(pks2);
plot(Time2(locs2),pks2+0.05,'k^','markerfacecolor',[1 0 0]);
title('Maxima and Minima peaks detected on BP Signal : 290-410 seconds');
xlabel('Time[secs]');
xlim([290 410]);
ylabel('BP[mmHg]');

%%Fixing the lengths of locs2, locs, pks2, pks 
pks=pks((1:length(pks2)),1);
locs=locs((1:length(locs2)),1);

%Finding slope of rising part on BP signal
slope=abs((pks-pks2)./(locs-locs2));
figure;
plot(slope);
title('Slope of BP signal as a function of beat number : 290-410 seconds');
xlabel('Beat Number');
ylabel('BP rising slope');
ylim([-3 3]);


%Displacement of BP signal for correct syncing-BEFORE (the after is in the
%correaltion matlab code)
figure;
subplot(2,1,1); plot(ECG1,'m');xlabel('sample [1/sec]'); ylabel('Voltage [mV]'); title('ECG signal- 5 seconds for 290-410 BEFORE SYNCING DISPLACEMENT OF BOTH SIGNALS');xlim([1 1000]);
subplot(2,1,2); plot(part_BP);xlabel('sample [1/sec]'); ylabel('Pressure [mmHg]'); title('BP signal - 5 seconds for 290-410');xlim([1 1000]);
 
%%%%%EXPLANATION
% % % %% matlab code 'Time1_290_410_ECG_BP' gives us:
% % % Figure 1 : subplot of : Original ECG signal raised to the power of 4, Filtered ECG signal raised to the power of 4
% % % Figure 2 : QRS detection of filtered ECG signal from 290-410 seconds
% % % Figure 3 : RR interval as a function of beat number -290-410 seconds
% % % Figure 4 : subplot of : The original BP signal, the filtered BP signal
% % % Figure 5 : Maxima and Minima peaks detected on BP signal - 290-410 seconds
% % % Figure 6 : Slope of BP as a function of beat number - 290-410 seconds
% % % Figure 7 : Close up on 5 seconds BEFORE syncing the 2 signals in order to get a valid comparison in correlation



