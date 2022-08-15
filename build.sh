sudo aptitude install libarchive-dev bsdtar

git clone git://projects.archlinux.org/pacman.git

mkdir pacman -p
cd pacman
./autogen.sh
./configure --disable-doc
make
sudo make install

cd package
cp /usr/local/etc/makepkg.conf ./makepkg-arm.conf

source build-pkgbuild.sh

makepkg --conf ./makepkg.conf
