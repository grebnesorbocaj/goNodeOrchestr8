# orchestration for goNodeNetwork

## To run this:

 - Make sure that your docker pulls from dockerhub...idk how to ensure that.
 - Clone this repo and run ~~`make init`~~ `make up` to start the app, run ~~`make end`~~ `make down` to teardown the app
 - If you have kubernetes, kind, and helm installed:
   - `make install` to startup pods and service
   - `make reveal` to expose the service (and app) at `localhost:6060`
   - `make uninstall` to teardown pod and service

## Send a GET Request
 - Send a request to http://localhost:6060/monkeys
 - This will contact goDocker container which will return "Hi there, I love monkeys!"
 - The Go container will contact the nodeDocker container which will add logs with the time in src/log/access.log
   - view the log by entering the container with `docker exec -it nodeDocker bash` and navigate to the log

### Comments
 - Made some changes to each server's docker image to make it smaller
   - nodeDocker now uses node:alpine base over node:latest
     - original: >1GB using node:latest
     - current: ~220MB using node:alpine
   - goDocker now uses multistage docker with final image just being the server as binary in alpine
     - original: 700MB -> golang:onbuild
     - current: 12MB -> golang:alpine to build binary in stage 1, copy binary into alpine base stage 2
 - Added docker-compose which can be implemented with `make up` and torn down with `make down`
 - Working on running this in kubernetes
   - Done:
     - Deployment.yaml for ~~JUST~~ the node app and go app
     - Service.yaml for ~~JUST~~ the node app and go app
     - ~~Contact the app via kubectl proxy~~
     - Can I contact the app outside of kubectl proxy?
       - `kubectl port-forward svc/go-node-kube 6060:80`
       - This will forward the service to be exposed at `localhost:6060`
     - Modified GoApp so that it checks the HOST env variable to determine target URL.
       - `localhost` in Kubernetes
       - `nodedocker` in Docker-Compose


### Links

#### Go App
 - GitHub: https://github.com/grebnesorbocaj/goDocker
 - DockerHub: https://hub.docker.com/r/diakou/go-docker
 
#### Node App
 - Github: https://github.com/grebnesorbocaj/nodeDocker
 - DockerHub: https://hub.docker.com/r/diakou/node-docker
