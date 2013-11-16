ssh-support
===========
Give a friend temporary access to ssh into your workstation. He or she will be
able to see what you are doing and can easily terminate accees at any time. 

We use an intermediate host and a few reverse tunnels to make this work. 

Overview
--------
This project still needs a lot of polish, but the very basics are working. 


Usage
-----
Server side (this workstation of the person you want to help): 
```
./run.sh server tunnel.example.com tunnel-user supportee-username
```


Client side (your workstation): 
```
./run.sh client tunnel.example.com tunnel-user supportee-username
```


TODOs
-----
* The argument list is a mess. I just moved hardcoded values there to be able to upload the script. I should probably use env vars.
* It should be possible to IM a single line to your friend, have him paste that in the console and have it "just work". 
* This is my first attempt at non-trivial shell scripting and I'm sure it's terribly naive. Suggestions for improvement would be most welcome. 
