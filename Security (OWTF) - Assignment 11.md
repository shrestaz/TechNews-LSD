Security
--------

A definition of your assets and the threat model of your project
A risk matrix of your project


----------

## Offensive Web Testing Framework (OWTF):

### Vulnerabilities found:
[**Click me for the complete output of OWTF.**](https://drive.google.com/file/d/1qytd1t8xqFAMeaxGFue2bNDPJxReRZTF/view?usp=sharing)

OWTF took around an hour to complete the test on the target (Group L: 165.227.151.217:8080), and the output file is very extensive and ~50MB in size. Therefore, we skimmed through it and are highlighting only a few. These are the direct output from the test.

> 1.  [93m[*] + OSVDB-6695: /cgis/rwcgi60/showenv: Oracle report server **reveals system information without authorization.**
> 


----------


> 2. [93m[*] + OSVDB-3092: /sample/siregw46: **This database can be read without authentication**, which may reveal sensitive information.


----------


> 3. [93m[*] + OSVDB-2948: /reademail.pl: @Mail WebMail 3.52 contains an **SQL injection** that allows attacker to read any email message for any address registered in the system.


----------
> 4. [93m[*] + OSVDB-3233: /admin/admin_phpinfo.php4: Mon Album from http://www.3dsrc.com version 0.6.2d **allows remote admin access**. This should be protected.
> 


----------
> 5. [93m[*] + OSVDB-13978: /cgi-local/ibill.pm: iBill.pm is installed. This may allow **brute forcing of passwords**.


----------


As one can see, this is only a handful of vulnerabilities found. If the system was used in production level for a real business, it would be catastrophic unless action is taken.


----------


----------


### OWTF setup and process

We put the system of Group L though OWTF to check for vulnerabilities.
The following are the steps we followed to do exactly that.

1. We decided to run the framework in its native environment, where it was built. So we ran a live version of Kali Linux and followed the procedure from the website to install OWTF.
2. The next step was to write the output of the script from the terminal window to a text file for later use. We created a simple python script, which when executed, starts OWTF on the defined target (Group L’s IP address and port number in this case) and writes every output on “output.txt” file. The following is a snippet of that.
```
#!/usr/bin/env python
    import subprocess
    with open("output.txt", "w+") as output:
        subprocess.call(["./owtf/owtf.py", "165.227.151.217:8080"], stdout=output);
```

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



### Authentication

This guide is written in order to provide information how jsonwebtoken authetification was set to our NodeServer.

Good links I followed:

https://scotch.io/tutorials/the-anatomy-of-a-json-web-token
https://scotch.io/tutorials/the-ins-and-outs-of-token-based-authentication
https://scotch.io/tutorials/authenticate-a-node-js-api-with-json-web-tokens
https://github.com/dwyl/learn-json-web-tokens


Question about authentication:
How to secure my own API?
Answer:
JSON Web Tokens (JWT) “jot”, the information transmitted is via JSON. JWT carry all the information necessary within itself: payload, header, a signature. They are used inside the HTTP header.
Payload: This is the information we want to transmit(JWT claims) and other information about our token. 
Signature: made of header, payload, secret and hashes them. The secret is the signature held by the server. This is the way that our server will be able to verify existing tokens. You can use the token in a URL,Post or an HTTP header.
For example right now we can check if user exists and provide him/her with a token  :

![](https://github.com/shrestaz/TechNews-LSD/blob/master/requesttoken.png)

During development I enabled Node Core library
Go to File -> Settings -> Languages & Frameworks -> Node.js and NPM
Because it was giving me that module is unresolved variable.

During development I installed npm install @types/express
Because it was giving me that post,get,put,delete method are unresolved.
Authentification was added to our post route for posting hackernews stories, the ip from which Helge is posting has been permitted everybody else who tries will be checked if he/she has token for authentification.

      if(req.ip.toString().includes('138.68.91.198') )

This line checks exactly if the one who tries to post is Helge. If not 


      if(req.ip.toString().includes('138.68.91.198') )
    {
      // console.log('The ip is  ',req.ip.toString());
       net.info('Posting a post from Helge WITH IP ',req.ip.toString());
       res.status(201).json(req.body);

    }else{

       //net.info('I am inside else blog');
       ///console.log('The ip is  ',req.ip.toString());
       var token = req.body.token || req.query.token || req.headers['x-access-token'];
       if (token)
       {

       // verifies secret and checks exp
       jwt.verify(token, config.secret , function(err, decoded)
       {
           if (err)
           {
               return res.json({ success: false, message: 'Failed to authenticate token.' });
           } else
           {
               // if everything is good, save to request for use in other routes
               req.decoded = decoded;
               net.info('Posting a post from authenticated user');
               res.status(201).json(req.body);
               //next();
           }
       });

       } else
       {

       // if there is no token
       // return an error
       net.info('Trying to post a post from non authenticated user');
       return res.status(403).send({
           success: false,
           message: 'No token provided.'
       });

       }
    }




The code requires authentification token to be sent from the front-end client if such has not been sent gives the message:

![](https://github.com/shrestaz/TechNews-LSD/blob/master/secureroute.png)




















