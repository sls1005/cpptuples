when not defined(cpp):
  {.error: "This can only be used with the C++ backend.".}
elif defined(gcc) or defined(clang):
  when not defined(useDefaultCStd):
    {.passC: "-std=gnu++17".}

{.push header: "<tuple>".}

type CPPTuple* {.importcpp: "std::tuple", cppNonPod.} = object

proc initCPPTuple*(): CPPTuple {.constructor, varargs, importcpp: "'0(@)".}
  ## This `proc` can take any number of arguments. The types are inferred.
  ##
  ## **Example:**
  ##
  ## .. code-block::
  ##   import cpptuples
  ##   proc main =
  ##     var x = initCPPTuple(cint(1), cfloat(2), clong(3), cdouble(4))
  ##     echo x.get[cint]
  ##   main()

proc tupleSize*(self: CPPTuple): csize_t {.importcpp: "(std::tuple_size_v<decltype(#)>)".}
  ## The number of elements.
  #  `decltype` is used instead of `'1`, because the actual type is not known from Nim, but from C++.

proc get*[T](t: var CPPTuple): var T {.importcpp: "(std::get<'*0>(#))".}

proc get*[T](t: CPPTuple): T {.importcpp: "std::get<'0>(#)".}

proc get[T](idx: csize_t, t: CPPTuple): T {.importcpp: "std::get<#>(#)".}

proc get[T](idx: csize_t, t: var CPPTuple): var T {.importcpp: "(std::get<#>(#))".}

{.pop.}

template `[]`*[T](self: CPPTuple, typ: typedesc[T], idx: static[csize_t]): T =
  ## **Example:**
  ##
  ## .. code-block::
  ##   import cpptuples
  ##   proc main =
  ##     var x = initCPPTuple(cint(10), cint(20))
  ##     echo x[cint, 0] #10
  ##     echo x[cint, 1] #20
  #    main()
  get[T](idx, self)

template `[]`*[T](self: CPPTuple, typ: typedesc[T]): T =
  get[T](self)

template `[]`*[T](self: var CPPTuple, typ: typedesc[T], idx: static[csize_t]): var T =
  get[T](idx, self)

template `[]`*[T](self: var CPPTuple, typ: typedesc[T]): var T =
  get[T](self)

template `[]=`*[T](self: var CPPTuple, typ: typedesc[T], idx: static[csize_t], val: T) =
  get[T](idx, self) = val

template `[]=`*[T](self: var CPPTuple, typ: typedesc[T], val: T) =
  get[T](self) = val
