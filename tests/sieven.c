#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char **argv) {
  int limit = atoi(argv[1]);

  bool *prime = malloc(sizeof(bool) * (limit + 1));
  for (int i = 2; i <= limit; ++i) {
    prime[i] = true;
  }

  for (int p = 2; p * p <= limit; ++p) {
    if (prime[p]) {
      for (int i = p * p; i <= limit; i += p) {
        prime[i] = false;
      }
    }
  }

  int primes = 0;
  for (int i = 2; i <= limit; ++i) {
    if (prime[i]) {
      primes++;
    }
  }

  printf("%i", primes);
  free(prime);

  return 0;
}
