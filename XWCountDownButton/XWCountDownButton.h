//
//  XWCountDownButton.h
//  HQ
//
//  Created by 谢威 on 16/9/23.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^countDownProgress)(NSInteger  second);

typedef void(^complet)(void);

/**
 *  倒计时的按钮 在XIB,SB,或者是在代码中创建Button的时候,Button的样式要设置成为 Custom 样式,否则在倒计时过程中 Button 的Tittle 会闪动.
 */
@interface XWCountDownButton : UIButton
/**
 *  正常状态下的颜色
 */
@property (nonatomic,strong)UIColor     *nomalBackgroundColor;
/**
 *  失效状态下的颜色
 */
@property (nonatomic,strong)UIColor     *disableBackColor;
/**
 *  下面进度条的颜色
 */
@property (nonatomic,strong)UIColor     *animationColor;


@property (nonatomic,copy)NSString      *title;

/**
 *  总时间 必须设置
 */
@property (nonatomic, assign) NSUInteger totalSecond;
/**
 *  获取进度
 *
 *  @param progress
 *  @param compled  
 */
- (void)getCountDownProgress:(countDownProgress)progress complet:(complet)compled;
/**
 *  开始倒计时
 */
- (void)startCountDown;



@end
