import java.util.Arrays;
import java.util.List;

public class StringUtils {
    
    private static final String DEFAULT_ENCODING = "UTF-8";
    private static final int BUFFER_SIZE = 1024;
    
    /**
     * Reverses a string
     * TODO: Handle null input gracefully
     */
    public static String reverse(String input) {
        return new StringBuilder(input).reverse().toString();
    }
    
    /**
     * Checks if a string is a palindrome
     * NOTE: This is case-sensitive
     */
    public static boolean isPalindrome(String str) {
        String reversed = reverse(str.replaceAll(" ", ""));
        return str.replaceAll(" ", "").equals(reversed);
    }
    
    /**
     * Counts occurrences of a substring
     * FIXME: This doesn't work correctly with overlapping patterns
     */
    public static int countOccurrences(String text, String pattern) {
        return text.split(pattern, -1).length - 1;
    }
    
    public static String toUpperCase(String str) {
        if (str == null) return null;
        return str.toUpperCase();
    }
    
    public static String toLowerCase(String str) {
        if (str == null) return null;
        return str.toLowerCase();
    }
    
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }
    
    public static String trim(String str) {
        return str == null ? null : str.trim();
    }
    
    // Private helper method
    private static boolean isValidFormat(String format) {
        return format != null && format.matches("[A-Za-z0-9_]+");
    }
}