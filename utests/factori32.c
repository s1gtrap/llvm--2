#include <stdio.h>
#include <stdlib.h>

int fac(int n) {
  int c = 0;

  for (; (n & 1) == 0; n /= 2, ++c) {
    printf("2 ");
  }

  for (int i = 3; i * i <= n; i += 2) {
    for (; n % i == 0; n /= i, ++c) {
      printf("%i ", i);
    }
  }

  if (n > 2) {
    printf("%i ", n);
    c++;
  }

  return c;
}

int main(int argc, char **argv) {
  return fac(atoi(argv[1]));
}
