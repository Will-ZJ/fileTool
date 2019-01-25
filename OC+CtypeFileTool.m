//
//  OC+CtypeFileTool.m
//  PaAccessControl
//
//  Created by administrator on 2019/1/25.
//  Copyright © 2019 Will. All rights reserved.
//

#import "OC+CtypeFileTool.h"

@implementation OC_CtypeFileTool
- (NSArray *)OCreadInBigWithPath:(NSString *)path{
    //    NSData *data = [NSData dataWithContentsOfFile:path];
    NSFileHandle *fileHandle = [NSFileHandle  fileHandleForReadingAtPath:path];
    if (fileHandle == nil){
        return nil;
    }
    NSData *data = [fileHandle readDataToEndOfFile];
    
    //    float temp[256];
    NSMutableArray *M_arr = [NSMutableArray array];
    for (int i = 0; i < 256; i ++) {
        
        char a[4];
        char b[4];
        [data getBytes:&a[0] range:NSMakeRange(i*4, 4)];
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        float value;
        memcpy(&value, b, sizeof(b));
        [M_arr addObject:[NSNumber numberWithFloat:value]];
        
        
    }
    [fileHandle closeFile];
    return M_arr.copy;
}
- (NSArray *)OCreadInLittleWithPath:(NSString *)path {
    
    
    NSFileHandle *fileHandle = [NSFileHandle  fileHandleForReadingAtPath:path];
    if (fileHandle == nil){
        return nil;
    }
    NSData *data = [fileHandle readDataToEndOfFile];
    float s[256];
    [data getBytes:&s[0] length:sizeof(s)];
    
    NSMutableArray *m_arr = [NSMutableArray array];
    for (int i = 0; i < 256; i ++) {
        NSNumber *temp = [NSNumber numberWithFloat:s[i]];
        [m_arr addObject:temp];
    }
    [fileHandle closeFile];
    return m_arr.copy;
    
}
- (void)OCwriteInLittleWithPath:(NSString *)path floatArr:(float *)floatArr{
    
    NSMutableData *m_data = [NSMutableData data];
    [m_data appendBytes:&floatArr[0] length:sizeof(floatArr)];
    
    [m_data.copy writeToFile:path atomically:NO];
    
}

- (BOOL)OCwriteInBigWithPath:(NSString *)path content:(NSArray *)features{
    
    
    NSMutableData *m_data = [NSMutableData data];
    
    for (int i = 0; i <features.count; i ++) {
        
        float temp = [features[i] floatValue];
        char a[4];
        char b[4];
        memcpy(&a[0], &temp, sizeof(temp));
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        [m_data appendBytes:&b[0] length:sizeof(temp)];
        
    }
    
    return [m_data.copy writeToFile:path atomically:YES];
}
void WriteBINFile_C(const char *path,float *contentArr)
{
    FILE* fp = fopen(path,"wb");
    if (fp == NULL){
        return;
    }
    for (int i = 0; i < 256; i++)
    {
        float buffer = contentArr[i];
        char a[4];
        char b[4];
        memcpy(&a[0], &buffer, sizeof(buffer));
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        
        fwrite((char*)&b[0], sizeof(buffer), 1, fp);
    }
    fclose(fp);
}
NSArray * CReadBINFile_InBig(const char *path)
{
    
    FILE* fp = fopen(path,"rt");
    if(fp == NULL){
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 256; i++) {
        char a[4];
        char b[4];
        fread(&a[0], sizeof(a), 1, fp);
        
        b[0] = a[3];
        b[1] = a[2];
        b[2] = a[1];
        b[3] = a[0];
        float value;
        memcpy(&value, b, sizeof(b));
        //        contentArr[i] = value;
        [arr addObject:[NSNumber numberWithFloat:value]];
        
    }
    
    fclose(fp);
    return arr.copy;
}
void  CReadBINFile_InLittel(const char *path,float *floatarr){
    FILE* fp = fopen(path,"rb");
    if(fp == NULL){
        return ;
    }
    
    fread(&floatarr[0], 1024, 1, fp);
    fclose(fp);
}
void CWriteBINFile_inLitle(const char *path,float *contentArr)
{
    FILE* fp = fopen(path,"wb");
    if (fp == NULL){
        return;
    }
    fwrite((char*)&contentArr[0], sizeof(float)*256, 1, fp);
    
    fclose(fp);
}
@end
