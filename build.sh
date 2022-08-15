sudo aptitude install libarchive-dev bsdtar

git clone git://projects.archlinux.org/pacman.git

cd pacman
./autogen.sh
./configure --disable-doc
make
sudo make install
cd ..

source build-pkgbuild.sh

makepkg --conf ./makepkg.conf
