void main() {
  // ------------------------------
  // 1. Using const for constants
  // ------------------------------

  // Value must be known at compile time
  //const x;
  const pi = 3.14159;
  const greeting = 'Welcome!';
  //pi=2;
  //const x = input from user?;

  print(pi);        // Output: 3.14159
  print(greeting);  // Output: Welcome!

  // ------------------------------
  // 2. Const is immutable
  // ------------------------------

  // pi = 3.14;   // ❌ ERROR: You cannot change a const value once set

  // ------------------------------
  // 3. Const collections (compile-time constants)
  // ------------------------------

  const numbers = [1, 2, 3];  // ---
  print(numbers);

  //numbers.add(4); // NOT POSSIBLE

  // ------------------------------
  // 4. Difference from 'final'
  // ------------------------------
  // - const: must be known at compile time (hardcoded values)
  // - final: set once, but can be assigned at runtime

  //final currentYear = DateTime.now().year; // CORRECT
  // const currentYear = DateTime.now().year; // WRONG

  print("Year: $currentYear");
}
