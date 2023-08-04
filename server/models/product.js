const mongoose = require('mongoose');
const ratingSchema = require('./rating');
const productSchema = new mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true,
    },
    description:{
        type:String,
        required:true,
        trim:true,
    },
    price:{
        type:Number,
        required:true,
        trim:true,
    },
    category:{
        type:String,
        required:true,
        trim:true,
    },
    ratings:[ratingSchema],
    quantity:{
        type:Number,
        required:true,
        trim:true,
    },
    images:[
        {
            type:String,
            required:true,
        }
    ],
    
});
const Product = mongoose.model('Product', productSchema);
module.exports = Product;