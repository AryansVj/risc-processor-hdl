
?
Command: %s
53*	vivadotcl2
place_designZ4-113h px� 

@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2	
xc7a35tZ17-347h px� 
o
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2	
xc7a35tZ17-349h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 
>
Running DRC with %s threads
24*drc2
2Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
^
,Running DRC as a precondition to command %s
22*	vivadotcl2
place_designZ4-22h px� 
>
Running DRC with %s threads
24*drc2
2Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
k
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
2Z30-611h px� 
C

Starting %s Task
103*constraints2
PlacerZ18-103h px� 
R

Phase %s%s
101*constraints2
1 2
Placer InitializationZ18-101h px� 
d

Phase %s%s
101*constraints2
1.1 2'
%Placer Initialization Netlist SortingZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1900.2972
0.000Z17-268h px� 
a
%s*common2H
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 1046de639
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.003 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1900.2972
0.000Z17-268h px� 
q

Phase %s%s
101*constraints2
1.2 24
2IO Placement/ Clock Placement/ Build Placer DeviceZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
n
%s*common2U
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 1046de639
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.187 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
Y

Phase %s%s
101*constraints2
1.3 2
Build Placer Netlist ModelZ18-101h px� 
s
PTiming driven mode will be turned off because no critical terminals were found.
1337*placeZ30-2953h px� 
V
%s*common2=
;Phase 1.3 Build Placer Netlist Model | Checksum: 1191a86a8
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.385 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
V

Phase %s%s
101*constraints2
1.4 2
Constrain Clocks/MacrosZ18-101h px� 
S
%s*common2:
8Phase 1.4 Constrain Clocks/Macros | Checksum: 1191a86a8
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.386 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
O
%s*common26
4Phase 1 Placer Initialization | Checksum: 1191a86a8
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.386 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
T

Phase %s%s
101*constraints2
2 2
Final Placement CleanupZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1900.2972
0.000Z17-268h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.387 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
�
aNo place-able instance is found; design doesn't contain any instance or all instances are placed
5*	placeflowZ30-281h px� 
D
%s*common2+
)Ending Placer Task | Checksum: 1046de639
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.387 . Memory (MB): peak = 1900.297 ; gain = 0.000h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
422
12
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
place_designZ4-42h px� 
[
%s4*runtcl2?
=Executing : report_io -file processorTOP_risc0_io_placed.rpt
h px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.115 . Memory (MB): peak = 1900.297 ; gain = 0.000
*commonh px� 
�
%s4*runtcl2~
|Executing : report_utilization -file processorTOP_risc0_utilization_placed.rpt -pb processorTOP_risc0_utilization_placed.pb
h px� 
x
%s4*runtcl2\
ZExecuting : report_control_sets -verbose -file processorTOP_risc0_control_sets_placed.rpt
h px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.004 . Memory (MB): peak = 1900.297 ; gain = 0.000
*commonh px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0012

1900.2972
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PlaceDB: 2

00:00:002
00:00:00.0022

1900.2972
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PulsedLatchDB: 2

00:00:002

00:00:002

1900.2972
0.000Z17-268h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote RouteStorage: 2

00:00:002
00:00:00.0562

1900.2972
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Netlist Cache: 2

00:00:002

00:00:002

1900.2972
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Device Cache: 2

00:00:002
00:00:00.0152

1900.2972
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write Physdb Complete: 2

00:00:002
00:00:00.0862

1900.2972
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2�
�E:/Projects/Risc_v_processor_buildup/risc-processor-hdl/Processor_source/Processor_source.runs/impl_1/processorTOP_risc0_placed.dcpZ17-1381h px� 


End Record