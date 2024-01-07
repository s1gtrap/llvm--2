#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv) {
  unsigned long long n = strtoull(argv[1], NULL, 10);
  for (int i = 0; i < n; i++) {
    printf("yo");
  }
  return 0;
}
