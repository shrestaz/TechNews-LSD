**Hacker News Clone - Group G**
---------------------------

### **1. Brief Overview:**
This is a clone application of the website HackerNews. There are 4 parts to this project which are all hosted on a droplet in DigitalOcean. Including these parts working together to make this application work, there is also Jenkins working on the same droplet as a Continuous Integration server.

![enter image description here](https://lh3.googleusercontent.com/C7Uu6IUDX3YYjc7OuDNnB0WwaPfDrtU_v9gGZ_mhscdEtg6MDHXzP7mV3vsG6CmfaPoF2QK746N2xA=s0 "Document 1 &#40;1&#41;.png")


As you can see from the figure above, our host IP is 188.226.163.242, which is the DigitalOcean droplet with four docker containers running plus the Jenkins server.  

**MySQL db** - container for holding our data (on port number 3306)

**Node API** - NodeJS server that retrieves or inserts data into the db container (on port number 3000)

**phpMyAdmin** - container that is linked to the mysql container so what data is inside of it can be easily seen (on port number 8080)

**Front-end** - Unfortunately, this is still a work in progress and will be updated as soon as it is in working status. You will be notified when it’s up and running (it will be on port 80)

**Jenkins** - always running on the host which rebuilds the Node project when update is pushed on GitHub. (on port 9090)

### **2. Access:**
**Droplet**: (188.226.163.242)
To be able to gain access to the droplet via ssh, your machine’s public key needs to be added to the authorized list. Please contact one of the team members, with the public key ready, to be given access.

**API**:
The API is working on port 3000. Jenkins handles the build of this application, which you can have a peek at it yourself.

**Jenkins**:
The Jenkins server is always running on port 9090. The credentials to access Jenkins is:

> Username: root 

> Password: root

**Database**:
To access the database through phpMyAdmin, use the port 8080. The database itself is working on port 3306. The credentials to access phpMyAdmin is:

> Username: root

> Password: root

Note: Be careful how you use phpMyAdmin and do not grant any privileges or alter tables structures.

### **3. Docker Images**:
If you check the `docker-compose.yml` file, there are 3 services defined. *[This will be updated with the 4th service which will be the front-end.]* 

The image for phpmyadmin is the official image as is. `[dockerhub image name: phpmyadmin/phpmyadmin]`

The image for mysql is also the official image but we wrapped it with a dbseed.sql file which initializes the structure of the db. And this wrapped image is hosted on our personal dockerhub. `[dockerhub image name: thatonedroid/hackernewsdb]`

The third image is the API of the project which is a node application, also hosted on our personal dockerhub. `[dockerhub image name: thatonedroid/hackernewsapi]`


[(Quick access to above images.) The images of database and API are hosted here.](https://hub.docker.com/u/thatonedroid/)

### **4. Data, Files and Projects**:
Since the docker containers depends on volumes to save its data, the data for the database is saved on the path /root/mysql/manish on the droplet. You will not have to (or you can’t) do anything regarding this, but it is just an information on where the volume is located. (Also, the naming could be done better, we realize that.)

The database also needs to be structured when the container is created from the official image. This is initiated by the file dbseed.sql located at /root/mysql/ on the droplet.

 [The GitHub repository for the API is here.](https://github.com/expert26111/NodeServer/)

And the GitHub repository for the front-end will be added soon.

### **5. Starting/Stopping of the application**:
The `docker-compose.yml` file is responsible for the initialization of the application. If you look closer into it, it defines the images (read: Docker Images above) to be dockerized, sets the environment and volume, links the services among each other and link the ports between the host and the containers.

To start the application, which includes all the steps above, ssh onto the droplet and type the command: 
`docker-compose up -d`

  The `“-d”` flag allows it to run in the background.

![enter image description here](https://lh3.googleusercontent.com/dBeUwLRphkSmpr5cO7QQJzMJjuWn2P-wSKKWFHrQbWldr6JH4MAdvG_jSoQK_-QrJwLA_0mDAI2URw=s0 "docker-compose up.png")

To check if it worked, you can check the processes with `docker ps`

It also shows the linked ports in case you forget.

![enter image description here](https://lh3.googleusercontent.com/IP_CyBwva1MNqnlPYA_30rzGv8ZrcCeN-qp8XWZgipnAv8bwZ89OMyJaFXri0yy7t3wE2Dawu5f5hQ=s0 "docker ps.png")



And to stop the application, simply run `docker-compose down`

![enter image description here](https://lh3.googleusercontent.com/JguyS7LArrVuUt1yDlMH8Lo5_BIvxDNXj8CLzb_tcz1G2LxBSSoDvEmLT105MjtOdY8Rg36so-dalg=s0 "docker-compose down.png")

### **6. Node API description**:

Due to the front-end being under-development, the ways to interact with the API is with the help of Postman or something similar. GET requests can be handled by the browser itself.

GET ROUTE http://188.226.163.242:3000/status/          To check if our system is alive.

GET ROUTE http://188.226.163.242:3000/latest/         To check latest entry post.

POST ROUTES http://188.226.163.242:3000/post/array   To post array of stories/posts like this:

     [{"post_title": "YoanaSuper", "post_text": "", "hanesst_id": 358, "post_type": "story", "post_parent": -1, "username": "pg", "pwd_hash": "Y89KIJ3frM", "post_url": "http://ycombinator.com"}]

For using this route, please make sure you send JSON to our API. It probably is needed to specify in your header like so:

> Accept   application/json 

> Content-type application/json

To be sure, before using any post route, please verify you have valid json. You can use this website to do validate your json. 
https://jsonformatter.curiousconcept.com

http://188.226.163.242:3000/post/       To post an object of story/post like this:
> 
> 
    {"post_title": "YoanaSuperisOk", "post_text": "", "post_type": "story", "post_parent": -1, "username": "pg", "pwd_hash": "Y89KIJ3frM", "post_url": "http://ycombinator.com", "hannest_id":655}



Please make sure, for the previous posts you use unique hannest_id. As our hannest_id is PK,NN,UQ in our mysql db.

http://188.226.163.242:3000/post/noid     To post story/post without hannest_id like this:
> 
  `{"post_title": "YoanaisOk", "post_text": "", "post_type": "story", "post_parent": -1, "username": "pg", "pwd_hash": "Y89KIJ3frM", "post_url": "http://ycombinator.com"}`

GET ROUTES
http://188.226.163.242:3000/post/ - To get all available stories/posts.

http://188.226.163.242:3000/post/112 - (112 being the id of story) To get a story/post by id .

DELETE ROUTE
http://188.226.163.242:3000/post/112 - (112 being the id of story) To delete a story/post by id

PUT ROUTE
http://188.226.163.242:3000/post/116 - (116 being the id of story) Send JSON like object to update a story:

    

    {"post_title": "HelloMuci", "post_text": "", "post_type": "story","post_parent": -1, "username": "pg", "pwd_hash": "Y89KIJ3frM", "post_url": "http://ycombinator.com"}

We have successfully inserted around 340000 users in our db. Routes to manipulate with these users:

GET ROUTE
http://188.226.163.242:3000/user/	To get all available users.

POST ROUTE
http://188.226.163.242:3000/user/      To post a user sending json like this:

 

     {
        "name": "Man",
        "pwd": "jhdc"
     }

DELETE ROUTE
http://l188.226.163.242:3000/user/Yoana     Yoana being the user you want to delete.

### **7. Feedback and Troubleshooting**:
In case of feedback and/or troubleshooting, please contact one of the team members. If it is regarding troubleshooting, please take note of the exception thrown.

### **8. Team Members**:
Yoana Georgieva Dandarova

Manish Shrestha

Mikkel Djurhuus

Theis Kjeld Rye

Rumyana Rumenova Vaseva
