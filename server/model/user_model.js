const mongoose = require("mongoose")

const userScheme = mongoose.Schema({
    name: {
        require: true,
        type: String,
        trim: true,
    },
    email: {
        require: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                //regx -> email validator
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please Enter a valid email adress",
        },
    },
    password: {
        require: true,
        type: String,
    },
})

const User = mongoose.model("User", userScheme)
module.exports = User