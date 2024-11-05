import { getUsersByEmail, createUser } from "../db/users.js";
import { authentication, random } from "../helpers/index.js";
export const register = async (req, res) => {
    try {
        const { email, password, username } = req.body;
        if (!email || !password || !username) {
            res.sendStatus(400);
            return;
        }
        const existingUser = await getUsersByEmail(email);
        if (existingUser) {
            res.sendStatus(400);
            return;
        }
        const salt = random();
        const user = await createUser({
            email, username, authentication: {
                salt, password: authentication(salt, password)
            }
        });
        res.status(200).json(user).end();
    }
    catch (error) {
        console.log(error);
        res.sendStatus(400);
    }
};
//# sourceMappingURL=authentication.js.map