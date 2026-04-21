package Tools;

import java.util.Arrays;
import java.util.function.Function;

public class ArrayUtils {
    public static void printArrays(int[] src, String name, Function<int[], int[]> func) {
        System.out.println("\n" + name + ":");
        System.out.println("\tSource array: " + Arrays.toString(src));
        int[] result = func.apply(src);
        System.out.println("\tResult array: " + Arrays.toString(result));
    } 
}
