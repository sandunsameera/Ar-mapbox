const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
require('dotenv/config');

//Listner 
app.listen(3000);

//connect to db
mongoose.connect(process.env.DB_CONNECTION,{ useNewUrlParser: true },()=>console.log("Connected on port 3000")); 

//Import routes
const noticesRoute = require('./routes/notices');
app.use('/notices',noticesRoute);

//middlewares
app.use(bodyParser.json());