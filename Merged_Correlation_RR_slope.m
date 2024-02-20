%Merging the two correlation graphs from times 290-410 and 2040-2160
%seconds into one graph

clear all; close all;clc;
% reading the signal with Fs=1000 Hz
M=dlmread('ecg_bp.txt');
% Fs=250 Hz
M=M(1:4:length(M),:);
BP=M(:,2);
ECG=M(:,4); %raising the ECG signal to the power of 4
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








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%  Butterworth Filter
[b,a]= butter(2,[7/125 20/125],'bandpass');
% filtered signal
filteredECG = filter(b,a,ECG);

%close up on 2 minutes 
Time1=T1(510000:540000);
ECG1=filteredECG(510000:540000);
ECG1=ECG1(1:end-138,1); %Syncing the lengths of ECG and BP -Deleting the last 138 samples of ECG signal


%QRS detection algorithm : FD1
X=ECG1;
Y=zeros();
for n=3:length(ECG1)-3
    Y(n)=-2*X(n-2)-X(n-1)+X(n+1)+2*X(n+2);
end
Sth=0.41*abs(max(Y));
for i=1:length(Y)
    if Y(i)>Sth
        X(i)=200000000;
        
    else
        X(i)=0;
    end
end


%Calculation of R-R interval;
ind=find(X>0);
RR8=diff(ind);
RR8=RR8/250;
P=find(RR8>0.6 );
RR8=RR8(P);
P1=find(RR8<1.5);
RR8=RR8(P1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BP-SIGNAL

%  Fir lowpass filter, wc=5 Hz
b=fir1(100, 5/125, 'low');
filteredBP=filter(b,1,BP);

%close up on 2 minutes : 2040-2160 seconds
Time2=T2(510000:540000);
part_BP=filteredBP(510000:540000);
part_BP=part_BP(138:end,1); %Syncing the lengths of ECG and BP -Deleting the first 138 samples of BP signal


%Finding minimum and maximum peaks on BP signal
% offset values of peak heights for plotting
%%figure;
[pks3,locs3] = findpeaks(part_BP,'MinPeakDistance',120);
InvBP =  (-1)* part_BP;
[pks4,locs4] =findpeaks(InvBP,'MinPeakDistance',120);
pks4=abs(pks4);

%%Fixing the lengths of locs2, locs, pks2, pks 
pks3=pks3((1:length(pks4)),1);
locs3=locs3((1:length(locs4)),1);

%Finding slope of rising part on BP signal
slope8=abs((pks3-pks4)./(locs3-locs4));

%Correcting length of RR and slope
slope8=slope8(1:length(RR8));

%Displacement of BP signal for correct syncing
figure;
subplot(2,1,1); plot(ECG1,'m');xlabel('sample [1/sec]'); ylabel('Voltage [mV]'); title('ECG signal- 5 seconds for 2040-2160 AFTER SYNCING DISPLACEMENT OF BOTH SIGNALS');xlim([1 1000]);
subplot(2,1,2); plot(part_BP);xlabel('sample [1/sec]'); ylabel('Pressure [mmHg]'); title('BP signal - 5 seconds for 2040-2160');xlim([1 1000]);
 
RR8(54)=[];
RR8(49)=[];
RR8(47)=[];
RR8(44)=[];
RR8(39)=[];
RR8(35)=[];
RR8(14)=[];
slope8(54)=[];
slope8(49)=[];
slope8(47)=[];
slope8(44)=[];
slope8(39)=[];
slope8(35)=[];
slope8(14)=[];

slope9=slope8;
RR9=RR8;

RR9(99)=[];
RR9(54)=[];
RR9(53)=[];
RR9(44)=[];
RR9(37)=[];
RR9(14)=[];
RR9(12)=[];
RR9(11)=[];
RR9(10)=[];
RR9(9)=[];
RR9(7)=[];
RR9(4)=[];
RR9(3)=[];

slope9(99)=[];
slope9(54)=[];
slope9(53)=[];
slope9(44)=[];
slope9(37)=[];
slope9(14)=[];
slope9(12)=[];
slope9(11)=[];
slope9(10)=[];
slope9(9)=[];
slope9(7)=[];
slope9(4)=[];
slope9(3)=[];

slope10=slope9;
RR10=RR9;

RR10(68)=[];
RR10(53)=[];
RR10(33)=[];
RR10(32)=[];
RR10(12)=[];
RR10(5)=[];
RR10(4)=[];
RR10(3)=[];
RR10(2)=[];

slope10(68)=[];
slope10(53)=[];
slope10(33)=[];
slope10(32)=[];
slope10(12)=[];
slope10(5)=[];
slope10(4)=[];
slope10(3)=[];
slope10(2)=[];

slope11=slope10;
RR11=RR10;

RR11(24)=[];
RR11(13)=[];
RR11(11)=[];
RR11(7)=[];
RR11(5)=[];
RR11(1)=[];
slope11(24)=[];
slope11(13)=[];
slope11(11)=[];
slope11(7)=[];
slope11(5)=[];
slope11(1)=[];

slope12=slope11;
RR12=RR11;

RR12(67)=[];
RR12(54)=[];
RR12(49)=[];
RR12(39)=[];
RR12(1)=[];
slope12(67)=[];
slope12(54)=[];
slope12(49)=[];
slope12(39)=[];
slope12(1)=[];

slope13=slope12;
RR13=RR12;

RR13(55)=[];
RR13(51)=[];
RR13(49)=[];
RR13(35)=[];
RR13(19)=[];
RR13(14)=[];
RR13(8)=[];

slope13(55)=[];
slope13(51)=[];
slope13(49)=[];
slope13(35)=[];
slope13(19)=[];
slope13(14)=[];
slope13(8)=[];

%%Merging the RR and slope vectors from time 1 and 2
RR_merge=[RR13;RR7];
slope_merge=[slope13;slope7];


figure;
scatter(RR_merge,slope_merge);
grid on;
title('Scatter graph of RR with BP slope merged');
xlabel('RR');
ylabel('BP slope');
C3=corrcoef(RR_merge, slope_merge)

% % 
% % %% matlab code 'Merged_Correlation_RR_slope.m' gives us : C=0.0873
% %  Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing for 290-410 secs: NO DELAY!!
% %  Figure 2 : close up for 5 sec on ECG and BP signal AFTER syncing for 2040-2160 secs: NO DELAY!!
% %  Figure 3 : Scatter Graph of RR with BP slope for both times 290-410 and 2040-2160 secs
