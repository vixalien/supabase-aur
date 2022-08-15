TAG_NAME=$(curl https://api.github.com/repos/supabase/cli/releases/latest \
| grep tag_name \
| cut -d : -f 2,3 \
| tr -d \" \
| tail -c +2 \
| head -c -2)

echo $TAG_NAME

wget https://github.com/supabase/cli/releases/download/v$TAG_NAME/supabase_${TAG_NAME}_linux_amd64.tar.gz

SHASUM=$(sha256sum supabase_${TAG_NAME}_linux_amd64.tar.gz | cut -d" " -f 1)

# writing the new PKGBUILD

cat << EOF > PKGBUILD
# Maintainer: Angelo Verlain <hey@vixalien.com>

pkgname=supabase-bin
pkgver=${TAG_NAME}
pkgrel=1
pkgdesc="A CLI for Supabase, an open source Firebase alternative"
url="https://github.com/supabase/cli"
license=("MIT")
arch=("x86_64")
provides=("supabase")
conflicts=("supabase")
EOF

cat << \EOF >> PKGBUILD
source=("https://github.com/supabase/cli/releases/download/v$pkgver/supabase_${pkgver}_linux_amd64.tar.gz")
EOF

cat << EOF > PKGBUILD
sha256sums=("$SHASUM")
EOF

cat << \EOF >> PKGBUILD

package() {
    install -Dm755 supabase -t "$pkgdir/usr/bin"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
}

EOF
