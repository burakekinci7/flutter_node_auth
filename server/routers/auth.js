const express = require("express")
const bcryptjs = require("bcryptjs")
const jwt = require("jsonwebtoken")
const User = require("../model/user_model")
const auth = require("../middleware/authentication.js")
const router = express.Router()

// User Sign UP
router.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body

        const exsitingUser = await User.findOne({ email })
        if (exsitingUser) {
            return res
                .status(400)
                .json({ message: "User with same email already exists!" })
        }

        const hashedPassword = await bcryptjs.hash(password, 8)

        let user = new User({
            email: email,
            password: hashedPassword,
            name: name,
        })
        user = await user.save()
        res.json(user)
    } catch (error) {
        // 500 server error
        res.status(500).json({ error: "Server Error:" + error.message })
        console.log("Login Error:", error);
    }
})

// User Sign In
router.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body

        const user = await User.findOne({ email })
        if (!user) {
            return res
                .status(400)
                .json({ message: "User with this email does not exist" })
        }

        const isMatch = await bcryptjs.compare(password, user.password)
        if (!isMatch) {
            return res
                .status(400)
                .json({ message: "Incorrect Pessword" })
        }

        const token = jwt.sign({ id: user._id }, "passwordKey")
        res.json({ token, ...user._doc })
    } catch (error) {
        res.status(500).json({ error: "Sign In Eroor:" + e.message })
    }
})

// Token Verify
router.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);

        res.json(true);
    } catch (error) {
        res.status(500).json({ error: "Token Not Verify" + error.message });
    }
});

// Get User Data
router.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user)
    res.json({ ...user._doc, token: req.token })
})

module.exports = router
