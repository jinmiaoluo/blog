long switch_eg (long x, long y, long z) {
  long w = 1;
  switch(x) {
    case 1:
      w = y*z;
      break;
    case 2:
      w = y/z;
      /* Fall Through */
      /* 作者解释到. 我们应该避免使用 Fall Through. 如果实在需要用. 应该注明为什么一定要用的原因. */
    case 3:
      w += z;
      break;
    case 5:
    case 6:
      w -= z;
      break;
    default:
      w = 2;
  }
  return w;
}
