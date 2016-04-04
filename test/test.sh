input=$(<test-input.txt)
cd ../
./run-checker.sh "$input" >test/run-result.txt
cd test
TEST_RESULT="diff test-result.txt run-result.txt"

DIFF_COUNT=$(eval $TEST_RESULT | wc -l 2>>/dev/null)
if [ $? -eq 0 -a $DIFF_COUNT -eq 0 ]; then
  echo -e "\\e[1;32mPASS.\\e[0m"
  PASSED=$(echo $PASSED | awk '{ print $1+1 }')
else
  echo -e "\\e[1;31mFAIL! see run-result.txt for details. (this is the output of checkerprinter)\\e[0m"
fi

