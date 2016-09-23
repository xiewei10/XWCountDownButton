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

@property (nonatomic,strong)CAShapeLayer    *circleLayer;
/**
 *  原来的frame
 */
@property (nonatomic,assign)CGRect      origialFrame;

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

- (CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = self.animationColor.CGColor?self.animationColor.CGColor:[UIColor blackColor].CGColor;
        _circleLayer.lineWidth = 1;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:(self.frame.size.height/2)-3 startAngle:3*M_PI/2 endAngle:7*M_PI/2 clockwise:YES];
        _circleLayer.path = path.CGPath;
        _circleLayer.strokeEnd = 0.f;
    }
    return _circleLayer;
    
}




- (void)getCountDownProgress:(countDownProgress)progress complet:(complet)compled{
    self.counProgress =[progress copy];
    self.finished = [compled copy];
    
    
}
- (void)startCountDownWithType:(animationType)type{
    self.origialFrame = self.frame;
    if (type == animationTypeWave) {
        self.userInteractionEnabled = NO;
        self.second = self.totalSecond;
        self.backgroundColor = self.disableBackColor?self.disableBackColor:self.nomalBackgroundColor;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }else{
        [self circleAnimation];
    }

    
    
}

- (void)circleAnimation{
    CGFloat H = self.frame.size.height;
    // 先变成圆圈
   [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
            self.bounds = CGRectMake(0, 0, H, H);
        }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
            self.layer.cornerRadius = H/2;
        }];
       [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
          
       }];
    
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = NO;
        self.second = self.totalSecond;
        self.backgroundColor = self.disableBackColor?self.disableBackColor:self.nomalBackgroundColor;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CirceletimerFire) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];

    }];
    

}
#pragma mark -- 转圈动画
- (void)CirceletimerFire{
    CGFloat now = self.originalTime-(--self.second) *1.0;
    CGFloat progress = now / self.originalTime;
    // 这里动画
    [self.layer addSublayer:self.circleLayer];
    self.circleLayer.strokeEnd = progress;
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
                    [self.circleLayer removeAllAnimations];
                    [self.circleLayer removeFromSuperlayer];
                    self.circleLayer.strokeEnd = 0;
                    // 这里要将自身变回原来的frame
                    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                            self.bounds = CGRectMake(0, 0,self.origialFrame.size.width,self.origialFrame.size.height);
                        }];
                        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                            self.layer.cornerRadius =8;
                        }];
                        
                    } completion:^(BOOL finished) {
                }];

                    
                }
            }
        }
        
    }
    
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
