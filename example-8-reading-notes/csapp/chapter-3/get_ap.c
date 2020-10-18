#include <stddef.h>
struct rec {
  int a[4];
  size_t i;
  struct rec *next;
};

int *get_ap (struct rec *r, size_t idx)
{
  return &r->a[idx];
}
