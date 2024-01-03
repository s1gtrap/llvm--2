#include <stdlib.h>
#include <stdio.h>

void assert(unsigned char a, unsigned char b, unsigned char c) {
  if (a + b != c) {
    printf("%dhh + %dhh != %dhh\n", a, b, c);
  } else {
    printf("%dhh + %dhh == %dhh\n", a, b, c);
  }
}

int main(int argc, char **argv) {
  assert(argc, 0, 0);
}
