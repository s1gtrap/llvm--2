#include <stdlib.h>
#include <stdio.h>

void swap(long long *xp, long long *yp) {
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

void sort(long long *arr, int n) {
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        swap(&arr[j], &arr[j + 1]);
      }
    }
  }
}

#define CHUNK_SIZE 8

int read_ints(long long **ptr) {
  *ptr = malloc(CHUNK_SIZE*sizeof(long long));
  int n = 0;
  for (int i = 0; ; i++) {
    for (int j = i*CHUNK_SIZE; j < (i+1)*CHUNK_SIZE; j++, n++) {
      if (scanf("%lld", &(*ptr)[n]) == -1) return n;
    }
    *ptr = realloc(*ptr, (i+2)*CHUNK_SIZE*sizeof(long long));
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
  sort(ints, n);
  print_ints(ints, n);
  free(ints);
}
