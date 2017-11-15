Logging and post-mortem analysis
--------------------------------

**TL;DR: Logging works locally only and Alerts throws some exception resulting in only partly helpful.**

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

Setting up alerts was another complication on the project. Setting up email alert with SMTP configuration simply did not work. Apparently, no other group we talked to had successfully setup email alert as well. The next step was to setup alert using Slack which was working as expected. We setup the alert in Group H’s Grafana dashboard but so far, we have had no alerts since everything was working as they expected and the (parts) application has not been crashed on purpose by them.

However, setting up alert configuration on Grafana dashboard, while works (as in sends alert in slack), the actual alert gives an exception when testing the rule.

![enter image description here](https://lh3.googleusercontent.com/MZueRY4N8ApKCkdcB2pZ77FE8tricefh4K1bXXfLx3G0gl7gfaTBfBctoVtHrgiOhfhoFaN-qEcaAA=s0 "Grafana.png")

As stated earlier, we get alert in slack with the alert name so we can pinpoint where the attention is needed but can’t learn more from the alert itself (until it get fixed, which should be soon™).

![enter image description here](https://lh3.googleusercontent.com/ejRbPH1dC7BJ2-zJD-XfFJg1H_KB2tofhOtS0F5xvMLEK5zQrv4mz7JtAdrLGLSwk5pZLOrwzKojvw=s0 "Grafana-Slack.png")

### **Post-mortem report**
Albeit incomplete/broken implementation of logging and alerts, our operating group hasn’t set up their alerts in our monitoring platform. This incomplete setup resulted in no post-mortem report to be possibly created. (Until it is fixed during the weekend, that is.)
