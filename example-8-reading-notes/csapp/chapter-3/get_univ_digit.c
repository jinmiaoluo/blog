#include <stddef.h>

#define UCOUNT 3
#define ZLEN 5

typedef int zip_dig[ZLEN];

zip_dig cmu = { 1, 5, 2, 1, 3 };
zip_dig mit = { 0, 2, 1, 3, 9 };
zip_dig ucb = { 9, 4, 7, 2, 0 };

int *univ[UCOUNT] = {mit, cmu, ucb};

int get_univ_digit (size_t index, size_t digit)
{
  return univ[index][digit];
}
