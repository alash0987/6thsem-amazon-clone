const express = require('express');
const User = require('../models/user');
const authRouter = express.Router();
const bcrypt = require('bcryptjs');
const jwt=require('jsonwebtoken');
const auth = require('../middleware/auth');



//  Sign Up Route

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email: email });

    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
    });
    user = await user.save();

    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});
// sign in route
authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email,password}=req.body;
        const user=await User.findOne({email:email});
        if(!user){
            return res.status(400).json({message:"User does not exist"});
        }
        const isMatch=await bcrypt.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({message:"Incorrect password"});
        }
     const token=   jwt.sign({
            id:user._id,
        },"passwordkey");
        res.json({
            token,...user._doc
        });
        

    }catch (err) {
        res.status(500).json({ message: err.message });
    }
});
//  token is valid
authRouter.post('/tokenIsValid',async(req,res)=>{
  try{
    const token=req.header("x-auth-token");
    if(!token) return res.json(false);
    
  const verified=  jwt.verify(token,"passwordkey");
  if(!verified)  return res.json(false);
  
  const user= await User.findById(verified.id);
  if(!user) return res.json(false);
   res.json(true);
  }catch(err){
    res.status(500).json({ message: err.message });
  }
});
//  get user data
authRouter.get('/',auth,async (req,res)=>{
  const user= await User.findById(req.user);
  res.json({
    ...user._doc,
    token:req.token
  });
});
module.exports = authRouter;