# orchestration for goNodeNetwork

## To run this:

 - Clone https://github.com/grebnesorbocaj/goDocker and run `make build`
 - Clone https://github.com/grebnesorbocaj/nodeDocker and run `npm run docker:build`
 - Clone this repo and run `make init` to start the app, run `make end` to teardown the app

## Send a GET Request
 - Send a request to http://localhost:6060/monkeys
 - This will contact goDocker container which will return "monkeys"
 - The Go container will contact the nodeDocker container which will add logs with the time in src/log/access.log
   - view the log by entering the container with `docker exec -it nodeDocker bash` and navigate to the log
