Hacker News Report - Large System Development
---------------------------------------------
### <img src="https://upload.wikimedia.org/wikipedia/commons/a/a2/Simpleicons_Business_pencil.svg" width="18" height="18" /> **Group G**
Yoana Dandarova

Manish Shrestha

## Introduction

Hacker News clone project was designed with teamwork in mind. Not only that, it integrated how the development of large systems is done, assignment of different roles to the team members and operations & maintenance of systems.

This project was based on a set of requirements, fulfilling a set of features and a defined format of the API.

The project cycle is divided into 2 phases.

 - Development of 9 weeks
 - Operations & Maintenance of 6 weeks

As students, we had always been developing parts of systems fulfilling certain requirements. This project required our system had to be fully functional for the operating group and the simulation program to interact with. Also, since it’s a large system, a continuous integration chain had to implemented to prevent faulty code from breaking the system.

As for the second phase, a world of technologies and tools were introduced. This included implementing monitoring, logging, security and scaling to name a few. We also had to use the same tools to operate and monitor other group’s system. This allowed us to keep track of whether the service-level agreement was fulfilled or not.

## 1. Requirements, architecture, design and process

### 1.1. System requirements

The minimal requirements of the system is to create a web application which is a clone of the Hacker News website (news.ycombinator.com) consisting at least of a frontend system, a backend system and a database.

The following lists all the requirements of the project.

1. **Front-end system**: presents an overview of the stories and is responsible for ingesting stories and comments
2. **Back-end system**: digests the data received from the front-end and it provides the corresponding data to the front-end.
3. **Database**: for persistent storage of user data, stories and comments.
4. **REST API**: such that a simulator program can publish stories and comments and also an external application can query the status of the system (i.e Alive, Upgrading, Down)
5. **Minimum uptime of 95%** during 6 weeks period.

### 1.2. Development process

Being a very small team of two and with the nature of the project, we applied Agile development as our methodology. To be specific, within Agile, we took the SCRUM approach as our project included a short development cycle with incremental and iterative development. We practised a lot of open communication and pair programming. Our project included application of new tools and technologies every week and they were timeboxed. We had to iterate through the project as better solutions were introduced to us (for example, scaling with the use of docker swarms). The project also constant involvement from end users (operators) and product owners which is what Agile development is based upon. This ensures that customer value is being added at all times, and that progress is being made on what matters, working software. 

Waterfall model and Unified Process was not considered for their own reasons. One common reason is that we didn’t have big of a team to implement either of them. Compared to 4-5 team members on other groups, we were only 2 in a group and required faster development strategy and UP/Waterfall development doesn’t allow that. 

We specifically didn’t choose the Waterfall model as we needed to iterate through the project. Since Waterfall model is not adaptive to change, which we absolutely required, this was not an ideal choice.

As for Unified Process, it follows the general phases of inception, elaboration, construction and transition. Yes, it allows iterative and incremental development but less time is spent on requirements and analysis and more time is spent on construction, transition and testing.

### 1.3. Software architecture, design and implementation

![enter image description here](https://lh3.googleusercontent.com/wNC4WWnTQHwPj-E1_Vrh88sPWltvh-OzXc5YEB5TN3wlEwOe2rkhRBBPoe_9NUz-wU7G5KcvJo2Wgg=s0 "Software Architecture")


Every component of the final system is a Docker container complementing each other, working on 2 separate DigitalOcean droplets. Most of it is automated by webhooks and scripts, in combination with continuous integration chain. Each component is exposed on their own ports so developers and operators can tweak and perceive when appropriate. The following is a detailed explanation of each components in the architecture.

The software architecture consists of the following components:

#### 1.3.1 Development
The two teammates have the same version of project on their local machines. Github webhook has been added to the continuous integration tool, Jenkins. On every push to GitHub, the commit is built by [Jenkins on our DigitalOcean droplet](http://207.154.245.251:9090)  where it has been hosted.


![enter image description here](https://raw.githubusercontent.com/shrestaz/TechNews-LSD/master/githubhook.png)

*Picture 1: Github Webhook*

 

*Picture 1* shows how this webhook has been set. The Jenkins hook URL points to port 9090 on the server, exactly where Jenkins is deployed.

#### 1.3.2. Continuous Integration
The Jenkins builds the code and on success creates a new  docker image of the code and pushes it to docker hub. *Picture 2* represents the build status of our Node.js API.


![Jenkins Build](https://lh3.googleusercontent.com/QupJiXi3p3jW8oF0lZ-h1EFAkBjtV9lVcD5gkowEHE3cur8KLhNXeFtEBa2LUp9W3evaaf1l6jVoBQ=s0 "Jenkins Build")
*Picture 2: Jenkins build status*

![Jenkins Script](https://lh3.googleusercontent.com/d5zHX-w4Szqf6KcWv9SH324vX78CjmtR_97CCiVO2zWA7oo6PLCL-wEan8cgwchILSZPpbMz-uMmMw=s0 "Jenkins script")
*Picture 3: Jenkins shell script*

*Picture 3* shows the shell script in Jenkins that builds an image from successful build job and logs in to `thatonedroid` account on docker hub, pushes the image as `hackernewsapi` and logs out.

#### 1.3.3. Hosting and Deployment
We have a DigitalOcean droplet where our system is hosted. To start all containers, we `ssh` into the droplet, setup the `docker-compose.yml` file and execute the command `docker-compose up -d` .
Our `docker-compose.yml` file is setup like this:

![Docker-compose](https://lh3.googleusercontent.com/1Mg_buj8pcNWK9QfiiVkYSR9k1OZ1PYhR-mUfrFgaC_G6gSnF3nWV558_wStqngbVvKD5F_mdaUXLg=s0 "docker-compose")

When all containers are running we have the system up.

We have chosen the approach to work with Docker containers instead vagrant because with containers ,we have almost all services running in one droplet over a bridged network. That way we save money from running all different services on different droplets and all containers can communicate with each other by default without further setup. The only service that is running on another droplet is the ELK stack which is hosted on http://159.89.2.54:5601

In order for the ELK stack to be functional and running the following, `docker-compose.yml` file was created:

![Docker-compose ELK](https://lh3.googleusercontent.com/lTfmTesmfcr9l-VS32nwu-HRjPKmqQ-JopDwWjOJDBe1vkaGJYujuNPBNwQLwCxkrgTqUSLSfrWsAg=s0 "docker-compose elk")

Along with the docker-compose file there two configuration files created. `01-http-input.conf` and `30-output.conf`. These files tells logstash that it accepts log data through http on port: 9700 and whatever it does with that data, it does it. According to documentation, it filters the data and prepares it for output. The output here is elasticsearch.

![ELK](https://lh3.googleusercontent.com/5cAOEmI9haXFxuiqgZh8-Xxanj0p9eb6czPdAosQ9O3sWjQjlVMXJ0-TBE6TBiO3Fenadn_eURsXew=s0 "ELK")

The output points to elasticsearch which is located on the localhost. The explanation here is that the image runs in one container. Due to this, all elements of the ELK stack are located on localhost for each other. Inside our Node.js API,  we have configured log4js npm module to output its logs to http://159.89.2.54:9700

```
appenders: {
       logfaces: { type: 'logFaces-HTTP', url: 'http://159.89.2.54:9700' },
       fileAll: { type: 'file', filename: '/var/log/logsAll.log' },
       console: { type: 'console'},
       fileInfo: { type: 'file', filename: '/var/log/logsInfo.log' },
       fileError: { type: 'file', filename: '/var/log/logsError.log' },
       fileDebug: { type: 'file', filename: '/var/log/logsDebug.log' },
       }
```
![Kibana](https://lh3.googleusercontent.com/s7fhE-AfWSkMOBuQVjSihjzmG6uVtOICNfjpwHtSQEB1a_6WShcIFvjKbnlr9vwdIKF0GiOsDaL1Kg=s0 "kibana.png")

*Picture 4: Kibana activity*

*Picture 4* displays the requests activity to our server. On the 15.12.2017, Kibana was asked to show requests activity for the last 30 days. The activity shows from its start day when the ELK stack droplet was created to start logging. This period is 27.11.2017 until the last day the Helge’s script was running, 15.12.2017. Interesting statistics have been seen through Kibana. For example:
The system is able to digest up to 6 requests for 200 milliseconds(Picture 5). The logging helped us realize why some posts did not get digested. Two main reasons were that post_title and post_text needed to accept more characters.

![Kibana](https://raw.githubusercontent.com/shrestaz/TechNews-LSD/master/6milliseconds.png)

*Picture 5: Kibana Requests*

> [Detailed documentation of ELK stack implementation can be found here.](https://github.com/shrestaz/TechNews-LSD/blob/master/Logging%20and%20Post-mortem%20analysis.md)

##### 1.3.3.1 Database:
The MySQL database is built to be as simple as possible.

![Posts Table](https://raw.githubusercontent.com/shrestaz/TechNews-LSD/master/phpmysql.png)
*Picture 6: Post Table*

*Picture 6* represents the post table in our hackernews database. Here `hannest_id` is primary key, unique and auto-increment. There is foreign key constraint with the user table.

![User Table](https://raw.githubusercontent.com/shrestaz/TechNews-LSD/master/usertable.png)
*Picture 7: User Table*

*Picture 7* shows how we implemented the user table. For primary key we have decided to use `username` and `password` to uniquely identify an user.  
If the reader wants to check out themselves the structure of our database, it is available through [phpMyAdmin](http://207.154.245.251:8080/db_structure.php?server=1&db=hackernews).

The Dockerfile that is used to create the database image(thatonedroid/hackernewsapi) is :

![DB Seed](https://lh3.googleusercontent.com/iQBTXsqjTKGFHHCZym_Y-fXhCexmnyM3MOUGvI_Ex86AGZ_JxEjhbw-0SjHDG4gmydGZBtLmAn7D3g=s0 "DBseed")

Here dbseed.sql is the initial structure of the database.

[**The script can be viewed here.**](https://github.com/shrestaz/TechNews-LSD/blob/master/dbseed.sql)

This is the script for the initial set-up of the database structure. After volume has been created for this database the initial structure script will not be executed.


#### 1.3.3.2. Back-end system:
The back-end of the system  was written in Node.js with Express framework. It consists of 6 routes which shows the index page, lists posts, lists users, gets latest `hannest_id`, shows system status and metrics for monitoring. This REST API handles CRUD operations initiated by the operators or the simulator system.

[Source code for the API, hosted on GitHub](https://github.com/expert26111/NodeServer)

#### 1.3.4 Monitoring:

Prometheus and Grafana were used for monitoring and analysis of the system.

There is a configuration file on the root of the project which has target defined with the system’s API. This, in combination with [`routes/metrics.js`](https://github.com/expert26111/NodeServer/blob/master/routes/metrics.js) class, allows for Prometheus to collect metrics and monitor the system.

As for Grafana, it extends the analytics and monitoring from prometheus and makes it beautiful and user friendly. Not only that, it also extends functionality. Developer and operators can set alarms across multiple platforms, when the set threshold is crossed. For example, we have set a threshold for if the http response time is more than 6ms, then we receive a notifications on Slack with a custom set message explaining the situation. 

It provides multiple types of graphs and charts which are easier to read and understand unlike Prometheus, where user has to choose from a long list what they want to analyze and is very basic and unfriendly. 

[View Prometheus](http://207.154.245.251:9000/graph)

[View Grafana](http://207.154.245.251:4000/dashboard/db/nodeapi-monitoring?refresh=5s&orgId=1&from=now-1h&to=now)

Full and detail explanation of our documentation can be found on this link:
https://github.com/shrestaz/TechNews-LSD
 

## 2. Maintenance and SLA status


### 2.1. Hand-over 

We were the operating system of Group L. The [documentation](https://github.com/DanielHauge/HackerNews-Grp8/wiki) they provided was very thorough, but in a bad way. Sure they have documented every step of the process in detail but it was complicated and difficult to find what we needed. For example, the web API which is the core part of the project, was well hidden under links and difficult to follow through. Their documentation link is more made for them, but we as operational group could not orientate well  within it.

They provided platform for reporting their bugs which was quite helpful.

However, they frequently changed the credentials to their monitoring platform without mentioning in the documentation or making us aware if it in any way. This locked us out for a couple of days without the ability to monitor in any way.

*When* we were able to navigate through their documentation, it did help us understand the system and maintain it as they had designed.

### 2.2. Service-level agreement

[The complete SLA documentation can be found here.](https://github.com/DanielHauge/HackerNews-Grp8/wiki/Service-Level-Agreement)

To concisely list the agreement between the operators and the system administrators:

- 95% uptime of the Core APi
- 90% uptime of all systems
- Scheduled email support depending upon priority of the issue
- Fix of critical issues within 24 hours of reporting

These were decided on mutual agreement between the two groups, and was fulfilled as expected. No disagreements evolved. Also, the agreement was kept as promised by the development team.

### 2.3. Maintenance and reliability
During the stress test our system had significant load practiced on it. We had to restart it a few times mainly because of updating. There were two or three times where the system stopped because of the load. So we restarted again. During restart time of course the system was not accessible. Even though that we managed to have 12,657,183 posts until the end of the stress test. 


We were monitoring our system on a daily basis and whenever it was down we were alerted by Grafana. 

#### 2.3.1 Incidents Reported:

![Issue #1](https://lh3.googleusercontent.com/TF9Ndb5QQHCQw-XKBYu1U5TvY-pzCShXnWjkpA29OontAeuO_eC_zAgRxjSAArRg5pEYRouIJ0fKtQ=s0 "Issue #1")

#1. When our system was handed to the operating group, they opened an issue regarding our latest route. The requirement was for that route to return an integer while our returned an JSON. This resulted in our system not being plotted onto [the chart of the simulator](138.68.91.198/chart.svg). After fixing the issue, we started to show up on the chart, hence it starts from the middle and not beginning as others.

![Issue #2](https://lh3.googleusercontent.com/ClrvqHy-kxiWD3ClWGvldW6ZiHd9k5NxVzngtmaSOIU3x2hM902Mk27LgXP9xcBzWoaeyNYCRw5-Kg=s0 "Issue #2")

#2. In the middle of the project, we had to move our host system (droplet on DigitalOcean) due to low on storage space. After successfully doing so, we forgot to update the Prometheus configuration with the new target Gateway address. This resulted in Grafana dashboard not showing any data, since the previous host system was shut down.

## 3. Discussion

### 3.1. Technical discussion
The technologies used for creating this system and continuous integration chain were adequate and efficient. Instead of Jenkins, we could use Travis or Codeship or any other hosted CI. Instead of Node we could create a Java app. The end result would be the same. However, Node.js applications are easy to create and it is very easy to extend their functionality. The lack of multiple threads in Node.js could easily be overcome if we used docker-swarms. For database, because of our knowledge from previous semester we chose MySQL. Here, the relationships between data are not so deep but instead the quantity of data is big.

#### **The Good:**

- This project helped us realise how big of a role system maintenance plays in a system development cycle.
- We received strong foundation base for developing large system with continuous integration. 
- Many new technologies were introduced as the system grew and kept the team in constant connection with the project.
- Since the system was operated by others, it made us critique ourselves before implementation.

#### **The Bad:**

- Due to complications, the group work was not possible which made the two current teammates have all the workload. So we had to split the group.
- Our database, hosted on DigitalOcean droplet, had to be moved to a larger host due to unexpectedly large number of posts resulting on the host running out of space.
- Communication with our operating group was very low, besides a few issue reporting.

### 3.2. Group work reflection & Lessons learned

What we have learned is that we could use many different approaches to build our system.  From using different droplets or virtual machines for every service to using containers for achieving the same. What we could really do to improve our system significantly is to implement docker-swarms. Because it would not be needed to restart our system on update and crash on unexpectedly high requests. Otherwise everything else was quite well designed and done appropriately. We experienced what it is to set up a large system and it to go under stress load. We figured how to design our database in order to be optimal. We gained knowledge on how to do it better next time. We could listen to what problems other groups experienced and which approach they chose.

As for the three most important things we learned during the project: 

#### 1. System Maintenance. 
Before, all our systems were built and forgotten. After completing this project, we realized how important system maintenance is. Sure, it helps developers to know that their system is working fine but it also helps to ensure the agreement between the developers and operators are fulfilled. Also, as operators, we realized how users can critique on systems, which developers cannot see for themselves. This in turn helped us to look at our own system from a user's perspective.

#### 2.  Application Containerization
The two developers of the team were always working on different development environment, be it operating system or IDE. But due to the use of Docker to containerize all the components of the system, it ensured that our final system would work on all environment. No more “It works on my machine” bug.
 	
#### 3. Documentation
As boring as it is, we realized how important a good documentation is. As operators, we were provided with a documentation which was thorough and detailed on many unnecessary things. As developers, we might not have provided with enough details to our operating group. There is no defined sweet spot for what a good documentation should look like, but when it is, users really appreciate it. It can not only help users to understand the system, but also helps them to fix issues by themselves, which is critical in software development.
