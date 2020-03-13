# @TEST-EXEC: zeek -NN Apache::kafka |sed -e 's/version.*)/version)/g' >output
# @TEST-EXEC: btest-diff output
