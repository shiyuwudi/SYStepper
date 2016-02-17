//
//  SYStepper.m
//  My_App
//
//  Created by shiyuwudi on 16/2/17.
//  Copyright © 2016年 shiyuwudi. All rights reserved.
//

#import "SYStepper.h"

@interface SYStepper ()

@property (weak, nonatomic) UITextField *textField;
@property (nonatomic, weak)UIView *superView;

@end

@implementation SYStepper

-(instancetype)initWithFrame:(CGRect)frame max:(NSInteger)max min:(NSInteger)min step:(NSInteger)step tintColor:(UIColor *)tint buttonWidth:(CGFloat)width superView:(UIView *)superView{
    if (self = [super initWithFrame:frame]) {
        
        _max = max;
        _min = min;
        _step = step;
        _superView = superView;
        
        CGColorRef tintColor = [tint CGColor];
        UIButton *decrementButton = [UIButton new];
        UIButton *incrementButton = [UIButton new];
        [self addSubview:decrementButton];
        [self addSubview:incrementButton];
        
        CGFloat buttonWidth = width;
        decrementButton.frame = CGRectMake(0, 0, buttonWidth * self.width, self.height);
        incrementButton.frame = CGRectMake(self.width - decrementButton.width, 0, buttonWidth * self.width, self.height);
        [decrementButton setTitle:@"-" forState:UIControlStateNormal];
        [incrementButton setTitle:@"+" forState:UIControlStateNormal];
        decrementButton.layer.borderColor = tintColor;
        incrementButton.layer.borderColor = tintColor;
        [decrementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [incrementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        decrementButton.layer.borderWidth = 1;
        incrementButton.layer.borderWidth = 1;
        decrementButton.layer.masksToBounds = YES;
        incrementButton.layer.masksToBounds = YES;
        [decrementButton addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
        [incrementButton addTarget:self action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
        decrementButton.backgroundColor = BACKGROUNDCOLOR;
        incrementButton.backgroundColor = BACKGROUNDCOLOR;
        self.layer.borderColor = tintColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        
        UITextField *textField = [[UITextField alloc]init];
        _textField = textField;
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenFrame.size.width, 44)];
        [topView setBarStyle:UIBarStyleBlack];
        UIBarButtonItem * space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        [topView setItems:@[space,doneButton]];
        textField.inputAccessoryView = topView;
        textField.frame = CGRectMake(decrementButton.right, 0, (1.0 - 2 * buttonWidth) * self.width, self.height);
        textField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textField];
        textField.text = [NSString stringWithFormat:@"%ld",(long)_min];
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}
+(NSString *)notifName{
    return @"syStepperNumberDidChangeNotification";
}
+(NSString *)keyForNumber{
    return @"keyForNumber";
}
+(NSString *)keyForSuperview{
    return @"I'm the pretty key of the damn super view!!ohoh!";
}
-(void)dismissKeyBoard {
    [_textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter]postNotificationName:[SYStepper notifName] object:self userInfo:[self userInfo]];
}
-(NSString *)toStr:(NSInteger)num {
    return [NSString stringWithFormat:@"%ld",(long)num];
}
-(NSDictionary *)userInfo{
    return @{
             [SYStepper keyForNumber]:_textField.text,
             [SYStepper keyForSuperview]:_superView
             };
}
-(void)decrease {
    NSString *text = _textField.text;
    NSInteger num = text.integerValue;
    if (num - _step >= _min) {
        _textField.text = [self toStr:num - _step];
        [[NSNotificationCenter defaultCenter]postNotificationName:[SYStepper notifName] object:self userInfo:[self userInfo]];
    }
}
-(void)increase {
    NSString *text = _textField.text;
    NSInteger num = text.integerValue;
    if (num + _step <= _max) {
        _textField.text = [self toStr:num + _step];
        [[NSNotificationCenter defaultCenter]postNotificationName:[SYStepper notifName] object:self userInfo:[self userInfo]];
    }
}

@end
