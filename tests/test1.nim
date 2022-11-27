import cpptuples

proc main =
  var x = initCPPTuple(cint(1), cfloat(2), clong(3), cdouble(4))
  assert x.tupleSize == 4
  echo get[cint](x)
  echo get[cfloat](x)
  echo x[clong, 2]
  echo x[cdouble, 3]
  get[cint](x) = 5
  x[cfloat] = 6
  echo x[cint]
  echo x[cfloat]

main()
