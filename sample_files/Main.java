import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Main entry point for the application.
 * TODO: Add error handling for invalid input
 */
public class Main {
    private static final int MAX_SIZE = 100;
    private static final String VERSION = "1.0.5";
    
    public static void main(String[] args) {
        // TODO: Parse command line arguments
        System.out.println("Welcome to the application");
        System.out.println("Version: " + VERSION);
        
        Calculator calc = new Calculator();
        int result = calc.add(5, 3);
        System.out.println("5 + 3 = " + result);
        
        // FIXME: This calculation is wrong
        int wrong = calc.multiply(4, 7);
        
        ArrayList<String> names = new ArrayList<>();
        names.add("Alice");
        names.add("Bob");
        
        for (String name : names) {
            System.out.println("Name: " + name);
        }
    }
    
    public static void displayInfo() {
        System.out.println("Info displayed");
    }
    
    // Note: This method needs optimization
    private static boolean validateEmail(String email) {
        return email.contains("@") && email.contains(".");
    }
}