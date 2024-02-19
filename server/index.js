const express = require("express")
const mongoose = require("mongoose")
const router = require("./routers/auth")
const dotenv = require("dotenv")

const app = express()

app.use(express.json())
app.use(router)
dotenv.config()

// personel mongodb data -> userName and password 
//const mongoDB = "mongodb+srv://$userName:$password@cluster0.qemn8qe.mongodb.net/?retryWrites=true&w=majority"
const PORT = process.env.PORT || 3000

mongoose
    .connect(process.env.MONGO_DB_CONNECTION)
    .then(() => {
        console.log("MongoDB Connection Successful");
    })
    .catch((e) => {
        console.log("Db Eroor: ", e);
    })

app.listen(PORT, "0.0.0.0", () => {
    console.log("Connect at port", PORT);
})