//
//  SYStepper.h
//  My_App
//
//  Created by shiyuwudi on 16/2/17.
//  Copyright © 2016年 shiyuwudi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYStepper : UIView

-(instancetype)initWithFrame:(CGRect)frame max:(NSInteger)max min:(NSInteger)min step:(NSInteger)step tintColor:(UIColor *)tint buttonWidth:(CGFloat)width superView:(UIView *)superView;

@property (nonatomic, assign)NSInteger max;
@property (nonatomic, assign)NSInteger min;
@property (nonatomic, assign)NSInteger step;

+(NSString *)notifName;
+(NSString *)keyForNumber;
+(NSString *)keyForSuperview;

@end
