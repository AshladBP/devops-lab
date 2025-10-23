// app.test.js
const request = require('supertest');
const app = require('./app');

describe('Test the root path', () => {
  test('It should respond to the GET method', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, World!');
  });
});

describe('Test the /name/:name path', () => {
  test('It should respond with a personalized greeting', async () => {
    const name = 'Alice';
    const response = await request(app).get(`/name/${name}`);
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe(`Hello, ${name}!`);
  });
});

// New tests for Exercise 9
describe('Test the /add/:a/:b path', () => {
  test('It should return the sum of two positive integers', async () => {
    const response = await request(app).get('/add/5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Sum: 8');
  });

  test('It should return the sum of negative numbers', async () => {
    const response = await request(app).get('/add/-5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Sum: -2');
  });

  test('It should return the sum of decimal numbers', async () => {
    const response = await request(app).get('/add/2.5/3.7');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Sum: 6.2');
  });

  test('It should handle zero values correctly', async () => {
    const response = await request(app).get('/add/0/5');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Sum: 5');
  });

  test('It should return error for non-numeric first parameter', async () => {
    const response = await request(app).get('/add/abc/5');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Error: Both parameters must be valid numbers');
  });

  test('It should return error for non-numeric second parameter', async () => {
    const response = await request(app).get('/add/5/xyz');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Error: Both parameters must be valid numbers');
  });

  test('It should return error for both non-numeric parameters', async () => {
    const response = await request(app).get('/add/abc/xyz');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Error: Both parameters must be valid numbers');
  });
});
