Documentation for Second Hand - In Large System Development


Part 1: The application
Our application consists of a NodeJS project, which handles the back-end and ReactJS which handles the 
front-end of the application. Both of them are a part of the same javascript project on github. The 
link to the github repository is https://github.com/shrestaz/TechNews-Jenkins.git. As of right now,
it has to be instantiated locally as we have not been successfully able to deploy it using Jenkins
and Docker onto a DigitalOcean Droplet. Details on this is explained on the third part of the document 
which includes the setup process and the problems we faced. 

Part 2: CD Technology

 For our continuous  integration server we picked Jenkins. We decided to pursue it after we had to 
 do exercise for continuous integration of Java web app. There were challenges faced and we decided 
 to do the integration using Travis but this is for future implementation. 

The web app itself has a front - end and backend - part written in React.js and Node.js. For database
Mysql has been used. We already had a part of it developed and working fine. But for this assignment
we simplified it and left it without database.  That has been done  because the Node app by itself builds
successfully but when Jenkins try to use the image to deploy it fails with the mistake:
Error: listen EADDRINUSE :::3000
 

Part 3: Setup

We setup a new user, Jenkins, on the virtual machine instantiated by vagrant provided by the teacher.
We also created a Dockerfile inside the project folder which included a few lines of code to create a
docker image of the project environment and push it into the docker hub. That docker image can be used
to create various containers with the same development environment we, as developers, intended in various
virtual machines.
//Jenkins’ screenshot
//Dockerhub screenshot
