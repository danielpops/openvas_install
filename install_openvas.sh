# SCRIPT GENERATED BY CHRISTIAN FERNANDEZ A MEMBER OF THE HISPAGATOS LABS



# arch linux: get install uuid https://aur.archlinux.org/packages/uuid
# arch linux: get install wmiclient https://aur.archlinux.org/packages/wmi-client/
# arch linux: install libpcap libssh libldap libksba  gpgme glib sqlite3 libxml2 libxslt  libmicrohttpd libxslt

# http://download.opensuse.org/repositories/security:/OpenVAS:/UNSTABLE:/v6/xUbuntu_13.04/amd64/

#    This script has a GPLv3 License
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#



DIRECTORY="~/openvas-dev"
VERSION="+beta1"
LIBRARIES="openvas-libraries-7.0"
SCANNER="openvas-scanner-4.0"
MANAGER="openvas-manager-5.0"
GREENBONE="greenbone-security-assistant-5.0"
CLI="openvas-cli-1.3"


if [ ! -d "$DIRECTORY" ]; then
  mkdir openvas-dev
fi

cd ~/openvash-dev

sudo apt-get -y install sudo build-essential make cmake pkg-config nmap libssh-dev gnutls-dev libglib2.0-dev libpcap-dev libgpgme11-dev uuid-dev bison libksba-dev rsync sqlite3 wget curl alien fakeroot libmicrohttpd-dev libxml2-dev libxslt1-dev xsltproc


echo "exporting PGK_CONFIG_PATH"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/openvas/lib/pkgconfig



echo "Downloading and building $LIBRARIES$VERSION"
if [ ! -f "$LIBRARIES$VERSION.tar.gz" ]; then

  wget -O $DIRECTORY http://wald.intevation.org/frs/download.php/1340/$LIBRARIES$VERSION.tar.gz
fi


tar zxvf openvas-libraries-*
cd openvas-libraries-*

if [  -d "build" ]; then
  echo "removing build directory for $LIBRARIES$VERSION"
  rm -rf  build
fi

mkdir build

cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvas ..
make
make doc
sudo make install
make rebuild_cache
cd $DIRECTORY


echo "Downloading and building $SCANNER$VERSION"
if [ ! -d "$SCANNER$VERSION.tar.gz" ]; then
  wget -O $DIRECTORY http://wald.intevation.org/frs/download.php/1344/$SCANNER$VERSION.tar.gz
fi

tar -zxvf openvas-scanner-*

cd openvas-scanner-*

if [  -d "build" ]; then
  echo "removing build directory for $SCANNER$VERSION"
  rm -rf  build
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvas ..
make
make doc
sudo make install
make rebuild_cache
cd $DIRECTORY



echo "Downloading and building $MANAGER$VERSION"
if [ ! -d "$MANAGER$VERSION.tar.gz" ]; then
  wget -O $DIRECTORY http://wald.intevation.org/frs/download.php/1350/$MANAGER$VERSION.tar.gz
fi

tar -zxvf openvas-manager-*
cd openvas-manager-*

if [  -d "build" ]; then
  echo "removing build directory for $MANAGER$VERSION"
  rm -rf  build
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvas ..
make
make doc
sudo make install
make rebuild_cache
cd $DIRECTORY



echo "Downloading and building $GREENBONE$VERSION"
if [ ! -f "$GREENBONE$VERSION.tar.gz" ]; then
  wget -O $DIRECTORY http://wald.intevation.org/frs/download.php/1365/$GREENBONE$VERSION.tar.gz
fi

tar -zxvf greenbone-security-assistant-*

cd greenbone-security-assistant-*

if [  -d "build" ]; then
  echo "removing build directory for $GREENBONE$VERSION"
  rm -rf  build
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvas ..
make
make doc
sudo make install
make rebuild_cache
cd $DIRECTORY



echo "Downloading and building $CLI$VERSION"
if [ ! -f "$CLI$VERSION.tar.gz" ]; then
  wget -O $DIRECTORY http://wald.intevation.org/frs/download.php/1369/$CLI$VERSION.tar.gz
fi

tar -zxvf openvas-cli-*
cd openvas-cli-*

if [  -d "build" ]; then
  echo "removing build directory for $CLI$VERSION"
  rm -rf  build
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvas ..
make
make doc
sudo make install
make rebuild_cache
cd $DIRECTORY

echo "Adding openvas to the enviroment PATH"
export PATH=/opt/openvas/bin:/opt/openvas/sbin:$PATH


sudo sh -c "echo '/opt/openvas/lib' >> /etc/ld.so.conf.d/openvas"
suco sh -c "echo '/opt/openvas/lib' >> /etc/ld.so.conf"
sudo ldconfig

# this above did not work for me I had to manually edit /etc/ld.co.conf
# and add /opt/openvas/lib
# then run ldconfig


sudo chmod -R 777 /opt/openvas/var/log
sudo chmod -R 777 /opt/openvar/var/run
sudo chmod 644 /opt/openvas/var/lib/openvas/private/CA/serverkey.pem


#configure

echo "CONFIGURE"

echo "sudo openvas-mkcert"

echo "sudo openvas-mkcert-client -n -i"

echo "sudo openvasmd --rebuild"


echo "Create your first user"
echo "openvasmd --first-user=myuser"


#sudo  mkdir /opt/openvas/tmp
#sudo  chmod 777 /opt/openvas/tmp

echo "if any issues download and run"
echo "wget --no-check-certificate https://svn.wald.intevation.org/svn/openvas/trunk/tools/openvas-check-setup"
