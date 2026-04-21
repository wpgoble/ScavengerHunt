package Sorting;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Sleep {
    public static int[] sleepSort(int[] array) {
        List<Integer> result = Collections.synchronizedList(new ArrayList<>());
        Thread[] threads = new Thread[array.length];

        for(int i = 0; i < array.length; i++) {
            final int element = array[i];
            threads[i] = new Thread(() -> {
                try {
                    Thread.sleep(element * 100L);   // 100ms per unit
                    result.add(element);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            });
            threads[i].start();
        }

        // Waiting for threads to finish
        for(Thread thread: threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

        return result.stream().mapToInt(Integer::intValue).toArray();
    }
}
