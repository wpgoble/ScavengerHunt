import java.util.ArrayList;
import java.util.Calendar;

/**
 * Will become the main entry point for this application
 * TODO: Add error handling for invalid input
 */
public class Helper {
    private static final int MAX_SIZE = 100;
    private static final String VERSION = "1.0.5";
   
    public static void main(String[] args) {
        // TODO: Parse command line arguments
        System.out.println("Welcome to my application");
        System.out.println("Version: " + VERSION);

        Calendar calc = new Calculator();
        int result = calc.add(5, 4);
        System.out.println("5 + 4 = " + result);

        // FIXME: This calculation is wrong
        int value = calc.multiply(4, 7);
        
        ArrayList<String> names = new ArrayList<>();
        names.add("Alice");
        names.add("Bob");

        for(String name:names) {
            System.out.println("Name: " + name);
        }
    }

    public static void displayInfo() {
        System.out.println("Info to be displayed...");
    }

    // Note: This method should be optimized
    public static boolean validateEmail(String email) {
        return email.contains("@") && email.contains(".");
    }
}
