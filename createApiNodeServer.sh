#!/bin/sh
# This script creates a Node server in a selected folder with a simple get y post request
# RUN --> sh createApiNodeServer.sh [name]


CURRENT_DIRECTORY=""

if ["$1" == ""]
then
    CURRENT_DIRECTORY="./nodeServer"
else
    CURRENT_DIRECTORY="./$1"
fi

# Create Directory
mkdir -p $CURRENT_DIRECTORY ;
mkdir -p "$CURRENT_DIRECTORY/server" ;

# Initiate npm
npm init -y ;

# Install packages
npm install cors express body-parser ;

# Move files to selected Directory
mv node_modules $CURRENT_DIRECTORY 
mv *.json $CURRENT_DIRECTORY 

# Write Javascript main file
touch app.js
echo '
const express = require("express")
const app = express();
const puerto = parseInt(process.env.PORT, 10) || 3000;
const bodyParser = require("body-parser")
const Cors = require("cors")

// Modules

// Middlewares
app.use(Cors());
app.use(bodyParser.urlencoded({extended: false}))

// Open port
app.listen(puerto, () => console.log("Listening port " + puerto))


// ++++++++++++++++ HTTP METHODS +++++++++++++++++++ //

app.get("/", (req, res) => {
	res.send("We are up and going!!")
})

app.post("/", (req, res) => {
    let body = req.body

	res.send("Post request working fine.")
})
' >> app.js


mv app.js "$CURRENT_DIRECTORY/server"

node "$CURRENT_DIRECTORY/server/app.js"
echo  "NODE SERVER SUCCESFULLY RUNNING IN PORT 3000"