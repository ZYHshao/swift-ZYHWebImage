//
//  ZYHWebImageChcheCenter.swift
//  SwiftMovie
//
//  Created by apple on 15-6-25.
//  Copyright (c) 2015年 wutong. All rights reserved.
//

import UIKit
class ZYHWebImageChcheCenter: NSObject {
    class func readCacheFromUrl(url:NSString)->NSData?{
        var data:NSData?
        var path:NSString=ZYHWebImageChcheCenter.getFullCachePathFromUrl(url)
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            data=NSData.dataWithContentsOfMappedFile(path) as? NSData
        }
        return data
    }
    
    class func writeCacheToUrl(url:NSString, data:NSData){
        var path:NSString=ZYHWebImageChcheCenter.getFullCachePathFromUrl(url)
       println(data.writeToFile(path, atomically: true))
    }
    //设置缓存路径
    class func getFullCachePathFromUrl(url:NSString)->NSString{
        var chchePath=NSHomeDirectory().stringByAppendingString("/Library/Caches/MyCache")
        var fileManager:NSFileManager=NSFileManager.defaultManager()
        fileManager.fileExistsAtPath(chchePath)
        if !(fileManager.fileExistsAtPath(chchePath)) {
            fileManager.createDirectoryAtPath(chchePath, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
        //进行字符串处理
        var newURL:NSString
        newURL=ZYHWebImageChcheCenter.stringToZYHString(url)
        chchePath=chchePath.stringByAppendingFormat("/%@", newURL)
        return chchePath
    }
    //删除缓存
    class func removeAllCache(){
        var chchePath=NSHomeDirectory().stringByAppendingString("/Library/Caches/MyCache")
        var fileManager:NSFileManager=NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(chchePath) {
            fileManager.removeItemAtPath(chchePath, error: nil)
        }
        
    }
    class func stringToZYHString(str:NSString)->NSString{
        var newStr:NSMutableString=NSMutableString()
        for var i:NSInteger=0; i < str.length; i++ {
            var c:unichar=str.characterAtIndex(i)
            if (c>=48&&c<=57)||(c>=65&&c<=90)||(c>=97&&c<=122){
                newStr.appendFormat("%c", c)
            }
        }
        return newStr.copy() as NSString
        
    }
}
