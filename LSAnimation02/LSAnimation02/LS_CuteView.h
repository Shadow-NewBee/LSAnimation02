//
//  LS_CuteView.h
//  LSLearnAni03
//
//  Created by xiaoT on 16/4/3.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LS_CuteView : UIView

-(instancetype)initWithPoint:(CGPoint)point inSuperView:(UIView *)view;

-(void)setUp;

@property (nonatomic, strong) UIView *frontView;

@property (nonatomic, strong) UILabel *bubbleLabel;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) CGFloat bubbleWidth;

@property (nonatomic,assign)CGFloat viscosity;

@property (nonatomic, strong) UIColor *bubbleColor;



@end
