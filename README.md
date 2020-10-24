# orchestration for goNodeNetwork

## To run this:

 - Make sure that your docker pulls from dockerhub...idk how to ensure that.
 - Clone this repo and run `make init` to start the app, run `make end` to teardown the app

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
     - Deployment.yaml for JUST the node app
     - Service.yaml for JUST the node app
     - Contact the app via kubectl proxy
   - Todo:
     - Deployment.yaml for both apps (I can deploy both but network/not working)
     - Service.yaml (I think this actually works but need to verify with above)
     - Can I contact the app outside of kubectl proxy?
