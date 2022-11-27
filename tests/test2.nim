import cpptuples

proc main =
  var x = initCPPTuple(cint(10), cint(20))
  echo x[cint, 0]
  echo x[cint, 1]

main()
