#!/bin/bash

HOME="/home/container"
HOMEA="$HOME/linux/.apt"
STAR1="$HOMEA/lib:$HOMEA/usr/lib:$HOMEA/var/lib:$HOMEA/usr/lib/x86_64-linux-gnu:$HOMEA/lib/x86_64-linux-gnu:$HOMEA/lib:$HOMEA/usr/lib/sudo"
STAR2="$HOMEA/usr/include/x86_64-linux-gnu:$HOMEA/usr/include/x86_64-linux-gnu/bits:$HOMEA/usr/include/x86_64-linux-gnu/gnu"
STAR3="$HOMEA/usr/share/lintian/overrides/:$HOMEA/usr/src/glibc/debian/:$HOMEA/usr/src/glibc/debian/debhelper.in:$HOMEA/usr/lib/mono"
STAR4="$HOMEA/usr/src/glibc/debian/control.in:$HOMEA/usr/lib/x86_64-linux-gnu/libcanberra-0.30:$HOMEA/usr/lib/x86_64-linux-gnu/libgtk2.0-0"
STAR5="$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/printbackends"
STAR6="$HOMEA/usr/lib/x86_64-linux-gnu/samba/:$HOMEA/usr/lib/x86_64-linux-gnu/pulseaudio:$HOMEA/usr/lib/x86_64-linux-gnu/blas:$HOMEA/usr/lib/x86_64-linux-gnu/blis-serial"
STAR7="$HOMEA/usr/lib/x86_64-linux-gnu/blis-openmp:$HOMEA/usr/lib/x86_64-linux-gnu/atlas:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-miners-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/lapack:$HOMEA/usr/lib/x86_64-linux-gnu/gedit"
STARALL="$STAR1:$STAR2:$STAR3:$STAR4:$STAR5:$STAR6:$STAR7"
export LD_LIBRARY_PATH=$STARALL
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA

bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")

echo "
${bold}${lightgreen}███████╗ ██████╗███████╗████████╗ █████╗ ███████╗██╗   ██╗
${bold}${lightgreen}██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝╚██╗ ██╔╝
${bold}${lightgreen}█████╗  ██║     ███████╗   ██║   ███████║███████╗ ╚████╔╝ 
${bold}${lightgreen}██╔══╝  ██║     ╚════██║   ██║   ██╔══██║╚════██║  ╚██╔╝  
${bold}${lightgreen}███████╗╚██████╗███████║   ██║   ██║  ██║███████║   ██║   
${bold}${lightgreen}╚══════╝ ╚═════╝╚══════╝   ╚═╝   ╚═╝  ╚═   ═════╝   ╚═╝   
"

if [[ -f "./installed" ]]; then
    echo "${bold}${lightgreen}==> Started ${lightblue}Container${lightgreen} <=="
    echo "Choose an option to continue:"
    echo "1) Start Gotty web-based terminal"
    echo "2) Interactive shell loop (runcmd)"
    read -p "Enter your choice (1/2): " choice
    if [[ "$choice" == "1" ]]; then
        ./gotty -w bash
    elif [[ "$choice" == "2" ]]; then
        function runcmd1 {
            printf "${bold}${lightgreen}Default${nc}@${lightblue}Container${nc}:~ "
            read -r cmdtorun
            ./libraries/proot -S . /bin/bash -c "$cmdtorun"
            runcmd
        }
        function runcmd {
            printf "${bold}${lightgreen}Default${nc}@${lightblue}Container${nc}:~ "
            read -r cmdtorun
            ./libraries/proot -S . /bin/bash -c "$cmdtorun"
            runcmd1
        }
        runcmd
    else
        echo "Invalid choice, exiting."
        exit 1
    fi
else
    echo "Downloading files for application"
    curl -sSLo ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip >/dev/null 2>err.log
    curl -sSLo files.zip https://github.com/RealTriassic/Ptero-VM-JAR/releases/download/latest/files.zip >/dev/null 2>err.log
    curl -sSLo unzip https://raw.githubusercontent.com/BheemKiGoli/love/blob/main/unzip >/dev/null 2>err.log
    curl -sSLo gotty https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz >/dev/null 2>err.log
    chmod +x unzip >/dev/null 2>err.log
    export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
    ./unzip ngrok.zip >/dev/null 2>err.log
    ./unzip files.zip >/dev/null 2>err.log
    tar -xf gotty_linux_amd64.tar.gz -C ./ >/dev/null 2>err.log
    chmod +x ./libraries/proot >/dev/null 2>err.log
    chmod +x ngrok >/dev/null 2>err.log
    chmod +x gotty >/dev/null 2>err.log
    rm -rf files.zip >/dev/null 2>err.log
    rm -rf gotty_linux_amd64.tar.gz >/dev/null 2>err.log
    rm -rf ngrok.zip >/dev/null 2>err.log
    touch installed
    echo "
${bold}${lightgreen}███████╗ ██████╗███████╗████████╗ █████╗ ███████╗██╗   ██╗
${bold}${lightgreen}██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝╚██╗ ██╔╝
${bold}${lightgreen}█████╗  ██║     ███████╗   ██║   ███████║███████╗ ╚████╔╝ 
${bold}${lightgreen}██╔══╝  ██║     ╚════██║   ██║   ██╔══██║╚════██║  ╚██╔╝  
${bold}${lightgreen}███████╗╚██████╗███████║   ██║   ██║  ██║███████║   ██║   
${bold}${lightgreen}╚══════╝ ╚═════╝╚══════╝   ╚═╝   ╚═╝  ╚══   ════╝   ╚═╝   
"
    echo "${nc}"
    ./gotty -w bash
fi
