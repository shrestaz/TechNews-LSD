Logging and post-mortem analysis
--------------------------------

**TL;DR: Logging works locally only. ~~and Alerts throws some exception resulting in only partly helpful.~~**

Update (18/11): Alert is working as expected. Grafana docker image had bugs which has been fixed by the original developers.


### **Logging**
We successfully installed the image `subp/elk` on our Digital Ocean droplet, and the api has been updated to implement the `log4js` module. 

Locally seems everything to work for us:

>  log4js.logFaces-HTTP Appender error: timeout of 5000ms exceeded
> log4js.logFaces-HTTP Appender error: timeout of 5000ms exceeded
> [2017-11-15 08:50:07.184] [ERROR] default - ERROR [2017-11-15
> 08:50:07.185] [FATAL] default - FATAL log4js.logFaces-HTTP Appender
> error: timeout of 5000ms exceeded log4js.logFaces-HTTP Appender error:
> timeout of 5000ms exceeded [2017-11-15 08:50:09.185] [ERROR] default -
> ERROR [2017-11-15 08:50:09.185] [FATAL] default - FATAL


This is the `console.log` we see when our app runs locally. 

The snippet from above  is shown when the database server is stopped on purpose. Our `log4js` code in the node app also writes to a file. 

However, when we tried do the same on our droplet, even after successfully installing elk image and be sure that elasticsearch and kibana are working properly, we ran into problems. Our logstash has two configuration files but seems that no data has been sent from it to elasticsearch. However we will further investigate this problem.

### **Alerts**

During the initial phase of setting up alert, Grafana had bugs and couldn't alert when expected. Recent update has that fixed, resulting in our alerting system working

Currently, we have 2 alerts set up. One monitoring the if the system is up and working, and the other keeping track of the response time of the requests to the system. Obviously, the first one notifies the users if the system is down and the second is configured to notify when the response time is greater than 6 ms. Currently, our average response time is 5.1 ms.

All the alerts are directed to Slack. We also tried to implement email alerts which required configuring the SMTP, but it wasn't successful. After discussing with a couple of other groups in the class, it wasn't working for them as well. This concluded that the process of setting up email is either broken, or the official documentation being incomplete.

~~Setting up alerts was another complication on the project. Setting up email alert with SMTP configuration simply did not work. Apparently, no other group we talked to had successfully setup email alert as well. The next step was to setup alert using Slack which was working as expected. We setup the alert in Group H’s Grafana dashboard but so far, we have had no alerts since everything was working as they expected and the (parts) application has not been crashed on purpose by them.~~

~~However, setting up alert configuration on Grafana dashboard, while works (as in sends alert in slack), the actual alert gives an exception when testing the rule.~~

~~As stated earlier, we get alert in slack with the alert name so we can pinpoint where the attention is needed but can’t learn more from the alert itself (until it get fixed, which should be soon™).~~ 



### **Post-mortem report**
Albeit incomplete/broken implementation of logging, our operating group hasn’t set up their alerts in our monitoring platform. This incomplete setup resulted in no post-mortem report to be possibly created.


### ** Update 11/19/2017. **

Ports:
5601 : Kibana
9200 : ElasticSearch
9700 : LogStash
Indices can be listed on: http://159.89.2.54:9200/_cat/indices?v for Kibana



There has been another droplet created at http://159.89.2.54. The sebp/elk image and its logstash configuration files have been added as well. The docker-compose.yml file that has been used is the same as Jen’s from https://github.com/datsoftlyngby. Our logging is on different droplet in case http://188.226.163.242 crashes we have the logging system alive on different place and can check our log messages. If you click on http://159.89.2.54:5601 you will see our Kibana interface showing what happened to the system. 
The node.js server we use  has been modified. We added log4js configuration file and log information when different routes are being used. Despite making this working we had the ambition to write our logs to files but this did not work. 

Checking our last changes to NodeServer please go here:

https://github.com/expert26111/NodeServer


