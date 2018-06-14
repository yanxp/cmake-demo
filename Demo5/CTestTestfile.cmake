# CMake generated Testfile for 
# Source directory: /home/yanxp/yarley/yanxp/codework/cmake-demo/Demo5
# Build directory: /home/yanxp/yarley/yanxp/codework/cmake-demo/Demo5
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(test_run "Demo" "5" "2")
ADD_TEST(test_usage "Demo")
SET_TESTS_PROPERTIES(test_usage PROPERTIES  PASS_REGULAR_EXPRESSION "Usage: .* base exponent")
ADD_TEST(test_5_2 "Demo" "5" "2")
SET_TESTS_PROPERTIES(test_5_2 PROPERTIES  PASS_REGULAR_EXPRESSION "is 25")
ADD_TEST(test_10_5 "Demo" "10" "5")
SET_TESTS_PROPERTIES(test_10_5 PROPERTIES  PASS_REGULAR_EXPRESSION "is 100000")
ADD_TEST(test_2_10 "Demo" "2" "10")
SET_TESTS_PROPERTIES(test_2_10 PROPERTIES  PASS_REGULAR_EXPRESSION "is 1024")
SUBDIRS(math)
