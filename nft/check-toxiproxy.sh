while [ 1 ];do
  clear
  toxiproxy-cli l
  toxiproxy-cli inspect cache-node-1
  sleep 5
done
