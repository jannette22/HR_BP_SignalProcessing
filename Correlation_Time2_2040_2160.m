%Segment 2040-2160 seconds - CORRELATION
%close up on 2 minutes  - 2040-2160 sec , threshold:0.41, filter:7-20 Hz


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
RR2=diff(ind);
RR2=RR2/250;
P=find(RR2>0.6 );
RR2=RR2(P);
P1=find(RR2<1.5);
RR2=RR2(P1);


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
slope2=abs((pks3-pks4)./(locs3-locs4));

%Correcting length of RR and slope
slope2=slope2(1:length(RR2));

%Displacement of BP signal for correct syncing
figure;
subplot(2,1,1); plot(ECG1,'m');xlabel('sample [1/sec]'); ylabel('Voltage [mV]'); title('ECG signal- 5 seconds for 2040-2160 AFTER SYNCING DISPLACEMENT OF BOTH SIGNALS');xlim([1 1000]);
subplot(2,1,2); plot(part_BP);xlabel('sample [1/sec]'); ylabel('Pressure [mmHg]'); title('BP signal - 5 seconds for 2040-2160');xlim([1 1000]);
 
RR2(54)=[];
RR2(49)=[];
RR2(47)=[];
RR2(44)=[];
RR2(39)=[];
RR2(35)=[];
RR2(14)=[];
slope2(54)=[];
slope2(49)=[];
slope2(47)=[];
slope2(44)=[];
slope2(39)=[];
slope2(35)=[];
slope2(14)=[];

slope3=slope2;
RR3=RR2;

RR3(99)=[];
RR3(54)=[];
RR3(53)=[];
RR3(44)=[];
RR3(37)=[];
RR3(14)=[];
RR3(12)=[];
RR3(11)=[];
RR3(10)=[];
RR3(9)=[];
RR3(7)=[];
RR3(4)=[];
RR3(3)=[];

slope3(99)=[];
slope3(54)=[];
slope3(53)=[];
slope3(44)=[];
slope3(37)=[];
slope3(14)=[];
slope3(12)=[];
slope3(11)=[];
slope3(10)=[];
slope3(9)=[];
slope3(7)=[];
slope3(4)=[];
slope3(3)=[];

slope4=slope3;
RR4=RR3;

RR4(68)=[];
RR4(53)=[];
RR4(33)=[];
RR4(32)=[];
RR4(12)=[];
RR4(5)=[];
RR4(4)=[];
RR4(3)=[];
RR4(2)=[];

slope4(68)=[];
slope4(53)=[];
slope4(33)=[];
slope4(32)=[];
slope4(12)=[];
slope4(5)=[];
slope4(4)=[];
slope4(3)=[];
slope4(2)=[];

slope5=slope4;
RR5=RR4;

RR5(24)=[];
RR5(13)=[];
RR5(11)=[];
RR5(7)=[];
RR5(5)=[];
RR5(1)=[];
slope5(24)=[];
slope5(13)=[];
slope5(11)=[];
slope5(7)=[];
slope5(5)=[];
slope5(1)=[];

slope6=slope5;
RR6=RR5;

RR6(67)=[];
RR6(54)=[];
RR6(49)=[];
RR6(39)=[];
RR6(1)=[];
slope6(67)=[];
slope6(54)=[];
slope6(49)=[];
slope6(39)=[];
slope6(1)=[];

slope7=slope6;
RR7=RR6;

RR7(55)=[];
RR7(51)=[];
RR7(49)=[];
RR7(35)=[];
RR7(19)=[];
RR7(14)=[];
RR7(8)=[];

slope7(55)=[];
slope7(51)=[];
slope7(49)=[];
slope7(35)=[];
slope7(19)=[];
slope7(14)=[];
slope7(8)=[];




figure;
scatter(RR7,slope7);
grid on;
title('Scatter graph of RR with BP slope : 2040-2160');
xlabel('RR');
ylabel('BP slope');
C2=corrcoef(RR7, slope7)

%%%% matlab code 'Correlation_Time2_2040_2160' gives us : C=0.5949
%%Figure 1 : close up for 5 sec on ECG and BP signal AFTER syncing : NO DELAY!!
%%Figure 2 :Scatter Graph of RR with BP slope: 2040-2160secs

