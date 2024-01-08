#include <stdlib.h>
#include <stdio.h>

#define CHUNK_SIZE 8

int read_ints(long long **ptr) {
  *ptr = malloc(CHUNK_SIZE*sizeof(long long));
  printf("%p\n", ptr);
  printf("%p\n", *ptr);
  int n = 0;
  for (int i = 0; ; i++) {
    for (int j = i*CHUNK_SIZE; j < (i+1)*CHUNK_SIZE; j++, n++) {
      printf("%p\n", ptr);
      printf("%p\n", *ptr);
      printf("%d\n", n);
      printf("%p\n", &(*ptr)[n]);
      if (scanf("%lld", &(*ptr)[n]) == -1) return n;
      printf("%lld\n", (*ptr)[n]);
    }
    *ptr = realloc(*ptr, (i+2)*CHUNK_SIZE*sizeof(long long));
    printf("%p\n", *ptr);
  }
  return n;
}

void print_ints(long long *ints, int n) {
  for (int i = 0; i < n; i++) {
    printf("%lld\n", ints[i]);
  }
}

int main() {
  long long *ints;
  int n = read_ints(&ints);
  print_ints(ints, n);
  free(ints);
}
