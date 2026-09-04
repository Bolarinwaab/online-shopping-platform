const test = require('node:test');
const assert = require('node:assert/strict');
const { addItem } = require('../src/cart');

test('adds a product and merges repeated quantity', () => {
  let cart = addItem([], { id: 'p1', name: 'Keyboard', price: 50, quantity: 1 });
  cart = addItem(cart, { id: 'p1', name: 'Keyboard', price: 50, quantity: 2 });
  assert.deepEqual(cart, [{ id: 'p1', name: 'Keyboard', price: 50, quantity: 3 }]);
});

test('rejects zero or negative quantities', () => {
  assert.throws(() => addItem([], { id: 'p1', name: 'Keyboard', price: 50, quantity: 0 }));
});
