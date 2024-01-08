// credits to https://www.geeksforgeeks.org/quick-sort-in-c/

#include <stdio.h> 
#include <stdlib.h> 

void swap(long long *xp, long long *yp) {
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}

int partition(long long arr[], int low, int high) { 
	int pivot = arr[low]; 
	int i = low; 
	int j = high; 

	while (i < j) { 
		while (arr[i] <= pivot && i <= high - 1) { 
			i++; 
		} 

		while (arr[j] > pivot && j >= low + 1) { 
			j--; 
		} 
		if (i < j) { 
			swap(&arr[i], &arr[j]); 
		} 
	} 
	swap(&arr[low], &arr[j]); 
	return j; 
} 

void quicksort(long long arr[], int low, int high) { 
	if (low < high) { 
		int pi = partition(arr, low, high); 

		quicksort(arr, low, pi - 1); 
		quicksort(arr, pi + 1, high); 
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
  quicksort(ints, 0, n);
  print_ints(ints, n);
  free(ints);
	return 0; 
}

