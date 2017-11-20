Assignment 10 - Group G
-------------

### **Scaling:**

In the following screenshot, we created services in docker swarm. Its very self explanatory.

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