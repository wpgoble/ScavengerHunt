import Sorting.Communist;
import Sorting.Sleep;
import Sorting.Stalin;
import Tools.ArrayUtils;
import Sorting.Dog;

public class App {
    public static void main(String[] args) throws Exception {
        int[] arr1 = {1, 0, 3, 4, 5, 8, 6, 7, 9};
        // int[] arr2 = {9, 8, 7, 6, 5, 4, 3, 2, 1};

        int[] temp = Dog.dogSort(arr1);

        // ArrayUtils.printArrays(arr1, "Stalin Sort", Stalin::stalinSort);
        // ArrayUtils.printArrays(arr2, "Stalin Sort", Stalin::stalinSort);
        // ArrayUtils.printArrays(arr1, "Communist Sort", Communist::communistSort);
        // ArrayUtils.printArrays(arr2, "Communist Sort", Communist::communistSort);
        // ArrayUtils.printArrays(arr1, "Sleep Sort", Sleep::sleepSort);
        // ArrayUtils.printArrays(arr2, "Sleep Sort", Sleep::sleepSort);
    }
}
