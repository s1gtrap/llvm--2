#include <stdlib.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>


void add_edge(int n, int i, int j, bool edges[]) {
  //printf("add_edge(%d, %d)\n", i, j);
  edges[i+j*n*n*n*n] = true;
  edges[j+i*n*n*n*n] = true;
}


void init_sudoku(int n, int nodes[], bool edges[]) {
  for (int i = 0; i < n*n*n*n; i++) {
    nodes[i] = 0;
  }
  for (int i = 0; i < n*n*n*n*n*n*n*n; i++) {
    edges[i] = false;
  }
  for (int i = 0; i < n*n; i++) {
    for (int j = 0; j < n*n; j++) {
      for (int k = 0; k < n*n; k++) {
        if (k != i) add_edge(n, i+j*n*n, k+j*n*n, edges);
        if (k != j) add_edge(n, i+j*n*n, i+k*n*n, edges);

        int gi = i/n*n;
        int gj = j/n*n;
        for (int di = 0; di < n; di++) {
          for (int dj = 0; dj < n; dj++) {
            int i_ = gi + di;
            int j_ = gj + dj;
            if (i_ != i || j_ != j) {
              add_edge(n, i+j*n*n, i_+j_*n*n, edges);
            }
          }
        }
      }
    }
  }
}

char toc(int v) {
  if (v < 10) {
    return '0' + v;
  } else if (v < 46) {
    return 'A' + v - 10;
  }
}

void print_sudoku(int n, int nodes[]) {
  for (int i = 0; i < n*n; i++) {
    printf((n*i) % (n*n) == 0 ? "+-" : "--");
  }
  printf("+\n");

  for (int i = 0; i <= n*n - 1; i++) {
    for (int j = 0; j <= n*n - 1; j++) {
      if (j % n == 0) {
        if (nodes[j+i*n*n] > 0) {
          printf("|%c", toc(nodes[j+i*n*n]));
        } else {
          printf("| ");
        }
      } else {
        if (nodes[j+i*n*n] > 0) {
          printf(" %c", toc(nodes[j+i*n*n]));
        } else {
          printf("  ");
        }
      }
    }
    printf("|\n");

    if (i % n == n-1) {
      for (int i = 0; i < n*n; i++) {
        printf((n*i) % (n*n) == 0 ? "+-" : "--");
      }
      printf("+\n");
    }
  }
}

int degree(int n, int i, bool edges[]) {
  int deg = 0;
  for (; i < n*n*n*n*n*n*n*n; i += n*n*n*n) {
    deg += edges[i];
  }
  return deg;
}

bool coloring(int n, int k, int nodes[], bool edges[]) {
  // FIXME: All should be degree > k?
  /*int stackstart[n*n*n*n];
  int *stackend = &stackstart;
  int tocolor = n*n*n*n;
  int count = 1;
  while (count > 0) {
    count = 0;
    for (int i = 0; i < n*n*n*n; i++) {
      if (nodes[i] == 0 && degree(n, i, edges) < k) {
        // erase i
        count++;
        nodes[i] = k+1;
        stackend[0] = i;
        stackend++;
      }
    }
    tocolor = tocolor - count;
  }*/

  // find first uncolored
  for (int i = 0; i < n*n*n*n; i++) {
    if (nodes[i] == 0) {
      for (int c = 1; c <= k; c++) {
        for (int j = i; j < n*n*n*n*n*n*n*n; j += n*n*n*n) {
          if (edges[j]) {
            //printf("node %d has an edge with node %d\n", i, j / (n*n*n*n));
          }
          if (edges[j] && c == nodes[j / (n*n*n*n)]) {
            goto next;
          }
        }
        //printf("%d\n", c);

        //printf("trying to set %d to %d\n", i, c);
        nodes[i] = c;
        print_sudoku(n, nodes);
        if (coloring(n, k, nodes, edges)) {
          return true;
        }
        nodes[i] = 0;
      next:
      }
      break;
    }
  }

  for (int i = 0; i < n*n*n*n; i++) {
    if (nodes[i] == 0) return false;
  }

  return true;
}

bool test(int n) {
  int nodes[n*n*n*n];
  bool edges[n*n*n*n*n*n*n*n];

  init_sudoku(n, &nodes, &edges);

  for (int i = 0; i < n*n*n*n; i++) {
    char c = getchar();
    int v = 0;
    if ('1' <= c && c <= '9' || 'a' <= c && c <= 'z') {
      if ('1' <= c && c <= '9') {
        v = c - '0';
      } else {
        v = c - 'a' + 10; // FIXME: not sure if correct sub
      }
    }
    nodes[i] = v;
  }

  print_sudoku(n, &nodes);

  /*for (int i = 0; i < n*n*n*n; i++) {
    for (int j = 0; j < n*n*n*n; j++) {
      printf("%d ", edges[i+j*n]);
    }
    printf("\n");
  }*/

  /*for (int i = 0; i < n*n*n*n; i++) {
    printf("%d: %d\n", i, degree(n, i, edges));
  }*/

  return coloring(n, n*n, nodes, edges);
}

int main(int argc, char **argv) {
  //printf("%d\n", sizeof(int));
  //printf("%d\n", sizeof(pair_t));

  //test(1);
  //test(2);
  //test(3);
  return !test(atoi(argv[1]));
  //test(6);
  //test(3);
  //test(4);
}
