sudo apt install git ninja-build libarchive-dev bsdtar

sudo pip3 install meson

git clone https://gitlab.archlinux.org/pacman/pacman --depth 1

mkdir pacman -p
cd pacman
meson build
cd build
ninja
sudo ninja install
cd ..

source build-pkgbuild.sh

makepkg --conf ./makepkg.conf
