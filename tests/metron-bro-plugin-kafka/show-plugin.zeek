# @TEST-EXEC: zeek -NN metron::metron-bro-plugin-kafka |sed -e 's/version.*)/version)/g' >output
# @TEST-EXEC: btest-diff output
