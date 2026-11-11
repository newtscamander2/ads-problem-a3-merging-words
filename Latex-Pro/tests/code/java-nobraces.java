for(int i = 0; i < M.length; i++)
for(int j = 0; j < M[i].length; j++)

if(i == 0 && j == 0)
M[i][j] = true;

if(i > 0 && j > 0)
M[i][j] = (z.charAt(i + j) == y.charAt(j) && M[i][j - 1]) ||
(z.charAt(i+j) == x.charAt(i) && M[i-1][j]);
