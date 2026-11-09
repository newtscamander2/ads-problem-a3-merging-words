def newton(f, df, x0, tol=1e-10, max_iter=50):
    """Find a root of f with Newton's method."""
    x = x0
    for _ in range(max_iter):
        step = f(x) / df(x)
        x -= step
        if abs(step) < tol:  # converged
            return x
    raise RuntimeError("no convergence")


print(newton(lambda x: x**2 - 2, lambda x: 2 * x, 1.0))
