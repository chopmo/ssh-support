#!/bin/bash
set -x

role=$1
tunnel_host=$2
tunnel_host_username=$3
server_host_username=$4


ssh_tunnel_port=22222
terminal_tunnel_port=22223
client_nc_port=22224
client_ssh_port=22225

pipe_path=/tmp/ssh-support

function run_client {
  if ! [ -p $pipe_path ]; then
    mkfifo $pipe_path
  fi

  ssh -N $tunnel_host_username@$tunnel_host -L $client_ssh_port:127.0.0.1:$ssh_tunnel_port -L $client_nc_port:127.0.0.1:$terminal_tunnel_port &
  ssh_pid=$!

  sleep 1

  nc 127.0.0.1 $client_nc_port 0<$pipe_path &
  nc_pid=$!

  ssh -p $client_ssh_port $server_host_username@127.0.0.1 | tee $pipe_path

  kill $nc_pid
  kill $ssh_pid
}


function run_server {
  echo "RUNNING SERVER"
  ssh -N $tunnel_host_username@$tunnel_host -R $ssh_tunnel_port:127.0.0.1:22 -R $terminal_tunnel_port:127.0.0.1:$terminal_tunnel_port &
  ssh_pid=$!
  nc -l 127.0.0.1 $terminal_tunnel_port
  kill $ssh_pid
}

if [[ "$role" == "server" ]]
then run_server
else run_client
fi
