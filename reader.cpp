//
//  reader.cpp
//  BinTest
//
//  Created by Will on 2018/12/20.
//  Copyright © 2018 Will. All rights reserved.
//

#include "reader.hpp"
#include <iostream>
#include <fstream>
#include <stdio.h>

using namespace std;

int readTool::readBin(const char *path,float *s)
{

    std::ifstream inFile(path, ios::in | ios::binary); //二进制读方式打开
    if (!inFile) {
        cout << "error" << endl;
        return -1;
    }
    int i = 0;
    
    
    char a[4];
    char b[4];
    
    while(inFile.read(a, sizeof(a)))
    {
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        float value;
        
        memcpy(&value, b, sizeof(b));
//        cout<<value<<endl;
        
        s[i] = value;
        i ++;
    }
    
//    while (inFile.read(( char *)&s[i], sizeof(float))) { //一直读到文件结束
        //cout << readedBytes << endl;
//        i++;
//    }
//    cout << i << endl;
    inFile.close();

    return 0;
}


void readTool::writeFile(const char *path,float *s){
    ofstream ofs;
    ofs.open(path, ios::out | ios::app | ios::binary); //输出到文件 ，追加的方式，二进制。 可同时用其他的工具打开此文件
    if (!ofs.is_open())return; //打开文件失败则结束运行
    for (int i = 0; i < 256; i++)
    {
        float buffer = s[i];
        char a[4];
        char b[4];
        memcpy(&a[0], &buffer, sizeof(buffer));
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        
        ofs.write((char*)&b[0], sizeof(buffer));
        ofs.flush();
    }
    
    ofs.close();
}


   
//采用CPP模式写二进制文件
void readTool:: DataWrite_CPPMode(const char *path,float *s)
{
    //写出数据
    ofstream f(path,ios::binary);
    if(!f)
    {
        cout << "创建文件失败" <<endl;
        return;
    }
    f.write((char*)&s[0], sizeof(float)*256);      //fwrite以char *的方式进行写出，做一个转化
    f.close();
}

//采用CPP模式读二进制文件
void readTool:: DataRead_CPPMode(const char *path,float *s)
{
    ifstream f(path, ios::binary);
    if(!f)
    {
        cout << "读取文件失败" <<endl;
        return;
    }
    f.read((char*)&s[0],sizeof(float)*256);
    
    f.close();
    
}

