include(CTest)

list(APPEND CMAKE_CTEST_ARGUMENTS --output-on-failure --continue-on-failure --timeout 10 -E 'speed_test|optimization')

set(compile_name "compile with bug-checkers")
add_test(NAME ${compile_name}
  COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" -t functionality_testing)

macro (ttest name)
  add_test(NAME ${name} COMMAND "${name}_sanitized")
  set_property(TEST ${name} PROPERTY FIXTURES_REQUIRED compile)
endmacro (ttest)

set_property(TEST ${compile_name} PROPERTY TIMEOUT -1)
set_tests_properties(${compile_name} PROPERTIES FIXTURES_SETUP compile)

ttest(net_interface_test_typical)
ttest(net_interface_test_reply)
ttest(net_interface_test_learn)
ttest(net_interface_test_pending)
ttest(net_interface_test_expiry)
ttest(net_interface_test_independence)

add_custom_target (pa1 COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure --continue-on-failure --timeout 12 -R '^net_interface')
