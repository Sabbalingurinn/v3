/* eslint-env node */

import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { router } from './routes.js';
import http from 'http';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// Serve static files (CSS, images, JavaScript)
app.use(express.static(path.join(__dirname, '../public')));

app.use(express.urlencoded({ extended: true }));

// Stillum views möppuna rétt
const viewsPath = path.join(__dirname, 'views');
app.set('views', viewsPath);
app.set('view engine', 'ejs');

// Add default route
app.get('/', (req, res) => {
  res.send('Server is running!');
});

app.use('/', router);

// Veljum port með fallbak
const PORT = process.env.PORT || 3000; // Use Render's assigned port or fallback to 3000
const HOSTNAME = '0.0.0.0'; // Allow external connections

// Búum til HTTP server manually svo við getum meðhöndlað villur
const server = http.createServer(app);

server.listen(PORT, HOSTNAME, () => {
  console.log(`Server running at http://${HOSTNAME}:${PORT}/`);
});

// Meðhöndla villu ef port er upptekið og velja nýtt port
server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.warn(`⚠️ Port ${PORT} is in use, trying a new port...`);

    // Veljum næsta lausa port (3001, 3002, ...)
    server.listen(0, HOSTNAME, () => {
      const newPort = server.address().port;
      console.log(`Server running at http://${HOSTNAME}:${newPort}/`);
    });
  } else {
    console.error('Server error:', err);
    process.exit(1);
  }
});
