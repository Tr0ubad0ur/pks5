String truncateString(String input, int maxLength) {
  if (input.length > maxLength) {
    return '${input.substring(0, maxLength)}...';
  }
  return input;
}