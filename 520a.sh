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

