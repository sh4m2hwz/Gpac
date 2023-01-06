#!/usr/bin/env bash

def_path="$(pwd)"
temp_file="$(mktemp -u)"
temp_dir="$(mktemp -d)"

sudo chown -R $USER ./tmp

if [ -d "./tmp" ]; then
clear
echo "Start build!"
else
clear
echo "Start build!"
mkdir ./tmp
fi
sudo cp -r ./profile ./tmp/profile

case_depz() {
        echo "[Pacman install deps...]"
    ###############   Dep's Install   #################
        sudo pacman --needed -Sy gcc re2 aria2 go git arch-install-scripts bash dosfstools e2fsprogs erofs-utils grub libarchive libisoburn make mtools squashfs-tools syslinux libnetfilter_queue libpcap python-grpcio python-protobuf python-slugify python-pyqt5 abseil-cpp python-pyinotify python-notify2 go python-grpcio-tools python-setuptools python-nspektr python-jaraco.text qt5-tools logrotate hicolor-icon-theme python-pip --noconfirm
        }
case_depz > /dev/null 2>&1




case_icons() {

        if [ -d $def_path/tmp/papirus-icon-theme-master ]; then
        echo "[Papirus] -> [!OK!]"
        else

        script() {
        if [ -f $def_path/tmp/Papirus.tar.gz ]; then
        echo "[Papirus] -> [Extract...]"
        tar -xzf $def_path/tmp/Papirus.tar.gz -C $def_path/tmp/
        rm -f $def_path/tmp/papirus-icon-theme-master/*  > /dev/null 2>&1
        rm -rf $def_path/tmp/profile/airootfs/usr/share/icons/* > /dev/null 2>&1
        mkdir -p $def_path/tmp/profile/airootfs/usr/share/icons
        cp -r $def_path/tmp/papirus-icon-theme-master/* $def_path/tmp/profile/airootfs/usr/share/icons/
        echo "[Papirus] -> [!OK!]"
        else
        echo "[Papirus] -> [Downloading...]"
        aria2c -x 10 "https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/master.tar.gz" -d  "./tmp" -o "Papirus.tar.gz" --continue=true
        echo "[Papirus] -> [Extract...]"
        tar -xzf $def_path/tmp/Papirus.tar.gz -C $def_path/tmp/
        rm -f $def_path/tmp/papirus-icon-theme-master/*  > /dev/null 2>&1
        rm -rf $def_path/tmp/profile/airootfs/usr/share/icons/* > /dev/null 2>&1
        mkdir -p $def_path/tmp/profile/airootfs/usr/share/icons
        cp -r $def_path/tmp/papirus-icon-theme-master/* $def_path/tmp/profile/airootfs/usr/share/icons/
        echo "[Papirus] -> [!OK!]"
        fi
        }; script
        fi
}

if [ -f "$def_path/tmp/profile/airootfs/usr/share/icons/Papirus" ]; then
echo "[Papirus] -> [!OK!]"
sleep 1
else
case_icons 2>&1 | tee log.txt
sleep 1
fi




case_opensnitch() {

        if [ -d $def_path/tmp/opensnitch-git ]; then
        echo "[OpenSnitch] -> [!Src Exist!]"
        sudo cp -r $def_path/tmp/opensnitch-git/*   $def_path/tmp/profile/airootfs/
        mkdir -p $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        sudo cp -r /usr/lib/python3.10/site-packages/pyasn* $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        sudo cp -r /usr/lib/python3.10/site-packages/qt_material* $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        ln -s $def_path/tmp/profile/airootfs/usr/lib/systemd/system/opensnitchd.service $def_path/tmp/profile/airootfs/etc/systemd/system/
        sleep 1
        else
        echo "[OpenSnitch] -> [Build...]"

        script() {
        pip install qt-material pyasn > /dev/null 2>&1
        git clone https://aur.archlinux.org/opensnitch-git.git $def_path/tmp/opensnitch-git > /dev/null 2>&1
        cd $def_path/tmp/opensnitch-git
        makepkg --noconfirm -sf > /dev/null 2>&1
        mv -f $def_path/tmp/opensnitch-git/pkg/opensnitch-git $def_path/tmp/
        sudo cp -r $def_path/tmp/opensnitch-git/*   $def_path/tmp/profile/airootfs/
        mkdir -p $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        sudo cp -r /usr/lib/python3.10/site-packages/pyasn* $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        sudo cp -r /usr/lib/python3.10/site-packages/qt_material* $def_path/tmp/profile/airootfs/usr/lib/python3.10/site-packages/
        ln -s $def_path/tmp/profile/airootfs/usr/lib/systemd/system/opensnitchd.service $def_path/tmp/profile/airootfs/etc/systemd/system/
        cd $def_path
        }; script
        fi
}

if [ -f "$def_path/tmp/profile/airootfs/usr/bin/opensnitch" ]; then
echo "[OpenSnitch] -> [!OK!]"
sleep 1
else
case_opensnitch 2>&1
sleep 1
fi




case_apparmor() {

        if [ -d "$def_path/tmp/apparmor.d-gita" ]; then
        echo "[Apparmor.d] -> [!Src Exist!]"

        if [ -d "$def_path/tmp/profile/airootfs/etc/apparmor.d" ]; then
        echo "[Apparmor.d] -> [Build...]"
        script() {
        git clone https://aur.archlinux.org/apparmor.d-git.git $def_path/tmp/apparmor.d-git
        cd $def_path/tmp/apparmor.d-git
        makepkg -sf
        cd $def_path
        mv -f $def_path/tmp/apparmor.d-git/pkg/apparmor.d-git/*  $def_path/tmp/tmp/profile/airootfs/
        mv -f $def_path/tmp/apparmor.d-git/pkg/apparmor.d-git $def_path/tmp/tmp/
        }; script
        echo "[Apparmor.d] -> [!OK!]"
        fi



        sleep 1
        else
        echo "[Apparmor.d] -> [Build...]"

        script() {
        git clone https://aur.archlinux.org/apparmor.d-git.git $def_path/tmp/apparmor.d-git
        cd $def_path/tmp/apparmor.d-git
        makepkg -sf
        cd $def_path
        sudo cp -r $def_path/tmp/apparmor.d-git/pkg/apparmor.d-git/*  $def_path/tmp/profile/airootfs/
        mv -f $def_path/tmp/apparmor.d-git/pkg/apparmor.d-git $def_path/tmp/
        }; script
        echo "[Apparmor.d] -> [!OK!]"
        fi

}

if  [ -d "$def_path/tmp/profile/airootfs/etc/apparmor.d" ]; then
echo "[Apparmor.d] -> [!OK!]"
sleep 1
else
case_apparmor 2>&1
fi


case_libhardened_malloc() {

        if [ -d "$def_path/tmp/hardened_malloc" ]; then
        echo "[Hardened_Malloc] -> [!Src Exist!]"
        sleep 1
        else
        echo "[Hardened_Malloc] -> [Build...]"

        script() {
        git clone https://github.com/GrapheneOS/hardened_malloc/ $temp_dir/hardened_malloc
        cd $temp_dir/hardened_malloc
        make
        cd $def_path
        mv -f $temp_dir/hardened_malloc $def_path/tmp/
        cp $def_path/tmp/hardened_malloc/out/libhardened_malloc.so $def_path/tmp/profile/airootfs/usr/lib/libhardened_malloc.so

        }; script
        cd $def_path
        fi


}

if [ -f "$def_path/tmp/profile/airootfs/usr/lib/libhardened_malloc.so" ]; then
echo "[Hardened_Malloc] -> [!OK!]"
sleep 1
else
case_libhardened_malloc 2>&1
sleep 1
fi

rm -rf "$temp_dir" > /dev/null 2>&1
sudo chown -R live $def_path/tmp/profile

