import { getUsersByEmail, createUser } from "../db/users.js";
import express, { Request, Response } from "express"
import { authentication, random } from "../helpers/index.js";

export const register = async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password, username } = req.body;

        // Validate input
        if (!email || !password || !username) {
            res.status(400).json({ message: "Email, password, and username are required." });
            return; // Exit after sending the response
        }

        // Check for existing user
        const existingUser = await getUsersByEmail(email);
        if (existingUser) {
            res.status(400).json({ message: "User already exists with this email." });
            return; // Exit after sending the response
        }

        // Create new user
        const salt = random();
        const user = await createUser({
            email,
            username,
            authentication: {
                salt,
                password: authentication(salt, password),
            },
        });

        // Check if the user was created successfully
        if (!user) {
            res.status(500).json({ message: "Failed to create user." });
            return;
        }

        // Send the response after successful registration
        res.status(201).json(user); // Send the user object
        console.log('User created:', user);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "An error occurred while registering the user." });
    }
}