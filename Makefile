init:
	echo "Init commands"
	docker network create goNodeNet
	docker run -d --name goDocker -p 6060:8080 --rm --network goNodeNet diakou/go-docker
	docker run -d --name nodeDocker -p 8888:3000 --rm --network goNodeNet diakou/node-docker

end:
	echo "End commands"
	docker stop goDocker
	docker stop nodeDocker
	docker network rm goNodeNet
