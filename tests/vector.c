#include <stdio.h>

typedef struct {
  char c;
  int x;
  int y;
} vector;

void dot(vector *a, vector *b) { 
  a->x += b->x;
  a->y += b->y;
}

int main() {
  vector v1 = {'a',12,34};
  vector v2 = {'a',13,37};
  dot(&v1, &v2);
  printf("x=%d, y=%d\n", v1.x, v1.y);
}
