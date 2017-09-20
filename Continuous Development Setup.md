Continuous Deployment Setup
---------------------------

**Introduction**

Our application consists of a NodeJS project, which handles the back-end and ReactJS which handles the front-end of the application. Both of them are a part of the same javascript project on github. The link to the github repository is as follows.

> https://github.com/shrestaz/TechNews-Jenkins.git

As of right now, it has to be instantiated locally as we have not been successfully able to deploy it using Jenkins and Docker onto a DigitalOcean droplet. We decided to use Jenkins because we had to do an exercise for Continuous Integration of Java web application in the class. There were challenges faced for our application because it is in JavaScript and we had to do a lot of research on our own. We have now decided to do the integration using Travis but for future implementation.

![Current front end of the web app](https://lh3.googleusercontent.com/pwkzpRH-Ebh_Fbl9WYEjgMgYepbFSKDA49QUbYMqrPRYhBKDj727DEuv4H27LbeeyytGkzuvwVGZoA=s0 "Screenshot-20170920100815-653x521.png")

*Current front end of the web app*


The web app itself has a front-end and back-end - part written in ReactJS and NodeJS. For database, MySQL has been used. We already had a part of it developed and working fine. But for this assignment we simplified it and left it without database. That has been done because the node app by itself builds successfully but when Jenkins tries to use the image to deploy it fails with the error: 
`Error: listen EADDRINUSE :::3000`

From our understanding, it occurs because the port has been used by other application and is not available for the web app to use but we tried many random ports and still faced the same error.

![enter image description here](https://lh3.googleusercontent.com/RVhb2CB2IdULGnpYb7Zgs4jHPXrDTCJD8B-VJABiSv8AHm_flR7y_jelPb5R0IxRWFXs15sP98olow=s0 "Screenshot-20170920102040-1364x424.png")
*Screenshot of the error*

**Setup**

We setup a new user, Jenkins, on the virtual machine instantiated by vagrant provided by the teacher. We also created a Dockerfile inside the project folder which included a few lines of code to create a docker image of the project environment and push it into the docker hub. That docker image can be used to create various containers with the same development environment we, as developers, intended in various virtual machines.

The following screenshot shows that the container image had been created and pulled through Jenkins to instantiate the container.
![enter image description here](https://lh3.googleusercontent.com/gcatkn5quaylPqu9qeu4-xdsUHipc8r3MUY_FYmXRL_7i2iJJ8JCYMsHFvIUWUXPH3SRFCCR9TW3_A=s0 "Screenshot-20170920101744-1361x386.png")

In the following screenshot, **Build #18**, it passed the build and pushed the container image to docker hub but didn't instantiate the container due to lack of code.
![enter image description here](https://lh3.googleusercontent.com/YFREFMWRyw-Ec1U5N1ZevmMAbgWCsAD1fnfvwaPUVHkPjwM24B-4ACC4tjwEiuspAugwlXvYayOApA=s0 "Screenshot-20170920101944-1364x436.png")



The following is **Build #52**. As you can realize, we tried to build many times but fails in the end because of the error explained above, the one with the port being unavailable.
![enter image description here](https://lh3.googleusercontent.com/cwssh8OhB0tTdTnbi514X6j0GtBdJviJG70nHekpX21n4TewecFBbzP9mryeBUsMqccWfRBsmvf3YQ=s0 "Screenshot-20170920101905-1364x421.png")