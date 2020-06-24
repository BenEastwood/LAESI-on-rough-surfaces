# LAESI-on-rough-surfaces
LabVIEW VI for topographically-guided Laser Ablation Electrospray Ionization
*caution* Additional software, which I am not allowed to upload here for proprietary reasons, is required for the VIs uploaded here to work properly. 
- APT software from Thorlabs, in form of the approriate drivers forthe linear translation stages used in the sample manipulation system https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=8348
- MEDAQLib-3.3.0.21002 from Micro-Epsilon (https://www.micro-epsilon.de/) for the approriate distance sensor drivers and subVIs
- Opolette SDK OPOTEK_DLL_v2.9.25 from OPOTEK (https://opotek.com/) for the approriate laser drivers and subVIs
- massWolf 4.3.1. (https://sourceforge.net/projects/sashimi/files/massWolf%20%28MassLynx%20converter%29/), for data conversion from Waters .RAW to .mzXML
- additional R-Scripts for data conversion written by Dr. Purva Kulkarni (purvakulkarni7) can be found here: https://github.com/purvakulkarni7/LAESI-MSI-Scripts-B_Bartels.et.al/tree/master/R_scripts_analog_signal_correction

### instrumentation used
laser:IR-Opolette HE (Opotek, Carlsbad CA, USA),
linear translation stages: MZS50/M-Z8, MZS25/M-Z8, DDS220/M (Thorlabs, Newton NJ, USA),
distance sensor: IFS2405-1 + IFC2451 (Micro-Epsilon Messtechnik, Ortenburg, Germany),
mass spectrometer: Synapt HDMS (Waters, Milford MA, USA),

## analog-input MSI
The folder 'analog-input MSI' contains the main VI 'Scan_Ablation_Burst_FindFocus_HighResIntegral_CC' for analog-input MSI and the necessary subVIs, which might require access to the proprietary drivers and subVIs listed above.
The R-script provided here was used to convert the acquired mass spectrometry data from the Waters .RAW file format to .mzXML, and then to  the MSI data format .imzML with the help of the R-scripts written by Dr. Purva Kulkarni (link above).

## pixel-by-pixel MSI
*caution* This approach required a DAQ.device capable of edge detection and counting of a squared signal. 
The following model was used in this project: NI-USB 6210 (National Instruments, Austin TX, USA).
Furthermore, this approach requires access to the internal transistor-transistor-logic signal that synchronizes the scan cycles of the mass spectrometer.

'LAESI_MSI' is the main VI. The necessary subVIs can be found in the same folder. These do require access to the software and drivers mentioned above.


