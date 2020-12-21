/*
 * StaticAndExtern.c
 * gcc -g StaticAndExtern.c -o StaticAndExtern
 */
#include "StaticAndExtern.h"

/* Define a global variable */
int b = 0;

void set(void) {
  /* Update the value of the gobal variable b */
  b = 2;
}

void updateStaticVar(void) {
  /* Declare and define a static local variable
   * function updateStaticVar can't access variable c */
  static int d = 3;
  d++;
  a++;
  printf("Print d from updateStaticVar function: %d\n", d);
  printf("Print a from updateStaticVar function: %d\n", a);

  /* The following codes won't work, e is a local variable */
  //e++;
  //printf("Print e from updateStaticVar function: %d\n", e);

  /* The following codes won't work. c is a static local variable that can be
   * accessed by main only */
  //printf("print c from updateStaticVar function: %d\n", c);
}

void main(void) {
  set();
  a = 1;
  /* Declare and define a local variable */
  int e = 5;
  /* Declare and define a static local variable */
  static int c = 3;
  updateStaticVar();
  /* The value of d will be increased by 1 per reference, static local variables
   * will always exist until the end of the program */
  updateStaticVar();
  printf("Print values from main: %d %d %d %d\n", a, b, c, e);
}
