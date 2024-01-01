extern int add(int a, int b);
int mul(int a, int b) {
  int product = 0;
  for (int i = 0; i < a; i++)
    product = add(product, b);
  return product;
}
