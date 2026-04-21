package Sorting;

import java.util.Arrays;

public class Stalin {
   public static int[] stalinSort(int[] array) {
        array = Arrays.copyOf(array, array.length);

        int i = 0;
        for (int j = 1; j < array.length; i++, j++) {
            if (array[i] > array[j]) {
                i--;
            } else {
                if (j - i > 1) {
                    array[i + 1] = array[j];
                }
            }
        }
        return Arrays.copyOf(array, i + 1);
    } 
}
