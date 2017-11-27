## System Migration ##


Due to the regional restrictions of our DigitalOcean droplet based on Amsterdam, adding extra volume to increase the storage was not possible. And our original droplet was running out of space. To remedy this problem, we had to migrate our system to a new droplet which supported scaling of data on demand. The following documents the process to do that exact thing.

 1. Create a live snapshot of the existing system.
 
	 a. Power off the droplet, to ensure data consistency, from the terminal

    ssh root@188.226.163.242
    poweroff -h now

	 b. Navigate to the droplet on a brower. Go to Snapshots panel and click on Take live snapshot.
 
	 - *Note: This takes some time to complete, depending upon the size of the data. For us, it took 5-7 minutes with ~20GB of data.*

2. Once the snapshot is saved, we should make it available in other regions where “additional volumes” service was available. For us, Frankfurt suited best, but there are many others to choose from.

3. Create a new droplet from the snapshot. This can be done from the More menu of the snapshot. Here, you can choose the setup of the droplet, depending upon one’s need, add additional volumes for larger storage space and add other services as required. 
Note: Remember to add the existing SSH keys to be able to access from the terminal, if you want to use the same local machine for further development.

4. The final step is to deploy the system onto the new droplet. Because of the live snapshot, all the data and files are saved and unchanged. We start the system using docker-compose. All the data are available as it was saved from the older droplet.
