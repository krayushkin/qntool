qnTool is a C++ application/tool to upload firmware in QN902x micrccontroller from NXP. The program communicates with the bootloader of the QN902x microcontrollers.
Refer this link to know the bootloader: https://community.nxp.com/thread/457271


*** MODIFIED BY DMITRY KRAYUSHKIN ***

- add support of new ioctrl gpio api (for resetting qn902x)

Connect Program connector:



               O  | 1     2  |  O        
               O  | 3     4  |  O        
               O  | 5     6  |  O        
               O  | 7     8  |  O        
         GND   O  | 9     10 |  O        
         TX    O  | 11    12 |  O        
         RX    O  | 13    14 |  O        
         ~RST  O  | 15    16 |  O        
               O  | 17    18 |  O        
               O  | 19    20 |  O        
               O  | 21    22 |  O        
