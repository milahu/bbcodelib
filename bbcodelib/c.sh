make -f bbcodelib.mak clean
make -f bbcodelib.mak
strip /opt/lib/bbcodelib.so
cp /opt/lib/bbcodelib.so ../../lib/
cp bbcode_lexer.h /opt/include/bbcodelib/
cp bbcode_utils.h /opt/include/bbcodelib/
cp bbcode_parser.h /opt/include/bbcodelib/
cp bbcode_config.h /opt/include/bbcodelib/