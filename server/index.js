console.log('hello world');
//  import from packages
const express = require("express");
const mongoose = require("mongoose");

const PORT=3000;
const app =express();
const DB="mongodb+srv://alashgyawali0987:Mongodb321@cluster0.asprdcx.mongodb.net/?retryWrites=true&w=majority"
//  import from files
const authRouter=require('./routes/auth');
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

//  middleware 
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
//  database connection
   mongoose.connect(DB).then(()=>console.log('Database connected')).catch((err)=>console.log(err));

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Server is running on s port ${PORT} `);
}) 