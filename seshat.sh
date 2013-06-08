#!/bin/bash

# ============================================================================
# A barebones Script Starter for BASH
	version=0.1a
	progname=$(basename $0)
# ============================================================================

# Orignal Copyright:
# Copyright (C) 2007 by Bob Proulx <[hidden email]>.
# Found on: http://gnu-bash.2382.n7.nabble.com/Bash-getopts-option-td3251.html
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


# ==============================================
print_help(){
	clear
    cat <<'EOF'
  -_-/           ,,          ,
 (_ /            ||     _   ||
(_ --_  _-_  _-_,||/\\ < \,=||=
  --_ )|| \\||_. || || /-|| ||
 _/  ))||/   ~ |||| ||(( || ||
(_-_-  \\,/ ,-_- \\ |/ \/\\ \\,
                   _/
Usage: exampleprog [options] SOURCE...
	or:  exampleprog [options] DIRECTORY

Write your man page description here.

Options:
      --help          print this help message
      --version       print program version
  -a, --alpha         do alpa
  -f, --file=STRING   Log File to be Converted
  -d, --debug         debug program
  -q, --quiet         quiet output
  -v, --verbose       verbose output

Examples:

The most common use is to run it like this.

  $ exampleprog

But sometimes like this.

  $ exampleprog -q -a --bravo=foo

Report bugs to <mailing-address>
EOF
}
# ==============================================

# ==============================================
print_version() {
	cat <<EOF
	$progname $version
	A Visual Log powered by D3.js

	Copyright (C) @RELEASE_YEAR@ Free Software Foundation, Inc.
	This is free software.  You may redistribute copies of it under the terms of
	the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
	There is NO WARRANTY, to the extent permitted by law.

	Originally Written by Bob Proulx.

	Barebone Script Created by Phrasz
EOF
}
# ==============================================




# Start_Time=`date | awk '{print $4}'`
Start_Time=`date +%s%N`

SHORTOPTS="af:dqv"
LONGOPTS="help,version,alpha,file:,debug,quiet,verbose"

if $(getopt -T >/dev/null 2>&1) ; [ $? = 4 ] ; then # New longopts getopt.
    OPTS=$(getopt -o $SHORTOPTS --long $LONGOPTS -n "$progname" -- "$@")
else # Old classic getopt.
    # Special handling for --help and --version on old getopt.
    case $1 in --help) print_help ; exit 0 ;; esac
    case $1 in --version) print_version ; exit 0 ;; esac
    OPTS=$(getopt $SHORTOPTS "$@")
fi

if [ $? -ne 0 ]; then
    echo "'$progname --help' for more information" 1>&2
    exit 1
fi

eval set -- "$OPTS"

# INTIALIZATIONS:
alpha=false
file_name=" "
outfile="seshat.json"
debug=false
quiet=false
verbose=false
declare -a names_array=( check check 1 2 1 2 )

while [ $# -gt 0 ]; do
    : debug: $1
    case $1 in
        --help)
            print_help
            exit 0
            ;;
        --version)
            print_version
            exit 0
            ;;
        -a | --alpha)
            alpha=true
            shift
            ;;
        -f | --file)
            file_name=$2
            shift 2
            ;;
	-d | --debug)
            debug=true
            shift
            ;;
        -q | --quiet)
            quiet=true
            shift
            ;;
        -v | --verbose)
            verbose=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal Error: option processing error: $1" 1>&2
            exit 1
            ;;
    esac
done



if $verbose; then
	echo "Program Started: $Start_Time"
	echo "PLACE Verbose output here."
#	End_Time=`date | awk '{print $4}'`
fi

if $quiet; then
#if ! $quiet; then
    echo "PLACE PROGRAM HERE THAT IS THE QUIET VERSION"
fi

#$debug && echo "No bugs found here."

	clear
echo '  -_-/           ,,          ,'
echo ' (_ /            ||     _   ||'
echo '(_ --_  _-_  _-_,||/\\ < \,=||='
echo '  --_ )|| \\||_. || || /-|| ||'
echo ' _/  ))||/   ~ |||| ||(( || ||'
echo '(_-_-  \\,/ ,-_- \\ |/ \/\\ \\,'
echo '                   _/'
echo ""
if $debug; then
echo "[DEBUGGING] Messages Turned On"
fi
if $verbose; then
echo "[CONSOLE] Start Time: "`date`
fi
	if [ -e "$file_name" ]; then
		if $verbose; then
			echo "[CONSOLE] Checking for file: $file_name"
			echo "[CONSOLE]	It exists! Loading file..."
		fi
	else
		echo "[ERROR] File($file_name) DOES NOT EXIST!\n"
		exit 1
	fi

     #Parse PROJECT Information
	project_name=`grep -i "\~\~" $file_name |  awk '{print substr($0, index($0,$2))}'`
	project_version=`grep -i "\~v" $file_name |  awk '{print substr($0, index($0,$2))}'`
	project_description=`grep -i "\~d" $file_name |  awk '{print substr($0, index($0,$2))}'`
	file_lines=`wc $file_name | awk '{print $1}'`
	dated_sections=`cat $file_name | grep "::" | wc -l`
	closed_sections=`cat $file_name | grep "||" | wc -l`

	if $debug; then
		echo "[DEBUGGING] project_name: $project_name"
		echo "[DEBUGGING] project_version: $project_version"
		echo "[DEBUGGING] project_description: $project_description"
		echo "[DEBUGGING] file_lines: $file_lines"
		echo "[DEBUGGING] dated_sections: $dated_sections"
		echo "[DEBUGGING] closed_sections: $closed_sections"
	fi
     #END Parse PROJECT Information

     #Seshat.html Builder
	cat seshat_files/start > $project_name.html
	echo $project_name" ("$project_version") Generated on: "`date`  >> $project_name.html
	cat seshat_files/2nd >> $project_name.html
	echo $project_name" ("$project_version")" >> $project_name.html
	cat seshat_files/3rd >> $project_name.html
	echo $project_description >> $project_name.html
	cat seshat_files/4th >> $project_name.html
     #END Seshat.html Builder

     #Output Parent Node (Project Name) to JSON file (1/3)
	echo "{"> $outfile
	echo "   \"name\": \""$project_name"\"," >> $outfile
	echo "   \"children\": [" >> $outfile
     #END Output Parent Node (Project Name) to JSON file


     #File Parsing Logic for 1st Level CHILDREN, and 2nd Level line determination:
	if [ "$dated_sections"=="$closed_sections" ];
	then
		if $debug; then
			echo "[DEBUGGING] Start and Stop sections EQUATE!"
		fi


	     #Year of Section Beginings:
		year_section_array=(`cat -n $file_name | grep "::" | awk '{print $3" "$2" "$1}' | sort | awk '{print $1}' | tr - " " | awk '{print $1}'`)
		adjusted_lines=${#year_section_array[*]}
		adjusted_lines=$(( adjusted_lines - 1 )) #exception handling

		if $debug; then
			echo "[DEBUGGING] This is the Year of sections array size: "${#year_section_array[*]}

			for i in `seq 0 $adjusted_lines`;
			do
		        	echo "[DEBUGGING] year_section_array["$i"]: "${year_section_array[$i]}
			done
		fi
	     #END Year of Section Beginings:

	     #Month-Day of Section Beginings:
		monday_section_array=(`cat -n $file_name | grep "::" | awk '{print $3" "$2" "$1}' | sort | awk '{print $1}' | tr - " " | awk '{print $2"-"$3}'`)
		adjusted_lines=${#monday_section_array[*]}
		adjusted_lines=$(( adjusted_lines - 1 )) #exception handling

		if $debug; then
			echo "[DEBUGGING] This is the Month-Day of sections array size: "${#monday_section_array[*]}

			for i in `seq 0 $adjusted_lines`;
			do
		        	echo "[DEBUGGING] monday_section_array["$i"]: "${monday_section_array[$i]}
			done
		fi
	     #END Month-Day of Section Beginings:

	     #Line Number of Section Beginings:
		begin_section_array=(`cat -n $file_name | grep "::" | awk '{print $3" "$2" "$1}' | sort | awk '{print $3}'`)
		adjusted_lines=${#begin_section_array[*]}
		adjusted_lines=$(( adjusted_lines - 1 )) #exception handling

		if $debug; then
			echo "[DEBUGGING] This is the begining sections array size: "${#begin_section_array[*]}

			for i in `seq 0 $adjusted_lines`;
			do
		        	echo "[DEBUGGING] begin_section_array["$i"]: "${begin_section_array[$i]}
			done
		fi
	     #END Line Number of Section Beginings:

	     #Line Number of Section Endings:
		end_section_array=(`cat -n $file_name | grep "||" | awk '{print $3" "$2" "$1}' | sort | awk '{print $3}'`)
		adjusted_lines=${#end_section_array[*]}
		adjusted_lines=$(( adjusted_lines - 1 )) #exception handling

		if $debug; then
			echo "[DEBUGGING] This is the ending sections array size: "${#end_section_array[*]}

			for i in `seq 0 $adjusted_lines`;
			do
		        	echo "[DEBUGGING] end_section_array["$i"]: "${end_section_array[$i]}
			done
		fi
	     #END Line Number of Section Endings:

		##grep "::" $file_name | awk '{print $2}' | sort > seshat_dated_sections.temp

		##count=1
		##cat seshat_dated_sections.temp | while read LINE
		##do
		##	if $verbose; then
		##		echo "[CONSOLE] Processing Entry $count having date: $LINE"
		##	fi

		##	temp_year=`echo $LINE | tr - " " | awk '{print $1}'`
		##	temp_monday=`echo $LINE | tr - " " | awk '{print $2"-"$3}'`

		##	if $debug; then
		##		echo "[DEBUGGING] temp_year: $temp_year"
		##		echo "[DEBUGGING] temp_monday: $temp_monday"
		##	fi

		##	count=`expr $count + 1`
		##done

		if $verbose; then
			echo "[CONSOLE] Variables Loaded! Configuring entries for JSON file..."
		fi

		StillProcess=1
		SectionCounter=0
		LastYearProcessed=${year_section_array[0]}
		if $debug; then
			echo "[DEBUGGING] Running first year of: "$LastYearProcessed
		fi

	     #Output FIRST Child node... to JSON file  (2/3)
		echo "	{">> $outfile
		echo "	   \"name\": \""$LastYearProcessed"\"," >> $outfile
		echo "	   \"children\": [" >> $outfile
	     #END Output Parent Node (Project Name) to JSON file

		adjusted_lines=${#begin_section_array[*]}
		adjusted_lines=$(( adjusted_lines - 1 )) #exception handling
		counter=0;
		for i in `seq 0 $adjusted_lines`;
		do
			if $verbose; then
				echo ""
				echo "[CONSOLE] Processing section $i ["${year_section_array[$i]}" "${monday_section_array[$i]}"]"
			fi
			# OUTPUT 2nd Child/changelog nodes  (3/3)
			echo "		{" >> $outfile
			echo "		   \"name\": \""${monday_section_array[$i]}"\"," >> $outfile
			echo "		   \"children\": [" >> $outfile
			#ENTER CHILDREN
			if $verbose; then
				echo "Running from: ${begin_section_array[$i]} to ${end_section_array[$i]}"
			fi
			start=${begin_section_array[$i]}
			stop=${end_section_array[$i]}
			start=$(($start+1))
			stop=$(($stop-1))
			for j in `seq $start $stop`;
			 do
				echo "			{" >> $outfile
				#echo "			   \"name\": \"Testing...\"" >> $outfile
				templine=`awk NR==$j $file_name`
				templine=`echo $templine | tr -d "\""`
				if $debug; then
					echo "[DEBUGGING] awk gave: "$templine
				fi

				echo "			   \"name\": \"$templine\"" >> $outfile
					#$PRINT-TO-FILE-FROM-LINE[j]"\"" >> $outfile
				echo "			}" >> $outfile
				if [ "$j" != "$stop" ]; then
					echo "			," >> $outfile
				fi
				#IF NOT LAST IN FOR LOOP ECHO ,
			done
			echo "		   ]" >> $outfile
			counter=$(( $counter + 1 ))
			if $debug; then
				echo "[DEBUGGING] Counter: "$counter
			fi
			CurrentYearProcessed=${year_section_array[$counter]}

			if $debug; then
				echo "[DEBUGGING] LastYear: $LastYearProcessed vs CurrentYear: $CurrentYearProcessed"
			fi

			echo "		}" >> $outfile  #CLOSE BRACKET FOR 2nd Child/changelog nodes  (3/3)

			if [ "$CurrentYearProcessed" == "" ]; #NO CHANGE IN YEAR, Process as CHILD NODE
			then
				if $debug; then
					 echo "[DEBUGGING] EOF Blank. Correcting last entry!"
				fi
				CurrentYearProcessed=$LastYearProcessed
			fi

			if [ "$LastYearProcessed" == "$CurrentYearProcessed" ]; #NO CHANGE IN YEAR, Process as CHILD NODE
			then

				if $debug; then
					echo "[DEBUGGING] Same Year!"
				## DO STUFF
				fi
				if [ "$adjusted_lines" != "$i" ];
				then
					echo "		," >> $outfile
					if $debug; then
						echo "[DEBUGGING] 	NOT the last Year"
					## DO STUFF
					fi
				else
					echo "	]" >> $outfile
					echo "}" >> $outfile #CLOSE BRACKET FOR 2nd Child/changelog nodes  (2/3)
				fi

			else #Year CHANGE, close out year and place new year
				if $debug; then
					echo "[DEBUGGING] NOT THE Same Year!!!"
				fi
				echo "	   ]" >> $outfile
				echo "	}" >> $outfile
				echo "	," >> $outfile
				echo "	{" >> $outfile
				echo "	\"name\": \""$CurrentYearProcessed"\"," >> $outfile
				echo "	\"children\": [" >> $outfile

			fi
			LastYearProcessed=$CurrentYearProcessed

		done

	else
		echo "[ERROR] Please check file($file_name) for section headers and closing marks (dated: $dated_sections vs closings: $closed_sections)!\n"
		exit 1,
	fi
     #END File Parsing Logic for 1st Level CHILDREN, and 2nd Level line determination:

     #CLOSE BRACKET for Parent Node Endings to JSON file (1/3)
	echo "]" >> $outfile
	echo "}" >> $outfile


#names_array=(`ls -al | grep May | grep -v "drwx" | awk '{print $9}'`)

End_Time=`date +%s%N`

if $verbose; then
echo "[CONSOLE] Program Ended: $End_Time"
echo "[CONSOLE] Program Runtime: " $(( (End_Time - Start_Time) / 1000 ))" microseconds"
fi

echo "All operations completed!"

exit 0
