<h3>Logical Data Model</h3>


![enter image description here](https://lh3.googleusercontent.com/dSab5TdOk7EGdpyLRvjyeeQw1X84oyNLr1kwZEqkZokImkodm4gAnUhVXiwPoM6NpTuIX0b2YuXpWg=s0 "Logical Data Model.png")

<h3>Use Case Model</h3>
<h4>1. Use Case Diagram</h4>

![enter image description here](https://lh3.googleusercontent.com/M4NVl0gdzoM78eAe94zzrysYX_my4YKz7PrWuuT6FDeDyU9i3o6ZAuEEhf557rly8PH7DVSIurYmgw=s0 "Hacker News Clone &#40;3&#41;.png")

<h4>2. Actors:</h4>

I. *Guest User* (Primary Actor): An unregistered user using the system.

Responsibilities: Can view posts/comments, register as a user and login.


II. *Registered User* (Primary Actor): A user registered in the system with his/her unique credentials.

Responsibilities: Can create posts/comments, view posts/comments, upvote or downvote the posts/comments made by others, report posts/comments and update his account details.


III. *Administrator* (Primary Actor): This actor administers the system.

Responsibilities: Can take reported posts into context and remove post and/or user when necessary.


<h4>3. Fully Dressed Use Cases:</h4>

**Use case**: View post

**Actor**: Guest User/Registered User

**Precondition**: n/a


**Main scenario**:
1. System displays its homepage with existing posts submitted by other users.
2. User navigates to the interested post title.
3. System redirects to the URL linked to the post.

---

**Use case**: Register

**Actor**: Guest User

**Precondition**:

- User should not already have an account in the system.

**Main scenario**:
1. User navigates to the “Create Account” button of the system.
2. System provides a new page asking for account creation information.
3. User submits the required information to the system.
4. System registers the information and creates a profile for the user.
5. User now uses the system as a “Registered user”.

**Exceptions**:

- The requested username is already registered in the system.
- System displays an error message.
- User repeats steps from “Main Scenario - step 3”.
- User provided password is short.
- System displays an error message.
- User repeats steps from “Main Scenario - step 3”.


----------


**Use case**: Login

**Actor**: Guest User

**Precondition**:

- User must have already registered in the system.

**Main scenario**:
1. User navigates to “Login” button of the system.
2. System provides a new page for the user.
3. User inputs his credentials.
4. System authorizes the credentials and redirects to the homepage as a registered user.

**Exception**:

- User inputs incorrect credentials.
- System displays an error message.
- User repeats steps from “Main Scenario - step 3”.


----------


**Use case**: Create post

**Actor**: Registered User

**Precondition**: 

- User must be logged in to the system.
- Post must not pre-exist in the system.

**Main Scenario**:
1. User navigates to “Create Post” in the system.
2. System provides a new page/form for user submission.
3. User fills the submission form with post title, url and/or post text.
4. System puts it on the database and shows it on the homepage.


----------


**Use case**: Vote

**Actor**: Registered User

**Precondition**:

- User must be logged in to the system.

**Main Scenario**:
1. User votes up or down on post, depending upon his opinion.
2. System increases or decreases the karma points of that post.


----------


**Use case**: Update user

**Actor**: Registered User

**Precondition**:

- User must be logged in to the system.

**Main scenario**:
1. User navigates to “My Profile” button of the system.
2. System provides a new page with that user’s profile.
3. User makes changes to his details and saves.
4. System updates database based on those changes.
5. System displays “My Profile” page with updated details.


----------


**Use Case**: Comment on post

**Actor**: Registered User

**Precondition**:

- User must be logged in to the system.

**Main scenario**:
1. User navigates to “Comments” of a specific post.
2. System displays the comments of the post made by other users (if any).
3. User navigates to the reply message box.
4. User types out his comment and saves it as reply.
5. System refreshes and displays the user’s comment.


----------


**Use Case**: Administer System

**Actor**: Administrator

**Precondition**: n/a


----------
<h4>**4. Sub-system Sequence Diagram**</h4>

//NEEDS TO BE DONE :P


<h3>**Participation of group members**:</h3>

For this assignment:

**Dividing into sub-system**: Mikkel Djurhuus & Theis Kjeld Rye (50%)

**Documentation**: Yoana Dandarova & Manish Shrestha (50%)