# ECG-Processing
Processing ECG data during rest vs. activity 

**ECG 2 Heartbeat** | **ECG and Calculated Leads**
:-:|:-:
![ecg2_heartbeat](https://github.com/user-attachments/assets/d706574f-93c2-47c2-a2ec-19e5d268fb1b) | ![double_good](https://github.com/user-attachments/assets/4d43da07-3ed3-4f21-8517-1241ba297598)

All electrocardiography data was collected with four leads attached to the same person in different physical states. Three leads were placed on the ribs, one on the lowest rib on the left side, one on the second rib on the right side, and one on the second rib on the left side to triangulate a signal around the heart. The fourth lead was placed on the lowest rib on the right side and acted as a ground. 

# Data Description
relaxed.csv: ECG data collected while sitting and in a restful state. 

active.csv: ECG data collected while doing push-ups. 

# Code Description
In Part 1, the relaxed and active data is plotted from the middle of the collection period where the signals were most consistent.

In Part 2, a single heartbeat was isolated, depicting the PQRST wave complex. 

In Part 3, the average heartrate during the collection period is calculated and displayed in the command window. 

In Part 4, the addional leads (aVL, aVR, and aVF) are calculated and plotted alongside the original 3 ECG leads for two isolated heartbeats.

In Parts 5 and 6, two combinations of the leads are plotted to detemrine the polarity of the signal. 
