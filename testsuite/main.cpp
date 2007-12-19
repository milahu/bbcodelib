/*!

	Abstract:
		this file is a testsuite|demo for bbcode library

	Author:
		Igor Franchuk (sprog@online.ru)

	Last Update:
		$Id: main.cpp,v 1.1 2007/12/19 19:12:50 lanthruster Exp $
		Version: 0.01
*/

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <stdexcept>

#include "bbcode_parser.h"

#ifdef WIN32
#include "io.h"
#include <fcntl.h>		//! #define _O_BINARY
#endif


namespace{
	using namespace std;
	using namespace bbcode;	
}

string load_file(const string& f);
long file_size(ifstream& ios);

int main(int argc, char* argv[]){
	cout << "bbcode library test suite" << endl;
	try{		
#ifdef WIN32
		_setmode(fileno(stdin), _O_BINARY);
#endif
	/*
	 Currently bbcode library works only with streams. It is NOT possible to make parser to 
	 load data from string directly. But may be in future I'll add std::string support. 
	 So far it seems useless. If you think otherwise please contact me.
	*/
	stringstream str(load_file("message.bb"));

	parser bbparser;
	//bbparser.setf(bbcode::DEBUG_MODE_ON);
	bbparser.source_stream(str);

	/* Displaying current tag_schema. Changing schema is the correct way to customize 
	   bbcode parser.  For example if you're not going to support some bbcode just upload a new 
	   schema that has no support for this tag. Or if you want to display <div> instead of <a> - you can
	   do it by applying your custom schema - bbcode library is fully customizable.

	*/
	cout << bbparser.current_tag_schema();

	//starting up
	/*
		I've built bbcodelib with XSS issues in mind. It shouldn't allow you any fun with javascript|quotes|colons.
		There is so many ways to fool j a v a sript: tag checker that bbcode deals with	it very hard.
		This is true for some cases like [a]link[/a] where a simple insertion of [a]javascript:alert();[/a]
		can be the source of troubles.
		
	*/
	bbparser.parse();

	//Displaying content
	cout << bbparser.content();
	
	}catch(exception &ex){
		std::cerr << string("Exception: ") + ex.what() << std::endl;
	}

	return 0;
}

//----------------------------------------------------------
//file_size
long file_size(ifstream& ios){
  ios.seekg(0, ifstream::end);
  long sz = ios.tellg();  
  ios.seekg(0,ifstream::beg);
  return sz;
}

//----------------------------------------------------------
//load_file
string load_file(const string& f){	
	string buf;
	
	ifstream in(f.c_str(),ios_base::binary);
	if(!in.good()) throw runtime_error("bad file name " + f);	
	 
	long sz = file_size(in);
	char* cbuf = new char[sz];
	try{
		in.read(cbuf, sz);	
		in.close();	
		buf.insert(0,cbuf,sz);
	}catch(exception ex){
		delete[] cbuf;
		throw ex;
	}
	delete[] cbuf;
	return buf;
}
