// this is c equivalent of fib.asm
#include <stdio.h>

int main() {

  int a = 0;
  int b = 1;
  int c = 0;

  for (int i = 0; i < 20; i++) {
    printf("%d\n", a);
    c = a + b;
    a = b;
    b = c;
  }
}
