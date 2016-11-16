//
//  ChenEasonObject.m
//  ChenEasonLib
//
//  Created by yintao on 2016/11/15.
//  Copyright © 2016年 yintao. All rights reserved.
//

#import "ChenEasonObject.h"
#import "ZhouJielunObject.h"
#import "LinXiObject.h"

@interface ChenEasonObject ()
{
    BOOL _songWrited;
    BOOL _lyricWrited;
}

@end
@implementation ChenEasonObject

- (BOOL)singASongCalledTaoTai{
    
    
    ZhouJielunObject *zhou = [[ZhouJielunObject alloc] init];
    _songWrited =[zhou WritingSongOfTaoTai];
    
    LinXiObject *lin = [[LinXiObject alloc] init];
    _lyricWrited = [lin WritingLyricsOfTaoTai];
    
    
    if (_songWrited && _lyricWrited) {
        NSLog(@"陈奕迅演唱了《淘汰》");
        return YES;

    }else{
        return NO;
    }
}


@end
