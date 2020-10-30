init:
	echo "Init commands"
	docker network create goNodeNet
	docker run -d --name goDocker -p 6060:8080 --rm --network goNodeNet diakou/go-docker:1.2
	docker run -d --name nodeDocker -p 8888:3000 --rm --network goNodeNet diakou/node-docker:1.1

end:
	echo "End commands"
	docker stop goDocker
	docker stop nodeDocker
	docker network rm goNodeNet

up:
	echo "Docker Compose Up -- initalizing. Contact Go Server at localhost:6060"
	docker-compose up

down:
	echo "Docker Compose Down -- tearing down infra."
	docker-compose down

install:
	echo "Kube starting via helm chart"
	helm install gonodekube ./goNodeKube

uninstall:
	echo "Kube tearing down via helm"
	helm uninstall gonodekube

reveal:
	kubectl port-forward svc/go-node-kube 6060:80
