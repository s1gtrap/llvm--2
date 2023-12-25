#include <stdlib.h>
int main(int argc, char **argv) {
  int s = 0;
  for (int i = argc; i > 0; i--) {
    s += atoi(argv[i]);
  }
  return s;
}
