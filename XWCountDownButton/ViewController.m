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

@property (nonatomic,strong)XWCountDownButton *btn ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XWCountDownButton *btn = [XWCountDownButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(10, 100, 100, 40);
    // 时间
    btn.totalSecond = 10;
    
    // 正常的颜色
    btn.nomalBackgroundColor = [UIColor redColor];
    // 读取的颜色
    btn.disableBackColor = [UIColor grayColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    btn.title = @"获取验证码";
    [self.view addSubview:btn];

    // 下面动画的layer的颜色
    btn.animationColor = [UIColor redColor];
    [btn addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    // 第二个
    XWCountDownButton *btn2 = [XWCountDownButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(10, 200, 100, 40);
    // 时间
    btn2.totalSecond = 10;
    
    // 正常的颜色
    btn2.nomalBackgroundColor = [UIColor redColor];
    // 读取的颜色
    btn2.disableBackColor = [UIColor grayColor];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    btn2.layer.cornerRadius = 8;
    btn2.layer.masksToBounds = YES;
    btn2.title = @"获取验证码";
    [self.view addSubview:btn2];
    
    // 下面动画的layer的颜色
    btn2.animationColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(two:) forControlEvents:UIControlEventTouchUpInside];

    
    

    
}
- (void)one:(XWCountDownButton *)sender{
    
    // 开始读秒
    [sender startCountDownWithType:animationTypeWave];
    // 回调
    [sender getCountDownProgress:^(NSInteger second) {
        
        sender.title = [NSString stringWithFormat:@"请等待%ld秒", second] ;
        
    } complet:^{
        sender.title = @"获取验证码";
        
    }];

    
    
}
- (void)two:(XWCountDownButton *)sender{
    // 下面动画的layer的颜色
    sender.animationColor = [UIColor whiteColor];
    // 开始读秒
    [sender startCountDownWithType:animationTypeCirecle];
    // 回调
    [sender getCountDownProgress:^(NSInteger second) {
        
        sender.title = [NSString stringWithFormat:@"%ld秒", second] ;
        
        
    } complet:^{
        sender.title = @"获取验证码";
        
    }];

    
}




@end
