public class Calculator {
    
    // Basic arithmetic operations
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
            throw new IllegalArgumentException("Cannot divide by zero");
        }
        return a / b;
    }
    
    /**
     * Calculates the power of a number.
     * FIXME: Currently doesn't handle negative exponents
     */
    public int power(int base, int exponent) {
        int result = 1;
        for (int i = 0; i < exponent; i++) {
            result *= base;
        }
        return result;
    }
    
    public boolean isEven(int number) {
        return number % 2 == 0;
    }
    
    public boolean isOdd(int number) {
        return number % 2 != 0;
    }
}