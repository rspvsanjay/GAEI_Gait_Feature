# GAEI_Gait_Feature

The Code have been implimented in MATLAB script.

To find GAEI feature, first we need to extract gait cycles then find number of poses using distortion rate respect each sequence. 
Condese the poses with respect to each length to find dictionary of key pose set where pose may belong to multiple subjects.
Then find Pose Energy Image (PEI) with respect to each key pose set where PEI have been constructed using absolute difference image.

Then classify the GAEI feature where classifire involved with auto-encoder, PCA and diagonal LDA used as classifire.


The related paper:  “Exploiting Pose Dynamics for Human Recognition from Their Gait Signature” 
https://link.springer.com/article/10.1007/s11042-020-10071-9
