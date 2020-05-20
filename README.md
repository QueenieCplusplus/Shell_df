# Shell_df
Disk Free (a.k.a ) disk availability

* Bash

      $ df
         
         Filesystem    512-blocks      Used Available Capacity iused      ifree %iused  Mounted on
         /dev/disk1s5   489825072  21732480  31137552    42%  487329 2448638031    0%   /
         devfs                382       382         0   100%     669          0  100%   /dev
         /dev/disk1s1   489825072 432330920  31137552    94% 1436221 2447689139    0%   /System/Volumes/Data
         /dev/disk1s4   489825072   2099304  31137552     7%       2 2449125358    0%   /private/var/vm
         map auto_home          0         0         0   100%       0          0  100%   /System/Volumes/Data/home
   
* Friendly＿Read Scripts

      #!bin/bash
      #another_df

      awkscript = "/tmp/520a.sh" 

      trap "rm -f $awkscript" EXIT

      cat 'EOF' > $awkscript

      function showUnit(size){

       mb = size / 1024; okmb = (int(mb * 100))/100;
       gb = mb / 1024; okgb = (int(gb * 100))/100;

       if ( substr(size, 1, 1) !~ "[0~9]" || substr(size, 2, 1) !~"[0~9]" ){ return size }
       elif ( mb < 1 ){ return size "K"}
       elif  ( gb < 1 ){return okmb "M"}
       else { return okgb "G"}

      }

      Begin{

         printf "%-37s %10s %7s %7s %8s %-s\n", "FS", "Capacity", "Used", "Avail", "Ratio", "Mount_on"

      }

      !/Filesystem/ {

        size = showUnit($2);
        used = showUnit($3);
        avail = showUnit($4);

        printf "", $1, size, used, avail, $5, $6
      }
      EOF

      df -k | awk -f $awkscript

      exit 0

* Syntax



* Execute Script
        
         
         




