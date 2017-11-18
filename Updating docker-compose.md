As a part of integrating ELK on to our hackernews clone system, it required us to upgrade our docker engine. Before this, we had been working with version 2 inside docker-compose file (docker engine 1.8.0), which wasn't enough for ELK, as it required at least version 3.2.

The following is the steps to upgrade docker engine (which is version 1.17.1, as of 18.11.2017).

1. `chmod -R 755 /usr/local/bin/docker-compose`
2. `sudo rm /usr/local/bin/docker-compose`
3. `sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose`
4. `sudo chmod +x /usr/local/bin/docker-compose`

**Explanation:**

Step 1: Change mode (chmod) to remove (-R) all read, write and execute permissions (755) of the file `docker-compose`.

Step 2:  Remove the file `docker-compose`.

Step 3: Download the updated `docker-compose` file.

Step 4: Change mode (chmod) of the new file executable (+x)

Step 5: Check version of `docker-compose` with command `docker-compose -v`

Voilà