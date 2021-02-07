function o() {
	if hash xdg-open &> /dev/null; then
		for file in "$@"; do
			if test -f "${file}"; then
				exec xdg-open "${file}" &> /dev/null & disown
			fi
		done
	else
		echo "${RED}[In o] xdg-open not found${RES}"
	fi
}

function graypdf() {
	for file in "$@"; do
		gs \
		 -sOutputFile="gray_$file" \
		 -sDEVICE=pdfwrite \
		 -sColorConversionStrategy=Gray \
		 -dProcessColorModel=/DeviceGray \
		 -dCompatibilityLevel=1.4 \
		 -dNOPAUSE \
		 -dBATCH \
		 -dAutoRotatePages=/None \
		 "$file"
	done
}

function current_branch() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || \
	ref=$(git rev-parse --short HEAD 2> /dev/null) || return
	echo ${ref#refs/heads/}
}

function current_repository() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || \
	ref=$(git rev-parse --short HEAD 2> /dev/null) || return
	echo $(git remote -v | cut -d':' -f 2)
}

function gclone() {
   git clone $1 ${${${${1}##*github.com}%.git}:1}
}

function run_once() {
	pgrep -u $USER -x "$@"
    if ! pgrep -u $USER -x "$@" > /dev/null; then
		exec "$@" &> /dev/null & disown
	fi
}

function wifi_restart() {
	sudo rfkill block wifi
	sudo macchanger -e wlp3s0
	sleep 3
	sudo rfkill unblock wifi
}
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
