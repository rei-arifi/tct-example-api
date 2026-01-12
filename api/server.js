const express = require('express');
const OpenApiValidator = require('express-openapi-validator');
const fs = require('fs').promises;
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;
const COUNTER_FILE = path.join(__dirname, 'counter.json');

// Initialize counter file if it doesn't exist
async function initializeCounter() {
  try {
    await fs.access(COUNTER_FILE);
  } catch (error) {
    await fs.writeFile(COUNTER_FILE, JSON.stringify({ count: 0 }));
  }
}

// Middleware to parse JSON bodies
app.use(express.json());
app.use(
    OpenApiValidator.middleware({
      apiSpec: './openapi.yaml',
      validateRequests: true,
      validateResponses: true,
    }),
);

// test comment
app.get("/health/live", async(req, res) => {
    res.status(200)
})

// Ping endpoint with counter
app.get('/api/ping', async (req, res) => {
  try {
    // Read current count
    const data = await fs.readFile(COUNTER_FILE, 'utf8');
    const counter = JSON.parse(data);

    // Increment count
    counter.count += 1;

    // Save updated count
    await fs.writeFile(COUNTER_FILE, JSON.stringify(counter, null, 2));

    res.json({
      success: true,
      message: 'pong',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error updating counter:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update counter'
    });
  }
});

// Get ping count endpoint
app.get('/api/ping/count', async (req, res) => {
  try {
    const data = await fs.readFile(COUNTER_FILE, 'utf8');
    const counter = JSON.parse(data);

    res.json({
      success: true,
      count: counter.count,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error reading counter:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to read counter'
    });
  }
});

// Initialize counter file and start server
initializeCounter().then(() => {
  app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });
}).catch(error => {
  console.error('Failed to initialize counter:', error);
  process.exit(1);
});

module.exports = app;
