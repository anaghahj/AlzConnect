const mongoose=require('mongoose')
//mongoose.connect("mongodb://localhost:27017/Credentials")
//var x="mongodb+srv://khushim0521:PsWEDy2wfgb3IVuU@cluster0.l0vjh51.mongodb.net/Spryzen?retryWrites=true&w=majority"
mongoose.connect("mongodb+srv://khushim0521:PsWEDy2wfgb3IVuU@cluster0.l0vjh51.mongodb.net/Spryzen?retryWrites=true&w=majority")
.then(()=>console.log("Successfully connected"))
.catch(()=>console.log("Some error in connection"))
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
                    // E-mail_Id:{
                    //                      type:String,
                    //                      required:true
                    // }
})
const users=new mongoose.model("users",Spryzen)
module.exports=users