const express = require('express');
const auth = require('../middleware/auth');
const Product = require('../models/product');
const productRouter = express.Router();

productRouter.get('/api/products',auth, async (req, res) => {
    try{
        const products=await Product.find({
            category:req.query.category
        })
        res.json(products);
    }catch(err){
        res.status(500).json({ message: err.message });
    }
});

module.exports = productRouter;