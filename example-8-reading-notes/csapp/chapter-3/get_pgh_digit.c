#include <stddef.h>
# define PCOUNT 4
#define ZLEN 5

typedef int zip_dig[ZLEN];

zip_dig pgh[PCOUNT] =
  {{1, 5, 2, 0, 6 },
   {1, 5, 2, 1, 3 },
   {1, 5, 2, 1, 7 },
   {1, 5, 2, 2, 1 }};

int get_pgh_digit (size_t index, size_t digit)
{
  return pgh[index][digit];
}
