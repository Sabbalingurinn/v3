/* eslint-env node */

import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { router } from './routes.js';
import http from 'http';
import { getCategoriesFromDatabase } from './lib/db.client.js'; // Import function to fetch categories

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// Serve static files (CSS, images, JavaScript)
app.use(express.static(path.join(__dirname, '../public')));

// Middleware for parsing URL-encoded data
app.use(express.urlencoded({ extended: true }));

// Set up view engine and views folder
const viewsPath = path.join(__dirname, 'views');
app.set('views', viewsPath);
app.set('view engine', 'ejs');

// **Render index.ejs with categories**
app.get('/', async (req, res) => {
  try {
    const categories = await getCategoriesFromDatabase(); // Fetch categories from DB
    res.render('index', { categories }); // Render EJS template with data
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Use additional routes from routes.js
app.use('/', router);

// Define the port (Render assigns one, fallback to 3000)
const PORT = process.env.PORT || 3000;
const HOSTNAME = '0.0.0.0'; // Allow external connections

// Create HTTP server
const server = http.createServer(app);

server.listen(PORT, HOSTNAME, () => {
  console.log(`✅ Server running at http://${HOSTNAME}:${PORT}/`);
});

// Handle server errors, especially if the port is in use
server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.warn(`⚠️ Port ${PORT} is in use, trying a new port...`);
    server.listen(0, HOSTNAME, () => {
      const newPort = server.address().port;
      console.log(`✅ Server running at http://${HOSTNAME}:${newPort}/`);
    });
  } else {
    console.error('❌ Server error:', err);
    process.exit(1);
  }
});
