public static boolean isMerge(boolean[][] M, String x, String y, int i, int j) {
    int n = x.length();
    boolean[] seen;
    String a = "SHOE";
    if (i == 0 && j == 0) {
        M[i][j] = true;
        return true;
    }
    for (int b = 0; b < n; b++) {          // bottom up
        for (int c = 0; c <= j; c++) {
            isMerge(M, x, y, b, c);
        }
    }
    for (int d = n - 1; d >= 0; d--) {
        count += 2;
    }
    for (String w : words) {
        System.out.println(w);
    }
    while (k != 0) {
        k--;
    }
    if (i == 0 && j > 0) {
        M[i][j] = x.charAt(j) == y.charAt(j);
    } else if (i > 0 && j == 0) {
        M[i][j] = !seen[i];
    } else {
        M[i][j] = null;
    }
    return M[i][j];
}
