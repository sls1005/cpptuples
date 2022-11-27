# CPP Tuples

A Nim wrapper for C++'s `std::tuple`, the variadic `class`. However, it is not wrapped as a `type` with variadic generic parameters, because there's (currently) no such thing in Nim. Instead, it is wrapped as a type with _no_ generic parameter. The actual type is inferred by the C++ compiler.

### Example

```nim
import cpptuples

proc main =
  var x = initCPPTuple(1.cint, 2.cfloat, 3.clong)
  assert get[cint](x) == 1

main()
```
This creates a `CPPTuple`. The constructor takes any number of arguments.

If the tuple contains two or more `cint`, you won't be able to access the `cint` element with the above syntax, so this module provides a new syntax:
```nim
import cpptuples

proc main =
  var x = initCPPTuple(10.cint, 20.cint)
  assert x[cint, 0] == 10

main()
```

The index (`csize_t`, starts from 0) must be known at the compile-time. In other words, it must be `static`.
If there's no index given (e.g. `x[cint]`), it's equivalent to the 1st example.

### Note

+ This can only be used within a procedure or function. Initializing a global `CPPTuple` variable is NOT allowed.

+ This module relies on the type-inferring feature of C++. For some reason it only works with C++17 or later (Nim currently uses C++14), so if you're with a compiler other than GCC or Clang, you have to pass a flag to it (with `--passC`), telling it to use the new standard. For GCC and Clang, it is automatically done by this module (It passes `-std=gnu++17`), so you don't have to worry about that. As C++ values backward-compatibility, this should not break your code.

+ Please always use types from C or C++ (like `cint`) as element types for `CPPTuple`. Using a Nim type for it may lead to incorrect code generation (and compile-time errors). If you really need a 64-bit integer, import `std::int64_t` from C++'s `<cstdint>`. For Nim's `int`, use `std::uintptr_t` instead, as the former always has the same size as a pointer. Never use GC'ed types (like `string` or `seq`) as an element.
