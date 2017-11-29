Security
--------

A definition of your assets and the threat model of your project
A risk matrix of your project


----------

### Offensive Web Testing Framework (OWTF):

We put the system of Group L though OWTF to check for vulnerabilities.
The following are the steps we followed to do exactly that.
1. We decided to run the framework in its native environment, where it was built. So we ran a live version of Kali Linux and followed the procedure from the website to install OWTF.
2. The next step was to write the output of the script from the terminal window to a text file for later use. We created a simple python script, which when executed, starts OWTF on the defined target (Group L’s IP address and port number in this case) and writes every output on “output.txt” file. The following is a snippet of that script.

    #!/usr/bin/env python
    import subprocess
	with open("output.txt", "w+") as output:
        subprocess.call(["./owtf/owtf.py", "165.227.151.217:8080"], stdout=output);

3. Run ./execute.sh (the name of the python script)

![enter image description here](https://lh3.googleusercontent.com/2HvHN4D9yeaUTXWgeLlhAFpXhrNzEuZlNi_UFJTDli8kbBXg3NrZQ8f3-vNJc70kGYcrryr3gcnNaA=s0 "1 Execute.png")

4. Navigate to http://127.0.0.1:8009 from a browser for OWTF’s web UI.

![enter image description here](https://lh3.googleusercontent.com/uo7wadP1xfWJeHZJq0l34TTf7oyc-OaPqeLHFu1S-RCrBy4w8EFFe0uD4RrO9T0zwtbVtiG5TLQqwg=s0 "2 UI.png")

5. Check the work list. These are the actual tests done by the plugins. Every tests (all 113 of them) runs against the system, which can be removed from the list if needed.

![enter image description here](https://lh3.googleusercontent.com/VeYUf1zUuM8vkbUQKLjLEO209XEKKXVGDUzVqWpKIMr5qqHFnhIFlMToa8hbYWNQCneOR6yJOspDNA=s0 "3 1 List O fplugins.png")
![enter image description here](https://lh3.googleusercontent.com/BnXkEHd8WUREzc-3XuGBeZCzyhnY8oXcMWecZ29O3b0fkqumlyMKvx_fWXm__tHiWqIEoosDgkrN6A=s0 "3 2 list.png")

6. Check the progress from the UI and on the terminal/output file.

![enter image description here](https://lh3.googleusercontent.com/JaK4N9hprii_WCGLZ9LoV9SptLohBgn9zZSEOmH7qar8hKKXeyEI5gf7lTmpTUvLsets4xsJoFkvmA=s0 "4 Output.png")

7. Go through the output file which logged all the attacks and check for found vulnerabilities.

> 