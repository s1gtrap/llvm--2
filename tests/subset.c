#include <stdio.h>

int subsets(int n, char *set[]) {
  int i;
  for (i = 0; i < (1 << n); i++) {
    printf("{ ");
    for (int j = 0; j < n; j++) {
      if (i & (1 << j)) {
        printf("%s ", set[j + 1]);
      }
    }
    printf("}\n");
  }
  return i;
}

int main(int argc, char **argv) {
  return subsets(argc - 1, argv);
}
