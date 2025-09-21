
echo "Running frpc..."
nohup ./frp/frpc -c ./frp-scripts/frpc-mac.ini > frpc.log 2>&1 &
