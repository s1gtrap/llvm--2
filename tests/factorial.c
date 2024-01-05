int main(int argc, char **argv) {
  int result = 1;
  for (; argc > 1; argc--) {
    result *= argc;
  }
  return result;
}
