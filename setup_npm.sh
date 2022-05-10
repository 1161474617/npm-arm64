  #!/bin/bash
   echo "检测CPU架构"
  hw_arch=$(uname -m)
  if [ "$hw_arch" = "aarch64" ];then
        hw_a=arm64
   elif ["$hw_arch" = "x86_64"];then
        hw_a=x64
   else 
        echo "只支持64位x86和arm"
        exit
   fi
   echo "下载$hw_a架构的nodejs"
   echo "--------------------------"
  
  echo "不输入默认为最新稳定版，输入latest为最新版本，或直接输入版本。列如：16.10.0"
  read -p "nodejs版本：" node

  if [ "$node" = "latest" ];then

node_ver=18.1.0


elif [ -z "$node" ];then

node_ver=16.15.0

else

node_ver=$node

fi

 echo "下载$hw_a架构${node_ver}版本nodejs"

  node_install_path="/opt/node-${node_ver}-linux-$hw_a"

  echo "[x] rm -irf ${node_install_path}"
  rm -irf ${node_install_path}

  echo "[→] cd /opt || exit"
  cd /opt || exit

  echo "[↓] wget https://npm.taobao.org/mirrors/node/v${node_ver}/node-v${node_ver}-linux-$hw_a.tar.gz"
  wget https://npm.taobao.org/mirrors/node/v${node_ver}/node-v${node_ver}-linux-$hw_a.tar.gz

  echo "[↑] tar -zxf node-v${node_ver}-linux-$hw_a.tar.gz"
  tar -zxf node-v${node_ver}-linux-$hw_a.tar.gz

  echo "[x] rm -rf node-v${node_ver}-linux-$hw_a.tar.gz"
  rm -rf node-v${node_ver}-linux-$hw_a.tar.gz

  echo "[x] Delete the original Node link"
  rm -f /usr/bin/npm
  rm -f /usr/bin/node
  rm -f /usr/local/bin/npm
  rm -f /usr/local/bin/node

  echo "[+] Creating a Node link"
  ln -s ${node_install_path}/bin/npm /usr/bin/
  ln -s ${node_install_path}/bin/node /usr/bin/
  ln -s ${node_install_path}/bin/npm /usr/local/bin/
  ln -s ${node_install_path}/bin/node /usr/local/bin/

  echo "=============== Node Version ==============="
  echo " node: $(node -v)"
  echo " npm: $(npm -v)"
  echo "=============== Node Version ==============="
  echo
  echo "[-] Node Installed Successfully!"
  echo

  sleep 3