%Segment 290-410 seconds -CORRELATION 0.6037
%close up on 2 minutes  - 290-410sec , threshold:0.30, filter:8-20 Hz


clear all; close all;clc;
% reading the signal with Fs=1000 Hz
M=dlmread('ecg_bp.txt');
% Fs=250 Hz
M=M(1:4:length(M),:);
BP=M(:,2);
ECG=M(:,4); 
T1=M(:,1);
T2=M(:,3);

%  Butterworth Filter
[b,a]= butter(2,[8/125 20/125],'bandpass');
% filtered signal
filteredECG = filter(b,a,ECG);

%close up on 2 minutes 
Time1=T1(72500:102500);
ECG1=filteredECG(72500:102500);
ECG1=ECG1(1:end-112,1); %Syncing the lengths of ECG and BP -Deleting the last 112 samples of ECG signal



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

%Calculation of R-R interval;
ind=find(X>0);
RR=diff(ind);
RR=RR/250;
P=find(RR>0.65 );
RR=RR(P);
P1=find(RR<1);
RR=RR(P1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BP-SIGNAL

%  Fir lowpass filter, wc=5 Hz
b=fir1(100, 5/125, 'low');
filteredBP=filter(b,1,BP);

%close up on 2 minutes : 290-410 seconds
Time2=T2(72500:102500);
part_BP=filteredBP(72500:102500);
part_BP=part_BP(112:end,1); %Syncing the lengths of ECG and BP -Deleting the first 112 samples of BP signal

%Finding minimum and maximum peaks on BP signal
% offset values of peak heights for plotting
%%figure;
[pks,locs] = findpeaks(part_BP,'MinPeakDistance',120);
InvBP =  (-1)* part_BP;
[pks2,locs2] =findpeaks(InvBP,'MinPeakDistance',120);
pks2=abs(pks2);

%%Fixing the lengths of locs2, locs, pks2, pks 
pks=pks((1:length(pks2)),1);
locs=locs((1:length(locs2)),1);

%Finding slope of rising part on BP signal
slope=abs((pks-pks2)./(locs-locs2));

%Correcting length of RR and slope
slope=slope(1:length(RR));

%Displacement of BP signal for correct syncing
figure;
subplot(2,1,1); plot(ECG1,'m'); xlim([1 500]);xlabel('sample [1/sec]'); ylabel('Voltage [mV]'); title('ECG signal 290-410 for 5 secs- AFTER SYNCING DISPLACEMENT OF BOTH SIGNALS');
subplot(2,1,2); plot(part_BP); xlim([1 500]);xlabel('sample [1/sec]'); ylabel('Pressure [mmHg]'); title('BP signal - 5 secs');
 
RR(125)=[];
RR(118)=[];
RR(111)=[];
RR(110)=[];
RR(105)=[];
RR(103)=[];
RR(102)=[];
slope(125)=[];
slope(118)=[];
slope(111)=[];
slope(110)=[];
slope(105)=[];
slope(103)=[];
slope(102)=[];

slope2=slope;
RR2=RR;

RR2(120)=[];
RR2(116)=[];
RR2(94)=[];
RR2(86)=[];
RR2(86)=[];
RR2(78)=[];
RR2(77)=[];
slope2(120)=[];
slope2(116)=[];
slope2(94)=[];
slope2(86)=[];
slope2(86)=[];
slope2(78)=[];
slope2(77)=[];

slope3=slope2;
RR3=RR2;


RR3(107)=[];
RR3(89)=[];
RR3(83)=[];
RR3(69)=[];
RR3(68)=[];
RR3(8)=[];
RR3(6)=[];
slope3(107)=[];
slope3(89)=[];
slope3(83)=[];
slope3(69)=[];
slope3(68)=[];
slope3(8)=[];
slope3(6)=[];

slope4=slope3;
RR4=RR3;

RR4(117)=[];
RR4(100)=[];
RR4(95)=[];
RR4(84)=[];
RR4(73)=[];
RR4(72)=[];
RR4(7)=[];
RR4(6)=[];
RR4(4)=[];
RR4(1)=[];
slope4(117)=[];
slope4(100)=[];
slope4(95)=[];
slope4(84)=[];
slope4(73)=[];
slope4(72)=[];
slope4(7)=[];
slope4(6)=[];
slope4(4)=[];
slope4(1)=[];

slope5=slope4;
RR5=RR4;

RR5(92)=[];
RR5(88)=[];
RR5(63)=[];
RR5(62)=[];
RR5(51)=[];
RR5(8)=[];
RR5(6)=[];
RR5(3)=[];
slope5(92)=[];
slope5(88)=[];
slope5(63)=[];
slope5(62)=[];
slope5(51)=[];
slope5(8)=[];
slope5(6)=[];
slope5(3)=[];

slope6=slope5;
RR6=RR5;

RR6(82)=[];
RR6(67)=[];
RR6(5)=[];
slope6(82)=[];
slope6(66)=[];
slope6(5)=[];

slope7=slope6;
RR7=RR6;



figure;
scatter(RR7,slope7);
grid on;
title('Scatter graph of RR with BP slope : 290-410')
xlabel('RR');
ylabel('BP slope');
C=corrcoef(RR7, slope7)


% % 
% % %% matlab code 'Correlation_Time1_290_410' gives us :
% %  Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing : NO DELAY!!
% %  Figure 2 :Scatter Graph of RR with BP slope: 290-410 secs
