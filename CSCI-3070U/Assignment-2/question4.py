import heapq
from collections import Counter

class Node:
    def __init__(self, char, freq):
        self.char = char
        self.freq = freq
        self.left = None
        self.right = None

    # Needed for priority queue comparisons
    def __lt__(self, other):
        return self.freq < other.freq

# Read file and calculate frequencies
def read_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        text = f.read()

    # Calculate frequency of each character
    freq = Counter(text)
    return text, freq

# Build Huffman tree and generate codes
def build_huffman_tree(freq):
    heap = []
    # Create priority queue of nodes
    for char, frequency in freq.items():
        heapq.heappush(heap, Node(char, frequency))
        
    # Combine nodes until one tree remains
    while len(heap) > 1:
        left = heapq.heappop(heap)
        right = heapq.heappop(heap)
        merged = Node(None, left.freq + right.freq)
        merged.left = left
        merged.right = right
        heapq.heappush(heap, merged)
        
    # Return root of the tree
    return heap[0]

# Generate prefix codes from the Huffman tree
def generate_codes(node, prefix="", map={}):
    if map is None:
        map = {}
    
    # Leaf node
    if node.char is not None:
        map[node.char] = prefix
        return map
    
    # Traverse left and right
    if node.left:
        generate_codes(node.left, prefix + "0", map)

    # Traverse right
    if node.right:
        generate_codes(node.right, prefix + "1", map)

    return map

# Main function to perform Huffman coding
def huffman_coding(freq):
    root = build_huffman_tree(freq)
    codes = generate_codes(root)
    return codes

# Print prefix codes and compression results
def print_results(text, freq_table, codes):
    for ch, code in sorted(codes.items()):
        printable = repr(ch)[1:-1]
        print(f"{printable!r:6}  freq={freq_table[ch]:4}  code={code}")

    # Calculate and print compression statistics
    original_bits = len(text) * 8
    compressed_bits = sum(freq_table[ch] * len(code) for ch, code in codes.items())

    print("\n--- Compression Results ---")
    print(f"Original size:     {original_bits} bits")
    print(f"Compressed size:   {compressed_bits} bits")
    print(f"Compression savings: {original_bits - compressed_bits} bits")


def main(filename):
    text, freq_table = read_file(filename)
    codes = huffman_coding(freq_table)
    print_results(text, freq_table, codes)

# Example usage
main("test.txt")