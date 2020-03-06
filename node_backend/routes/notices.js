 const express = require('express');
 const router = express.Router();
 const Notice = require('../models/Notice');
 

//  router.get('/',(req,res)=>{
//      res.send('We are on notices');
//  });

 router.post('/',(req,res)=>{
     console.log(req.body);
 });


 module.exports = router;
