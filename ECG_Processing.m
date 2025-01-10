%% ECG_Processing
% Author: Lauryn Peters
% Date: April 05, 2024

% Purpose: To use data collected from three leads of an elecrocardiogram (ECG)
% attached to a person during rest ("relaxed" data set) and during a physical
% activity ("active" data set). The data is used to isolate a heartbeat, find the PQRST waves
% of the isolated heartbeat, calculate the average heart rate for relaxed
% and active sets, calculate the values for the aVL, aVR, and aVF leads, and
% plot relevant graphs. 

close all; clear all; clc;

%% Load Data
relax = readtable("relaxed.csv");
active = readtable("active.csv");

relax.Time = (0:0.0005:(size(relax, 1)-1)*0.0005)';
active.Time = (0:0.0005:(size(active, 1)-1)*0.0005)';

% Trim data to remove initial recording noise
relax = relax(8001:end, :);
active = active(8001:end, :);

%% Part 1 

% Plot consistent data from the middle of the recordings 
figure(1)

% Plot relaxed data
subplot(2,1,1)
plot(relax.Time, relax.ECG1)
title('Relaxed ECG')
xlabel('Time (s)')
ylabel('Voltage (mV)')
hold on
plot(relax.Time, relax.ECG2)
plot(relax.Time, relax.ECG3)
xlim([10, 30])
ylim([-0.4, 0.4])
hold off

% Plot active data 
subplot(2,1,2)
plot(active.Time, active.ECG1)
title('Active ECG')
xlabel('Time (s)')
ylabel('Voltage (mV)')
hold on
plot(active.Time, active.ECG2)
plot(active.Time, active.ECG3)
xlim([10,30])
ylim([-0.4, 0.4])
hold off

%% Part 2

% Find time stamps to isolate a heartbeat 
time_single = relax.Time(relax.Time >= 4.5 & relax.Time <= 5.5);
heartbeat = relax.ECG2(relax.Time >= 4.5 & relax.Time <= 5.5);

% Find and plot peaks and troughs 
[pks, pk_idx] = findpeaks(heartbeat, MinPeakProminence=0.05);
%findpeaks(heartbeat, MinPeakProminence=0.05) % displays all peaks
[trough, trough_idx] = findpeaks(-heartbeat, MinPeakProminence=0.11);
%findpeaks(-heartbeat, MinPeakProminence=0.11) % displays all troughs

% Find indices of PQRST waves
wave_idx = [pk_idx([1:2,4]); trough_idx(2:3)];

% Plot PQRST waves of a single heartbeat
figure(2)

plot(time_single, heartbeat, '-o', 'MarkerIndices', wave_idx, 'MarkerFaceColor', 'red')
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('ECG 2 Heartbeat')
labels = {'P', 'Q', 'R', 'S', 'T'};
wave_t = [time_single(wave_idx)-0.01];
wave_y = [heartbeat(wave_idx)+0.075];
text(wave_t, wave_y, labels)


%% Part 3
% Using figure from Part 1

% Find peaks of full relaxed data
[hr_relax_pks, hr_relax_idx] = findpeaks(relax.ECG3, MinPeakProminence=0.4);
relaxed_hr = length(hr_relax_pks)/((relax.Time(end)-4)/60); % calcualte hr in BPM
%findpeaks(relax.ECG1, MinPeakProminence=0.4)

disp('Relaxed Heartrate (BPM): ')
disp(relaxed_hr)

% Find peaks of full active data
[hr_active_pks, hr_active_idx] = findpeaks(active.ECG3, MinPeakProminence=0.2);
active_hr = length(hr_active_pks)/((active.Time(end)-4)/60); % calcualte hr in BPM
%findpeaks(active.ECG1, MinPeakProminence=0.2)

disp('Active Heartrate (BPM): ')
disp(active_hr)

%% Part 4

% Calculate values of additional leads
avl = (relax.ECG1 - relax.ECG3)./2;
avr = -(relax.ECG1 + relax.ECG2)./2;
avf = (relax.ECG2 + relax.ECG3)./2;

% Find timestamps to isolate two heartbeats
time_double = relax.Time(relax.Time >= 4.5 & relax.Time <= 6.5);
heartbeat_L1 = relax.ECG1(relax.Time >= 4.5 & relax.Time <= 6.5);
heartbeat_L2 = relax.ECG2(relax.Time >= 4.5 & relax.Time <= 6.5);
heartbeat_L3 = relax.ECG3(relax.Time >= 4.5 & relax.Time <= 6.5);

heartbeat_avl = avl(relax.Time >= 4.5 & relax.Time <= 6.5);
heartbeat_avr = avr(relax.Time >= 4.5 & relax.Time <= 6.5);
heartbeat_avf = avf(relax.Time >= 4.5 & relax.Time <= 6.5);

% Plot all six recorded and calculated leads
figure(3)

subplot(1,2,1)
plot(time_double, heartbeat_L1)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('3 ECG Leads')
hold on
plot(time_double, heartbeat_L2)
plot(time_double, heartbeat_L3)
legend('ECG1', 'ECG2', 'ECG3')

subplot(1,2,2)
plot(time_double, heartbeat_avl)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('3 Additional Leads')
hold on
plot(time_double, heartbeat_avr)
plot(time_double, heartbeat_avf)
legend('aVL', 'aVR', 'aVF')

%% Part 5

% Plot ECG 1 and aVF leads to determine whether the signal has a positive,
% negative, or neutral complex. 

figure(4)

subplot(1,2,1)
plot(time_double, heartbeat_L1)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('ECG1')

subplot(1,2,2)
plot(time_double, heartbeat_avf)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('aVF')

%% Part 6

% Plot all ECG and the aVF leads to provide more information to determine
% whether the signal has a positive, negative, or neutral complex. 

figure(5)

subplot(1,2,1)
plot(time_double, heartbeat_L1)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('ECG Leads')
hold on
plot(time_double, heartbeat_L2)
legend('ECG1', 'ECG2')

subplot(1,2,2)
plot(time_double, heartbeat_avf)
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('aVF')

