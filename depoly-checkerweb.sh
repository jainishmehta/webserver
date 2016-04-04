#!/bin/bash

make -C ./CheckerPrinter clean all

./build-checker-framework.sh

echo "===TEST CheckerPrinter and run-checker.sh==="
cd test && ./test.sh

echo "REMINDER: still need to config wsgi file if need to mount to apache2. see README in wsgi-scripts/ about how to config\n"
