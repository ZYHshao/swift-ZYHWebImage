//
//  ZYHWebImage.swift
//  SwiftMovie
//
//  Created by apple on 15-6-24.
//  Copyright (c) 2015年 wutong. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /**
    *设置web图片
    *url:图片路径
    *defaultImage:默认缺省图片
    *isCache：是否进行缓存的读取
    */
    func setZYHWebImage(url:NSString?, defaultImage:NSString?, isCache:Bool){
        var ZYHImage:UIImage?
        if url == nil {
            return
        }
        //设置默认图片
        if defaultImage != nil {
            self.image=UIImage(named: defaultImage!)
        }
        
        if isCache {
            var data:NSData?=ZYHWebImageChcheCenter.readCacheFromUrl(url!)
            if data != nil {
                ZYHImage=UIImage(data: data!)
                self.image=ZYHImage
            }else{
               var dispath=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                dispatch_async(dispath, { () -> Void in
                    var URL:NSURL = NSURL(string: url!)!
                    var data:NSData?=NSData(contentsOfURL: URL)
                    if data != nil {
                        ZYHImage=UIImage(data: data!)
                        //写缓存
                        ZYHWebImageChcheCenter.writeCacheToUrl(url!, data: data!)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //刷新主UI
                            self.image=ZYHImage
                        })
                    }
                    
                })
            }
        }else{
            var dispath=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(dispath, { () -> Void in
                var URL:NSURL = NSURL(string: url!)!
                var data:NSData?=NSData(contentsOfURL: URL)
                if data != nil {
                    ZYHImage=UIImage(data: data!)
                    //写缓存
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //刷新主UI
                        self.image=ZYHImage
                    })
                }
                
            })
        }
    }
    
}