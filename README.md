# EEG_MEG_GUI
EEG/MEG GUI

This simple toolbox has been written to allow the user do some of the most basic and commonly used analysis of EEG and MEG data. The user can start the GUI by typing "EEG_MEG_GUI". Please, remember to create a global path before starting the GUI. 

The GUI is divided into 3 menus:

1) Import data: this is a set of GUIs used to convert files recorded from a variety of EEG systems and to convert them into a mat format that can be used for analysis. It also suppoprt the sqd format for the MEG data (KIT). Please, keep in mind that the format of the data saved by the EEG/MEG systems might change and in that case my code might not work. For instance, in the case of Biosemi and Emotiv, my code assumes that the data are read every 1 second. If the format changes and I am not aware of that, please e-mail me and I will try to make the appriopriate changes. Additionally, in systems like Biosemi, since I have never worked with data different from EEG, I have not been able to test the code with other input, such as Ergo input.

2) Signal Analysis: this is a set of GUIs containing some of the most basic and commonly used analysis of EEG and MEG data, such as averaging, wavelets, Fourier, etc.

3) Tools: this is a set of GUIs used for basic manipulation of the data, such as removal of triggers, removal of senros, etc.

Each GUI has its own "Help" tab explaining how to use it. 

I hope this GUI will be of some help to someone.

If you need any assistance and/or find bugs, please contact me (Alex) at: pressalex@hotmail.com
