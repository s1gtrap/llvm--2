#include <stdio.h>
#include <stdlib.h>

int fac(unsigned long long n) {
  int c = 0;

  for (; (n & 1) == 0; n /= 2, ++c) {
    printf("2 ");
  }

  for (unsigned long long i = 3; i * i <= n; i += 2) {
    for (; n % i == 0; n /= i, ++c) {
      printf("%llu ", i);
    }
  }

  if (n > 2) {
    printf("%llu ", n);
    c++;
  }

  return c;
}

int main(int argc, char **argv) {
  return fac(strtoull(argv[1], NULL, 10));
}
