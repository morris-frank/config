#/bin/sh
# this script fetches all "usefull" information from the system
# it can be used to pipe the output to <bar ain't recursive>

interval=0.25 #Refresh in seconds!

intclk=10
clock(){
	clk="$(date '+%a %d%b %H:%M')"
}

intnet=120
network(){
	if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
		net="[ext@$(curl --connect-timeout 3 ipecho.net/plain | \head -1 2>/dev/null)"
		if [ $(ip link | awk '/wlp3s0/ {print $9}') = "UP" ]; then
			net="${net} @wifi: $(iwconfig wlp3s0 | awk -F \" '/ESSID/ {print $2}') $(iwconfig wlp3s0 | awk '/Quality/ {print $2}' | cut -f2 -d "=")"
		fi
		if [ $(ip link | awk '/enp12s0/ {print $9}') = "UP" ]; then
			net="${net} @ethernet"
		fi
	else
		net="[int@$(hostname --ip-address | cut -f1 -d " ")"
	fi
	net="${net}]"
}

intarc=600
arch(){
	#arc="[$(uname -r) : $(pacman -Q | wc -l) packages : $(checkupdates | wc -l) updates ]"
	arc="[$(uname -r) ¦ $(pacman -Q | wc -l) packages ¦ $(pacman -Qu | wc -l) local updates"
	arc="${arc}]"
}

intwrk=1
workspaces(){
	num=1
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
	current=$(($cur + $num))
	wrk="[$current/$tot]["
	((tot--))
	for i in `seq 0 "$tot"`; do
		if xdotool search --limit 1 --desktop "$i" --name ".*" &> /dev/null; then
			wrk="${wrk}×"
		else
			wrk="${wrk} "
		fi
		if [ "$i" != "$tot" ]; then
			wrk="${wrk}¦"
		fi
	done
	wrk="${wrk}]"
}

#intmus=5
#music(){
#	mus="[\"$(deadbeef --nowplaying %t | awk '{print substr($0,1,20)}')\""
#	mus="${mus} @$(pacmd list-sinks | awk '/front-left:/ {print $5 "-" $12}')"
#	mus="${mus}]"
#}

intmon=3
monitor(){
	mon="[BAT:$(acpi -b | cut -f2 -d "," | cut -c 2- | cut -f1 -d "%")"
	mon="${mon} ¦ SCR:$(xbacklight -get | sed 's/\([a-zA-Z: \t]\)//g' | cut -d . -f 1)"
	mon="${mon} ¦ RAM:$(free -m | awk '/Speicher/ {print $3}')mb"
	mon="${mon} ¦ TMP:$(sensors | awk '/id 0/ {print $4}')"
	mon="${mon}]"
}

cntwrk=0;		workspaces
cntclk=0;		clock
cntnet=0;		network
cntarc=0;		arch
cntmon=0;		monitor
#cntmus=0;		music

while :; do 
	if [[ $cntwrk -ge $intwrk ]]; then workspaces; cntwrk=0; fi
	cntwrk=$((cntwrk+1))
	if [[ $cntclk -ge $intclk ]]; then clock; cntclk=0; fi
	cntclk=$((cntclk+1))
	if [[ $cntnet -ge $intnet ]]; then network; cntnet=0; fi
	cntnet=$((cntnet+1))
	if [[ $cntarc -ge $intarc ]]; then arch; cntarc=0; fi
	cntarc=$((cntarc+1))
	if [[ $cntmon -ge $intmon ]]; then monitor; cntmon=0; fi
	cntmon=$((cntmon+1))
	#if [[ $cntmus -ge $intmus ]]; then music; cntmus=0; fi
	#cntmus=$((cntmus+1))

	if [[ $(xprop -id $(xdotool getactivewindow)) == *"_NET_WM_STATE_FULLSCREEN"* ]]
	then
		#echo "%{l}%{F#22B8926E}${wrk}%{c}%{F#221ba740}${mon} %{F#22DF3A24}${net} %{F#22df8124}${mus} %{F#221793d1}${arc}%{r}%{F#22B8926E}${clk}"
		echo "%{l}%{F#22B8926E}${wrk}%{c}%{F#221ba740}${mon} %{F#22DF3A24}${net} %{F#221793d1}${arc}%{r}%{F#22B8926E}${clk}"
	else
		#echo "%{l}%{F#FFB8926E}${wrk}%{c}%{F#ff1ba740}${mon} %{F#FFDF3A24}${net} %{F#ffdf8124}${mus} %{F#FF1793d1}${arc}%{r}%{F#FFB8926E}${clk}"
		echo "%{l}%{F#FFB8926E}${wrk}%{c}%{F#ff1ba740}${mon} %{F#FFDF3A24}${net} %{F#FF1793d1}${arc}%{r}%{F#FFB8926E}${clk}"
	fi
	sleep $interval
done

