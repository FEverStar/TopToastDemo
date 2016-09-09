//
//  VVLiveToast.m
//  vvlive
//
//  Created by L on 16/6/15.
//  Copyright © 2016年 vvlive. All rights reserved.
//

#import "TopToast.h"
//默认停留时间
#define ToastDispalyDuration 2.0f
//默认背景色
#define ToastBackgroundColor [UIColor purpleColor]
//默认高度
#define ToastHeight 64

@interface TopToast ()
@property (nonatomic, strong) UIButton *contentView;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat height;
@end

@implementation TopToast

//多次点击缓存，逐个显示
static NSMutableArray *_toastArr;

- (void)dealloc{
    NSLog(@"VVLiveToast dealloc");
}

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        _duration = ToastDispalyDuration;
        _height = ToastHeight;
        if (_toastArr.count == 0) {
            _toastArr = [[NSMutableArray alloc]init];
        }
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, -_height, [UIScreen mainScreen].bounds.size.width, _height)];
        _contentView.backgroundColor = ToastBackgroundColor;
        [_contentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, _height)];
        textLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _height);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont boldSystemFontOfSize:15];
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        [_contentView addSubview:textLabel];
 
    }
    return self;
}
//设置停留时间
- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}
//设置背景色
- (void)setBackgroundColor:(UIColor *)color{
    _contentView.backgroundColor = color;
}
//设置高度
- (void)setHeigh:(float)height{
    _height = height;
}
//设置透明度
- (void)setBackgroundAlpha:(float)alpha{
    _contentView.alpha = alpha;
}
//出现动画
-(void)showAnimationWithToast:(TopToast *)toast{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    toast.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, toast.height);
    [UIView commitAnimations];
}
//影藏动画
-(void)hideAnimationWithToast:(TopToast *)toast{
    [UIView animateWithDuration:0.3 animations:^{
        toast.contentView.frame = CGRectMake(0, -toast.height, [UIScreen mainScreen].bounds.size.width, toast.height);
    } completion:^(BOOL finished) {
        [toast.contentView removeFromSuperview];
        //影藏后检查是否有toast缓存
        if (_toastArr.count > 0) {
            [_toastArr removeObjectAtIndex:0];
            if (_toastArr.count > 0) {
                [self showWithToast:_toastArr[0]];
            }
        }
    }];
}
//触摸隐藏
- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, -_height, [UIScreen mainScreen].bounds.size.width, _height);
    }completion:^(BOOL finished) {
        [_contentView removeFromSuperview];
    }];
}

- (void)showWithToast:(TopToast *)toast{
    [[UIApplication sharedApplication].keyWindow addSubview:toast.contentView];
    [self showAnimationWithToast:toast];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self hideAnimationWithToast:toast];
    });
}

+ (void)showToptoastWithText:(NSString *)text{
    TopToast *toast = [[TopToast alloc] initWithText:text];
    [toast setDuration:ToastDispalyDuration];
    if (_toastArr.count == 0) {
        [toast showWithToast:toast];
    }
    [_toastArr addObject:toast];
}
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration{
    TopToast *toast = [[TopToast alloc] initWithText:text];
    if (_toastArr.count == 0) {
        [toast showWithToast:toast];
    }
    [_toastArr addObject:toast];
}
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height{
    TopToast *toast = [[TopToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast setHeigh:height];
    if (_toastArr.count == 0) {
        [toast showWithToast:toast];
    }
    [_toastArr addObject:toast];
}
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height backGroundColor:(UIColor *)color{
    TopToast *toast = [[TopToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast setHeigh:height];
    [toast setBackgroundColor:color];
    if (_toastArr.count == 0) {
        [toast showWithToast:toast];
    }
    [_toastArr addObject:toast];
}
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height backGroundColor:(UIColor *)color alpha:(float)alpha{
    TopToast *toast = [[TopToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast setHeigh:height];
    [toast setBackgroundColor:color];
    [toast setBackgroundAlpha:alpha];
    
    if (_toastArr.count == 0) {
        [toast showWithToast:toast];
    }
    [_toastArr addObject:toast];
    
}

@end
