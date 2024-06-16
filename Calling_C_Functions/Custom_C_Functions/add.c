#include <stdio.h>

extern int add(int, int);

int add(int a, int b) {
  printf("Custom C function Called Successfully. Performing the Addition.\n");
  return a + b;
}
