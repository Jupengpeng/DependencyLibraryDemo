//
//  ViewController.m
//  DependencyLibraryDemo
//
//  Created by yintao on 2016/11/15.
//  Copyright © 2016年 yintao. All rights reserved.
//

#import "ViewController.h"
#import <ChenEasonLib/ChenEasonLib.h>
#import <SonyMp3PlayerLib/SonyMp3PlayerLib.h>
@interface ViewController ()
{
    BOOL _havePlayer;
    BOOL _songHasBeenSung;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    ChenEasonObject *chen = [[ChenEasonObject alloc] init];
    _songHasBeenSung = [chen singASongCalledTaoTai];
    
    SonyMp3Player *player= [[SonyMp3Player alloc] init];
    _havePlayer = [player isMyPlayer];

    if (_havePlayer && _songHasBeenSung) {
        
        NSLog(@"播放器播放《淘汰》了");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
