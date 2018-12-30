%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Program Details: An implementation of the forward and feedback comb  filtering 
% Output signal yFF produces feedforward filtering and fFB produces feedback filtering
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%



clear all;
clc;
[x,Fs]=audioread('Mozart.wav');
%Start stopwatch
tic 
%Checking for stereo file
if size(x,2)==2                            %detects if stereo or mono
    x = sum(x,2)/size(x,2);                %convert to mono
end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%the number of samples of delay in the comb filter
M=round(0.2*Fs);
%the ?strength? of the effect
g=0.7;
%Length of input vector
l=length(x);
%Initialise output signal of feedback filter
yFB=zeros(length(x),1);
%Initialise output signal of feedforward filter
yFF=zeros(length(x),1);
%-------------------------------------------------------------------------%
%INITIALISE VALUES UPTO M for feedforward output
for n=1:M
    yFF(n)=x(n);
    
end
%-------------------------------------------------------------------------%
%FEEDFORWARD CONSTRUCTION
for n=M+1:l
    yFF(n) = x(n) + x(n-M)*g;   %y(n)=x(n)+x(n-M)g . formula

 %FEEDBACK CONSTRUCTION

   yFB(n) = x(n)- yFB(n-M)*g;   %y(n)=x(n)-y(n-M)g
end
%-------------------------------------------------------------------------%
%Output Sound%% 
%Uncomment either for sound of feedforward or feeback filter output

%soundsc(yFF,Fs);           %output sound of FeedForward
soundsc (yFB,Fs) ;           %Output sound of Feedback  
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%%Plot
fig1=figure(1);
set(fig1, 'Position', get(0,'Screensize'));

%Column 1
%Input wave plot
subplot(3,3,1);
plot(x);
title('Input Wave');
xlabel('Time');
ylabel('Amplitude');
 
%output signal FeedForward wave plot
subplot(3,3,4);
plot(yFF);
title('FeedForward filter');
xlabel('Time');
ylabel('Amplitude');

%output signal Feedback wave plot
subplot(3,3,7);
plot(yFB);
title('FeedBack Filter');
xlabel('Time');
ylabel('Amplitude');
%-------------------------------------------------------------------------%

%Column 2

%Input wave magnitude
f1=(0:1/Fs:(l-1)/Fs);
subplot(3,3,2);
plot(f1,abs(fft((x))));
title('Input Wave');
xlabel('Frequency');
ylabel('Magnitude');

%output signal FeedForward wave magnitude
subplot(3,3,5);
f2=(0:1/Fs:(l-1)/Fs);
plot(f1,abs(fft(yFF)));
title('FeedForward');
xlabel('Frequency');
ylabel('Magnitude');

%output signal Feedback wave magnitude
subplot(3,3,8);
f3=(0:1/Fs:(length(yFB)-1)/Fs);
plot(f3,abs(fft(yFB)));
title('FeedBack');
xlabel('Frequency');
ylabel('Magnitude');
%-------------------------------------------------------------------------%
%Column 3

%In terms of dB
%Input signal magnitude in terms of dB
subplot(3,3,3);
plot(f1,mag2db(x));       %magnitude to dbconversion-> 20log10(x)
title('Input Wave');
xlabel('Frequency');
ylabel('Magnitude in dB');

%Output signal feedforward magnitude in terms of dB
subplot(3,3,6);
plot(f2,mag2db(yFF));      %magnitude to dbconversion-> 20log10(yFF)
title('FeedForward');
xlabel('Frequency');
ylabel('Magnitude in dB');


%Output signal feedback magnitude in terms of dB
subplot(3,3,9);
plot(f3,mag2db(yFB));     %magnitude to dbconversion-> 20log10(yFB)
title('FeedBack');
xlabel('Frequency');
ylabel('Magnitude in dB');


%-------------------------------------------------------------------------%
toc
%-------------------------------------------------------------------------%


