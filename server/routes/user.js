const express = require('express');
const auth = require('../middleware/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const userRouter = express.Router();
userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const { id } = req.body;
        //  here i did't awaited the Product.findById
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                }
            }
            if (isProductFound) {
                let producttt = user.cart.find((productt) => productt.product._id.equals(product._id));
                producttt.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }
        // Instead of res.json(user), I did user.json(user)
        
        user = await user.save();
        res.json(user);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});
userRouter.delete('/api/remove-from-cart/:id', auth, async (req, res) => {
    try {
        const { id } = req.params;
        //  here i did't awaited the Product.findById
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if(user.cart[i].quantity ==1){
                    user.cart.splice(i, 1);
                }else{
                    user.cart[i].quantity -= 1;
                }
            }
        }
        
       
        // Instead of res.json(user), I did user.json(user)
        
        user = await user.save();
        res.json(user);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});
module.exports = userRouter;