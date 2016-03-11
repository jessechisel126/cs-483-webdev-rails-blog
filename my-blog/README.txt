Installation Instructions
-------------------------

NOTE: This project can only be run in Linux.

NOTE: These instructions may be a bit overkill as far as how much is downloaded and installed,
      but it's obviously better to aire on the side of safety and install everything.
      I take no responsibility for the project not running if all instructions aren't followed.

First, you will need to get necessary prerequisite programs.

$ sudo apt-get install curl
$ sudo apt-get install nodejs

Next, you'll need to install/update rvm, which includes ruby and all things needed for rails 
NOTE: Will take some time to download and install, especially the documentation step.

$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable --rails

For the next steps, you'll need to be in the "my-blog" directory.

$ cd path/to/my-blog

Next, you'll need to install necessary gems for the project.

$ bin/bundle install

Next, you'll need to set up the database.

$ bin/rake db:migrate db:seed 

Finally, you'll need to start up rails server.

$ bin/rails s

From this point, navigating to http://localhost:3000 on your machine will show the website.
The site starts with one user with username="admin" and password="password" (can be changed
on login, for security). New contributors can sign up in the top bar. To add a new admin account, 
you must be logged in as an admin, and then navigate to Account->Add Admin in the top bar. 
Everything else should be self-explanatory enough. Have fun with the site!
