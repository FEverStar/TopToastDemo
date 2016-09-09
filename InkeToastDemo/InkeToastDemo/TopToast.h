//
//  VVLiveToast.h
//  vvlive
//
//  Created by L on 16/6/15.
//  Copyright © 2016年 vvlive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TopToast : NSObject

+ (void)showToptoastWithText:(NSString *)text;
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration;
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height;
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height backGroundColor:(UIColor *)color;
+ (void)showToptoastWithText:(NSString *)text duration:(CGFloat)duration height:(float)height backGroundColor:(UIColor *)color alpha:(float)alpha;

@end
