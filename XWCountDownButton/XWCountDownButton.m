//
//  XWCountDownButton.m
//  HQ
//
//  Created by 谢威 on 16/9/23.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWCountDownButton.h"

@interface XWCountDownButton ()

@property (nonatomic,strong)NSTimer         *timer;
@property (nonatomic,copy)countDownProgress counProgress;
@property (nonatomic,copy)complet           finished;

@property (nonatomic, assign)NSUInteger    second;
@property (nonatomic,assign)NSInteger       originalTime;
@property (nonatomic,strong)CAShapeLayer    *layerss;

@end



@implementation XWCountDownButton


- (CAShapeLayer *)layerss{
    if (!_layerss ) {
        _layerss = [CAShapeLayer layer];
        _layerss.fillColor = [UIColor clearColor].CGColor;
        _layerss.strokeColor = self.animationColor.CGColor?self.animationColor.CGColor:[UIColor whiteColor].CGColor;
        _layerss.lineWidth = self.frame.size.height;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0,self.frame.size.height/2)];
        [path addLineToPoint:CGPointMake(self.frame.size.width,self.frame.size.height/2)];
        _layerss.path = path.CGPath;
        _layerss.strokeEnd=0.f;
       
        
    }
    return _layerss;
}

- (void)getCountDownProgress:(countDownProgress)progress complet:(complet)compled{
    self.counProgress =[progress copy];
    self.finished = [compled copy];
    
    
}
- (void)startCountDown{
    self.userInteractionEnabled = NO;
    self.second = self.totalSecond;
    self.backgroundColor = self.disableBackColor?self.disableBackColor:self.nomalBackgroundColor;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    

    
    
}

- (void)timerFire{
    
    CGFloat now = self.originalTime-(--self.second) *1.0;
    CGFloat progress = now / self.originalTime;
    // 这里动画
    [self.layer addSublayer:self.layerss];
    self.layerss.strokeEnd = progress;
    // 一定要把lable 放在layer的上面
    [self bringSubviewToFront:self.titleLabel];
    
    // 传递block出去
    self.counProgress?self.counProgress(self.second):self.originalTime;
    if (self.second<=0) {
        self.finished();
        if (self.timer) {
            if ([self.timer respondsToSelector:@selector(isValid)]){
                if ([self.timer isValid]){
                    [self.timer invalidate];
                    self.second = self.totalSecond;
                    self.userInteractionEnabled = YES;
                    self.backgroundColor = self.nomalBackgroundColor;
                    [self.layerss removeAllAnimations];
                    [self.layerss removeFromSuperlayer];
                    self.layerss.strokeEnd = 0;
                }
            }
        }

    }
    
}



- (void)setNomalBackgroundColor:(UIColor *)nomalBackgroundColor{
    _nomalBackgroundColor = nomalBackgroundColor;
    [self setBackgroundColor:nomalBackgroundColor];
}

- (void)setDisableBackColor:(UIColor *)disableBackColor{
    _disableBackColor = disableBackColor;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
    
}
- (void)setTotalSecond:(NSUInteger)totalSecond{
    _totalSecond = totalSecond;
    self.originalTime = _totalSecond;

}
- (void)setAnimationColor:(UIColor *)animationColor{
    _animationColor = animationColor;
}






@end
