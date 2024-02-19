const jwt = require("jsonwebtoken")

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token")
        if (!token) {
            return res.status(401).json({ message: "No auth tokeni acces denied!" })
        }

        const verified = jwt.verify(token, "passwordKey")
        if (!verified) {
            res.status(401).json({ message: "Token verfication failed, authorization denied!" })
        }

        req.user = verified.id
        req.token = token
        next()
    } catch (error) {
        res.status(500).json({ error: "auth eroor mw" + error.message })
    }
}

module.exports = auth