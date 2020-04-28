# A script to manage protostar docker setup
# By th3happybit (Oussama Messabih)
#!/bin/bash
if [ $# -gt 0 ]; then
    if [[ "$1" == "build" ]]; then
    	echo -e "\e[34mBuilding protostar...\e[0m"
    	sudo docker build -t th3hpbt/protostar:0.1 .
		echo -e "\e[32mDone.\e[0m"
	elif [[ "$1" == "stop" ]]; then
		echo -e "\e[34mStop protostar...\e[0m"
    	sudo docker stop protostar
		echo -e "\e[32mDone.\e[0m"
	elif [[ "$1" == "start" ]]; then
		echo -e "\e[34mStarting protostar...\e[0m"
	    if sudo docker start protostar; then
	    	echo -e "\e[32mDone.\e[0m"
	    	echo -e "SSH server:port: \e[32m$(sudo docker port protostar 22)\e[0m"
	    else
	    	echo -e "\e[31mprotostar container doesn't exists, please run it!"
	    fi
	elif [[ "$1" == "run" ]]; then
		echo -e "\e[34mRunning protostar...\e[0m"
		if sudo docker run --privileged -d -P --name protostar th3hpbt/protostar:0.1; then
			echo -e SSH server:port: $(sudo docker port protostar 22)
			echo -e "\e[32mDone.\e[0m"
		else
			echo -e "\e[31mprotostar container already exists, please just start it!"
		fi
	elif [[ "$1" == "connect" ]]; then
		echo -e "\e[34mConnecting to protostar...\e[0m"
		if sudo docker exec -it protostar bash; then
			echo -e "\e[32mBye.\e[0m"
		else
			echo -e "\e[31mprotostar container doesn't exists, please start/run it!"
		fi
	elif [[ "$1" == "remove" ]]; then
		echo -e "\e[34mRemoving to protostar...\e[0m"
		if sudo docker stop protostar && sudo docker rm protostar; then
			echo -e "\e[32mRemoved.\e[0m"
		else
			echo -e "\e[31mprotostar container doesn't exists, no need to remove it!"
		fi
	elif [[ "$1" == "help" ]]; then
		echo -e "\e[34mUsage: ./protostar.sh [OPTION]"
		echo -e "options:"
		echo -e "	build: to build the image"
		echo -e "	start: to start the container for first time"
		echo -e "	stop: to stop the container"
		echo -e "	run: to run an existing container"
		echo -e "	connect: to connect and get in the protostar container"
		echo -e "	remove: to remove the protostar container"
		echo -e "	help: to show up this menu"
    fi
else
	echo -e "\e[34mUsage: ./protostar.sh [OPTION]"
	echo -e "options:"
	echo -e "	build: to build the image"
	echo -e "	run: to run the container for the first time"
	echo -e "	stop: to stop the container"
	echo -e "	start: to start an existing container"
	echo -e "	connect: to connect and get in the protostar container"
	echo -e "	remove: to remove the protostar container"
	echo -e "	help: to show up this menu"
fi