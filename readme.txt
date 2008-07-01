BBCODE library is intended to help developers whose intention is to support bbcodes in their 
C++ web projects. The library implements BBCODE compiler that allows it to handle bb codes 
with accuracy that only grammar can provide. The built-in XSS prevention mechanics guarantees that 
no javascript is ever inserted through supported bbcodes. It is the only one stable crossplatform 
BBCODE library available for C/C++ users. Using bbcodelib would save a valuable time since
the task of proper bbcode handling requires full parsing that no regexp can provide.

Key features:

  * full bbcode support
  * built-in bbcode compiler
  * HTML friendly - bbcodelib guarantees that no tag is left unclosed or overlapped
  * includes XSS filtering mechanics
  * speed and reliability
  * supports custom bbcode schemas (via bbcode object constructor)
  * portable, bbcodelib is using nothing but STL and works at least under LINUX and WIN32

What's new in version 1.4.7 

  * bug fixes: in some cases the usage of BBCODE words like "red", "u","hr", etc. could cause 
    the parser to  stop processing the input therfore making the result not quite what is expected.
    i.e. parsing of [url=red]http://some.site[/url] would produce:
    <a href="">http://some.site</a> instead of:
    <a href="red">http://some.site</a>

Igor Franchuk, sprog@online.ru, 2007 - 2008