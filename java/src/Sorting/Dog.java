package Sorting;

import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;

public class Dog {
    public static int[] dogSort(int[] array) {
        // how many times the dog will iterate over the array before it sorts it
        int turns = ThreadLocalRandom.current().nextInt(1, 10);
        turns = 1;

        for(int i = 0; i < turns; i++) {
            for(int n = 0; n < array.length; n++) {
                System.out.println("Old State: " + Arrays.toString(array));
                backtrack(array, n);
                System.out.println("New State: " + Arrays.toString(array));
            }
            try {
                Thread.sleep(i * 10L);
            } catch (InterruptedException e) {
                // TODO Fix this later
                e.printStackTrace();
            }
        }
        return array;
    }

    private static void backtrack(int[] array, int start) {
        if (start == array.length) {
            return;
        }

        for(int i = start; i < array.length; i++) {
            swap(array, start, i);
            backtrack(array, start + 1);
            swap(array, start, i);
        }
    }

    private static void swap(int[] array, int first, int second) {
        int temp = array[first];
        array[first] = array[second];
        array[second] = temp;
    }
}