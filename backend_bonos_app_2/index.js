'use strict';
const express = require('express');
const cors = require('cors');
const bodyParser=require('body-parser');
const config = require('./config');

const app = express();

//esto
const personaRoutes= require('./routes/persona-routes')
const bonoRoutes= require('./routes/bono-routes')


app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

//y esto
app.use('/api', personaRoutes.routes)
app.use('/api', bonoRoutes.routes)


app.listen(config.port, ()=>console.log('App is listening on url http://localhost:'+config.port));
