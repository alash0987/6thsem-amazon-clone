const express = require('express');
const adminRouter = express.Router();
const admin=require('../middleware/admin');
const Product=require('../models/product');
// Add product
adminRouter.post('/admin/add-product',admin, async (req, res) => {
    try{
        const {name,description,images,quantity,price,category}=req.body;
        let product=new Product({
           name,description,images,quantity,price,category
        });
        product= await product.save();
        res.json(product);

    }catch(err){
        res.status(500).json({ message: err.message });
    }


});
//  Get all products
    adminRouter.get('/admin/get-products',admin, async (req, res) => {
        try{
            const products=await Product.find({});
            res.json(products);

        }catch(err){
            res.status(500).json({ error: err.message });
        }
    });
module.exports = adminRouter;
