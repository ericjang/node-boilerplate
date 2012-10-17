Node Boilerplate Version 2
==========================
*Requires Node v0.6.6 (or newer)*
node-boilerplate takes html-boilerplate, express, connect, jade and Socket.IO and organizes them into a ready to use website project. 

Forked from Robrighter's repo, with my own custom modifications to include:

- Twitter Bootstrap
- DevNotes.txt (also added to the gitignore)
- ... and possibly more features to come (everyauth)

To start a project:
		
		git clone git://github.com/ericjang/node-boilerplate.git mynewproject
		cd mynewproject
		./initproject.sh
This will copy down all of the boilerplate files, organize them appropriately and init a fresh new git repository within which you can build your next big thing.


To run the boilerplate template app:

		node server.js

Go to http://0.0.0.0:8081 and click on the send message link to see socket.io in action.


Additional Features:

1. Creates a package.json file consistent with associated best practices (http://blog.nodejitsu.com/package-dependencies-done-right)
2. Adds .gitignore for the node_modules directory
3. Includes 404 page and associated route
4. Includes 500 page

To add additional modules:

Update the package.json file to include new module dependencies and run 'npm install'.

**If you have a different set of default modules that you like to use, the structure is setup such that you can fork the project and replace the module dependencies outlined in the ./templates/apps/package.json file to best fit your needs and the initproject.sh script will initialize projects with your new set of modules.**

Deployment
===============

node-boilerplate is setup to be easily deployed on a Joyent Node SmartMachine or an AppFog PAS. This means that:

1. The version of Node is defined in config.json and in package.json
2. The main script to run is server.js
3. The web server port is pulled from process.env.PORT 