public class Calculator {
    // Basic arithmetic opertations
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    public double divide(double a, double b) {
        // TODO: Add division by zero check
        if (b == 0) {
            throw new IllegalArgumentException("Unable to divide by zero at this time...");
        }

        return a / b;
    }

    /**
     * Calculates the power of a numbner
     * FIXME: Currently does not handle negative numbers
     */
    public int power(int base, int exponent) {
        int result = 1;
        for(int i = 0; i < exponent; i++) {
            result *= base;
        }
        return result;
    }
}
