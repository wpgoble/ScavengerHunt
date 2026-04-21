class Utils:
    @staticmethod
    def isEven(num):
        return num % 2 == 0

    @staticmethod
    def isOdd(num):
        return not Utils.isEven(num)
    
    @staticmethod
    def printArray(arr):
        print(", ".join(str(x) for x in arr))

    @staticmethod
    def quick_sort(arr):
        if len(arr <= 1): return arr
        pivot = arr[len(arr) // 2]
        return Utils.quick_sort([x for x in arr if x < pivot]) + \
            [x for x in arr if x == pivot] + Utils.quick_sort([x for x in arr if x > pivot])