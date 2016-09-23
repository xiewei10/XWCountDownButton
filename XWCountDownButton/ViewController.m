//
//  ViewController.m
//  XWCountDownButton
//
//  Created by 谢威 on 16/9/23.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "ViewController.h"
#import "XWCountDownButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XWCountDownButton *btn = [XWCountDownButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(10, 100, 100, 30);
    // 时间
    btn.totalSecond = 30;
    
    // 正常的颜色
    btn.nomalBackgroundColor = [UIColor redColor];
    // 读取的颜色
    btn.disableBackColor = [UIColor grayColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    
    // 下面动画的layer的颜色
    btn.animationColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    // 开始读秒
    [btn startCountDown];
    // 回调
    [btn getCountDownProgress:^(NSInteger second) {
        
        btn.title = [NSString stringWithFormat:@"正在获取%ld秒", second] ;
        
        
    } complet:^{
        btn.title = @"获取验证码";
        
    }];
    

    

    
    
}



@end
