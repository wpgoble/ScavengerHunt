package Sorting;

public class Communist {
    public static int[] communistSort(int[] array) {
        int[] result = new int[array.length];
        int total = 0;
        for(int val: array) {
            total += val;
        }

        int average = total / array.length;

        for(int i = 0; i < result.length; i++) {
            result[i] = average;
        }
        return result;
    }
}
