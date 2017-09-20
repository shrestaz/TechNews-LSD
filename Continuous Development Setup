Continuous Deployment Setup
---------------------------

**Introduction**

Our application consists of a NodeJS project, which handles the back-end and ReactJS which handles the front-end of the application. Both of them are a part of the same javascript project on github. The link to the github repository is as follows.

> https://github.com/shrestaz/TechNews-Jenkins.git

As of right now, it has to be instantiated locally as we have not been successfully able to deploy it using Jenkins and Docker onto a DigitalOcean droplet. 

For our continuous integration server, we worked with Jenkins. We decided to pursue it after we had to do exercise for continuous integration of Java web application. There were challenges faced and we have decided to do the integration using Travis but for future implementation.

The web app itself has a front - end and backend - part written in React.js and Node.js. For database, Mysql has been used. We already had a part of it developed and working fine. But for this assignment we simplified it and left it without database. That has been done because the node app by itself builds successfully but when Jenkins tries to use the image to deploy it fails with the mistake: `Error: listen EADDRINUSE :::3000`

**Setup**

We setup a new user, Jenkins, on the virtual machine instantiated by vagrant provided by the teacher. We also created a Dockerfile inside the project folder which included a few lines of code to create a docker image of the project environment and push it into the docker hub. That docker image can be used to create various containers with the same development environment we, as developers, intended in various virtual machines.

