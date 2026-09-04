function addItem(cart, item) {
  if (!item?.id || Number(item.quantity) <= 0 || Number(item.price) < 0) throw new Error('Invalid cart item');
  const existing = cart.find(x => x.id === item.id);
  if (existing) return cart.map(x => x.id === item.id ? { ...x, quantity: x.quantity + Number(item.quantity) } : x);
  return [...cart, { ...item, quantity: Number(item.quantity) }];
}
module.exports = { addItem };
