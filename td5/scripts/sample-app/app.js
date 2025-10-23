const express = require('express');
const app = express();
app.get('/', (req, res) => {
  res.send('Hello, World!');
});
app.get('/name/:name', (req, res) => {
  res.send(`Hello, ${req.params.name}!`);
});

app.get('/add/:a/:b', (req, res) => {
  const a = parseFloat(req.params.a);
  const b = parseFloat(req.params.b);
  
  // Check if parameters are valid numbers
  if (isNaN(a) || isNaN(b)) {
    return res.status(400).send('Error: Both parameters must be valid numbers');
  }
  
  const sum = a + b;
  res.send(`Sum: ${sum}`);
});

module.exports = app;
