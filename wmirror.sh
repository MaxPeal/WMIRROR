#!/bin/bash

# - iNFO -----------------------------------------------------------------------------
#
#        Author  wuseman <wuseman@nr1.nu>
#      FileName: wmirror.sh
#       Version: 1.3
#
#       Created: 2018.01.01 (N/A)
#      Modified: 2021-08-23 (20:11:45)
#
#      iRC-Nick: wuseman (Libera/EFnet/LinkNet) 
#       Website: https://www.nr1.nu/
#        GitHub: https://github.com/wuseman/
#
# - Descrpiption --------------------------------------------------------------------
#
#      No description has been added
#
# - LiCENSE -------------------------------------------------------------------------
#
#      Copyright (C) 2021, wuseman                                     
#                                                                       
#      This program is free software; you can redistribute it and/or modify 
#      it under the terms of the GNU General Public License as published by 
#      the Free Software Foundation; either version 2 of the License, or    
#      (at your option) any later version.                                  
#                                                                       
#      This program is distributed in the hope that it will be useful,      
#      but WITHOUT ANY WARRANTY; without even the implied warranty of       
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        
#      GNU General Public License for more details.                         
#                                                                       
#      You must obey the GNU General Public License. If you will modify     
#      the file(s), you may extend this exception to your version           
#      of the file(s), but you are not obligated to do so.  If you do not   
#      wish to do so, delete this exception statement from your version.    
#      If you delete this exception statement from all source files in the  
#      program, then also delete it here.                                   
#
# - End of Header -------------------------------------------------------------

usage() {
cat << EOF

 Usage: ./wmirror.sh -u <url> [options]

     -h                 - Print this useful help
     -u                 - URL for our Website to mirror 
     -p                 - Path to store content
     -v                 - Print verrsion

EOF
exit 0
}

if [[ -z $1 ]]; then usage;exit 1; fi

while getopts ":u:p:vh" getopts; do
  case $getopts in
    u) u=$OPTARG ;;
    p) p=$OPTARG ;;
    h) usage ;;
    v) echo -e "$basename$0: v$VERSION"; exit 1 ;;
#    \?) echo -e "$basename$0: internal error -- $* is not a valid option, exiting ...;" exit 1 ;; 
#    *) echo -e "$basename$0: internal error -- $* is not a valid option, exiting ...;" exit 1 ;; 
  esac
done
shift $((OPTIND-1))

if [[ -z "${u}" ]]; then
    echo -e "$basename$0: internal error -- url is missing"; exit 1
    exit 1
fi

if [[ -z "${p}" ]]; then
    echo -e "$basename$0: internal error -- you must include a path to store content"; exit 1
    exit 1
fi

printf 'Url:  -> %s \n' "${u}"
printf 'Path: -> %s\n' "${p}"
echo -e "IP:   -> $(curl -sL ifconfig.co)" 

read -p "Press enter to continue.."
echo -e "\nMirroring: ${u}..."
wget -c -q --show-progress --progress=bar:force:noscroll -l inf -m -e robots=off -P ${p} ${u}


