#include <stddef.h>
#define WSIZE 8*sizeof(int)
long pcount_for (unsigned long x) {
  size_t i;
  long result = 0;
  for (i = 0; i < WSIZE; i++) {
    unsigned bit = (x >> i) & 0x1;
    result += bit;
  }
  return result;
}
