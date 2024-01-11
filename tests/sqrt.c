#include <stdlib.h>

int isqrt(int x) {
  if (x == 0 || x == 1) return x;
  int i = 1;
  for (int result = 1; result <= x; i++, result = i * i) {}
  return i - 1;
}

int main(int argc, char **argv) {
  return isqrt(atoi(argv[1]));
}
