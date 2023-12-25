#include <stdio.h>
#include <stdlib.h>

int ack(int m, int n, int p) {
  if (p == 0) return m + n;
  if (n == 0 && p == 1) return 0;
  if (n == 0 && p == 2) return 1;
  if (n == 0) return m;
  return ack(m, ack(m, n-1, p), p-1);
}

int main(int argc, char **argv) {
  int m = atoi(argv[1]);
  int n = atoi(argv[2]);
  int p = atoi(argv[3]);
  printf("%d", ack(m, n, p));
  return 0;
}
