ping -c4  10.0.0.1 > /dev/null

if [ $? != 0 ]
then
  echo "No network connection, restarting ppp0"
  sudo service dovpn stop
  sleep 3
  sudo service dovpn start
else
  echo "Vpn connected!"
fi
