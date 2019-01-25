//
//  reader.hpp
//  BinTest
//
//  Created by Will on 2018/12/20.
//  Copyright © 2018 Will. All rights reserved.
//

#ifndef reader_hpp
#define reader_hpp
#include <vector>
#include <stdio.h>
class readTool{
public:
    static int readBin(const char * path,float *s);

    static void writeFile(const char *path,float *s);
    static void writeBin(const char *path ,float *s);
    static void DataWrite_CPPMode(const char *path,float *s);
    static void DataRead_CPPMode(const char *path,float *s);
};
#endif /* reader_hpp */
