class MaxHeap:
    def __init__(self, arr=None):
        if arr is None:
            self.heap = [None]
            self.heap_size = 0
        else:
            self.heap = [None] + arr
            self.heap_size = len(arr)
            self.build_max_heap()
    
    
    def left(self, i):
        return 2 * i
    
    
    def right(self, i):
        return 2 * i + 1
    
    
    def parent(self, i):
        return i // 2
    
    
    def max_heapify(self, i):
        l = self.left(i)
        r = self.right(i)
        
        if l <= self.heap_size and self.heap[l] > self.heap[i]:
            largest = l
        else:
            largest = i
        
        if r <= self.heap_size and self.heap[r] > self.heap[largest]:
            largest = r
        
        if largest != i:
            temp = self.heap[i]
            self.heap[i] = self.heap[largest]
            self.heap[largest] = temp
            
            self.max_heapify(largest)
    
    
    def build_max_heap(self):
        for i in range(self.heap_size // 2, 0, -1):
            self.max_heapify(i)
    
    
    def heap_maximum(self):
        if self.heap_size < 1:
            print("Heap is empty")
            return None
        return self.heap[1]
    
    
    def heap_extract_max(self):
        if self.heap_size < 1:
            print("Heap underflow")
            return None
        
        max_val = self.heap[1]
        self.heap[1] = self.heap[self.heap_size]
        self.heap_size = self.heap_size - 1
        self.max_heapify(1)
        
        return max_val
    
    
    def heap_increase_key(self, i, key):
        if key < self.heap[i]:
            print("New key is smaller than current key")
            return
        
        self.heap[i] = key
    
        while i > 1 and self.heap[self.parent(i)] < self.heap[i]:
            temp = self.heap[i]
            self.heap[i] = self.heap[self.parent(i)]
            self.heap[self.parent(i)] = temp
            i = self.parent(i)
    
    
    def max_heap_insert(self, key):
        self.heap_size = self.heap_size + 1

        if len(self.heap) <= self.heap_size:
            self.heap.append(float('-inf'))
        else:
            self.heap[self.heap_size] = float('-inf')
        self.heap_increase_key(self.heap_size, key)
    
    
    def print_heap(self):
        print(self.heap[1:self.heap_size + 1])
    
    
    def print_as_array(self):
        print("Heap as array:", self.heap[1:self.heap_size + 1])
    
    
    def print_as_tree(self):
        if self.heap_size == 0:
            print("Empty heap")
            return
        
        
        def print_tree_recursive(index, depth):
            if index > self.heap_size:
                return
            
            right = self.right(index)
            if right <= self.heap_size:
                print_tree_recursive(right, depth + 1)
            
            print("    " * depth + str(self.heap[index]))
            
            left = self.left(index)
            if left <= self.heap_size:
                print_tree_recursive(left, depth + 1)
        
        print_tree_recursive(1, 0)



# Test cases

if __name__ == "__main__":
    
    # Test build_max_heap
    arr = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
    heap = MaxHeap(arr)
    print("After building max heap:")
    heap.print_as_array()
    print("\nHeap as tree:")
    heap.print_as_tree()
    
    # Test heap_maximum
    print(f"\nMaximum: {heap.heap_maximum()}")
    
    # Test heap_extract_max
    print(f"\nExtracted max: {heap.heap_extract_max()}")
    heap.print_as_array()
    print("\nHeap as tree:")
    heap.print_as_tree()
    
    # Test max_heap_insert
    print("\nInserting 20:")
    heap.max_heap_insert(20)
    heap.print_as_array()
    print("\nHeap as tree:")
    heap.print_as_tree()
    
    print(f"\nNew maximum: {heap.heap_maximum()}")