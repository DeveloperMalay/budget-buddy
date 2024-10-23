import express from 'express';
import http from 'http';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import compression from 'compression';
import cors from 'cors';

const app = express();

app.use(cors({
    credentials: true,
}));

app.use(compression());
app.use(cookieParser());
app.use(bodyParser.json());


const server = http.createServer(app);
const uri = "mongodb+srv://malay13pandit:7UGwkVzidb4mVnr5@cluster0.6bk7k.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

server.listen(8080, () => {
    console.log('Server running on http://localhost:8080/')
})