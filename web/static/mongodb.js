const mongoose=require('mongoose')
//mongoose.connect("mongodb://localhost:27017/Credentials")
mongoose.connect("mongo url")
.then(()=>console.log("Successfully connected"))
.catch(()=>console.log("Some error in connection"))
// For just storing the username and the password
const Spryzen=new mongoose.Schema({
                    name:{
                                        type:String,
                                        required:true,
                                        unique:true
                    },
                    password:{
                                        type:String,
                                        required:true
                    },
                    email:{
                                        type:String
                    },
                    phno:{
                                        type:String
                    },
                    age:{
                                        type:String
                    },
                    bloodgrp:{
                                        type:String
                    },
                    gender:{
                                        type:String
                    },
                    desc:{
                                        type:String
                    }
                    
})
const webdatas=new mongoose.model("webdatas",Spryzen)



module.exports=webdatas