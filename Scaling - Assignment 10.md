Assignment 10 - Group G
-------------

### **Scaling:**
#### **Part 1: Questions answered**

Docker Swarm is a clustering and scheduling tool for Docker containers. With Swarm, IT administrators and developers can establish and manage a cluster of Docker nodes as a single virtual system.  Docker swarm declares one Node/VM/Droplet as manager and the others are workers. Usually workers can not manage containers that is why the commands:

    docker node ls 
    docker service ls 

can not  be runned by a worker node but only from manager.

The good thing about docker swarm is that when we want to scale up or down the manager automatically adapts by adding or removing tasks/containers. For example, if you set up a service to run 10 replicas of a container, and a worker machine hosting two of those replicas crashes, the manager will create two new replicas to replace the replicas that crashed. The swarm manager assigns the new replicas to workers that are running and available.  Docker swarm is really good for our load balancing. Load balancing is when we need to distribute the traffic across all the instances of this service. Docker Swarm allows us to seamlessly scale and distribute docker work load to a cluster of hosts. 

One of the key advantages of swarm services over standalone containers is that you can modify a service’s configuration, including the networks and volumes it is connected to, without the need to manually restart the service. Docker will update the configuration, stop the service tasks with the out of date configuration, and create new ones matching the desired configuration. That is why for example when we decide to add extra volume/disk space to one of our droplets does not matter worker or manager our service will not be stopped even for a moment as when we use ordinary containers. That is how we save our problem with congestion.  


----------


#### **Part 2: Screenshots**

In the following screenshots, we deployed services in a docker swarm. Its very self explanatory.

ELK, Prometheus and Grafana are replicated once only since they are only logging and monitoring the system. When the system is under load, they will not be affected, hence scaling is not required for them. 

The 4th service is the webservice which is our Nodejs API of the system. Since this handles all the requests, this has can be scaled to improve stablility and performance. It has 5 replicas to be split among the manager and its 2 workers.

    docker service ls

![enter image description here](https://lh3.googleusercontent.com/A6bjoZygyA_RJS9E28-M3zZUmz1mOJ6F7uA1swkG41Ju53Cu6d5uc0BSdpLlHZhvQNxmISdh2kD2Qw=s0 "docker service ls.png")


----------


The following lists the nodes we created, which is 1 manager and its 2 workers.

    docker node ls

![enter image description here](https://lh3.googleusercontent.com/Qp45TuwTv5zgY9GmsQT7XC63lrYOHCLpqLrZr-aO4BQosIyMKD9H69wDN53rebMaplrtdn0RLPboAw=s0 "docker node ls.png")


----------


When listing the docker networks, we can see that the third network named "groupG_default" was created as an overlay network for docker swarm.

    docker network ls

![enter image description here](https://lh3.googleusercontent.com/Jgin0BBhxEpvvz2ja1rG9k8WY6BNg2olJEwRUiwbxqP9KigmqDIXsqxSOPlkkuxF2NHTy5ipRsg0gQ=s0 "docker overlay network.png")


----------


Finally, when we check the process of the docker swarm, our only scaled service, "groupG_webserver" has 5 replicas, as intended, and has been split among the manager and its 2 workers.

    docker stack ps groupG

![enter image description here](https://lh3.googleusercontent.com/9_H6pVeKQeZLvaBKsR3JaAFoEFXpYoR7TS_HhGqM2VxAgzQipk_fk-6eV3gmY3PTJHpYmJNmnLzi1Q=s0 "docker stack ps.png")


----------


> Command used to deploy services on a swarm cluster:
> 
> `docker stack deploy -c docker-compose.yml groupG`