//
//  LS_CuteView.m
//  LSLearnAni03
//
//  Created by xiaoT on 16/4/3.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "LS_CuteView.h"



@implementation LS_CuteView
{
    UIView *backView;
    UIColor *fillColorForCute;
    UIBezierPath *cutePath;
    UIBezierPath *returnPath;

    CGFloat r1;
    CGFloat r2;
    CGFloat centerDistance;
    CGFloat cosDigree;
    CGFloat sinDigree;
    CGFloat x1;
    CGFloat y1;
    CGFloat x2;
    CGFloat y2;
    
    
    CGPoint pointA; //A
    CGPoint pointB; //B
    CGPoint pointD; //D
    CGPoint pointC; //C
    CGPoint pointO; //O
    CGPoint pointP; //P
    
    CGRect oldBackViewFrame;
    CGPoint initialPoint;
    CGPoint oldBackViewCenter;
    
    CAShapeLayer *shapeLayer;
}

-(instancetype)initWithPoint:(CGPoint)point inSuperView:(UIView *)view
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, self.bubbleWidth, self.bubbleWidth)];
    if (self) {
        [self setUp];
        initialPoint = point;
        self.containerView = view;
        [self.containerView addSubview:self];
    }
    
    return self;
}

-(void)drawRect
{
    x1 = backView.center.x;
    y1 = backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    centerDistance = sqrtf((x2 - x1)*(x2 - x1) + (y2 - y1) * (y2 - y1));
    if (centerDistance == 0) {
        cosDigree = 1;
        sinDigree = 0;
    } else {
        cosDigree = (y1 - y2) / centerDistance;
        sinDigree = (x2 - x1) / centerDistance;
    }
    r1 = oldBackViewFrame.size.width / 2 - centerDistance / self.viscosity;
    
     pointA = CGPointMake(x1 - r1 * cosDigree, y1 - r1 * sinDigree);
     pointB = CGPointMake(x1 + r1 * cosDigree, y1 + r1 * sinDigree);
     pointC = CGPointMake(x2 + r2 * cosDigree, y2 + r2 * sinDigree);
     pointD = CGPointMake(x2 - r2 * cosDigree, y2 - r2 * sinDigree);
     pointO = CGPointMake(pointA.x + (centerDistance / 2) * sinDigree, pointA.y - (centerDistance / 2) * cosDigree);
     pointP = CGPointMake(pointB.x + (centerDistance / 2)*sinDigree, pointB.y - (centerDistance / 2)*cosDigree);
    
    backView.center = oldBackViewCenter;
    backView.bounds = CGRectMake(0, 0, r1 * 2, r1 * 2);
    backView.layer.cornerRadius = r1;
    
    cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath closePath];
    
    if (backView.hidden == NO) {
        shapeLayer.path = cutePath.CGPath;
        shapeLayer.fillColor = [self.bubbleColor CGColor];
        [self.containerView.layer insertSublayer:shapeLayer below:self.frontView.layer];
    }
    
}

-(void)setUp
{
    shapeLayer = [CAShapeLayer layer];
    self.backgroundColor = [UIColor clearColor];

    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(initialPoint.x, initialPoint.y, self.bubbleWidth, self.bubbleWidth)];
    r2 = self.frontView.bounds.size.width/2;
    self.frontView.layer.cornerRadius = r2;
    self.frontView.backgroundColor = self.bubbleColor;
    
    backView = [[UIView alloc] initWithFrame:self.frontView.frame];
    backView.backgroundColor = self.bubbleColor;
    r1 = backView.bounds.size.width/2;
    backView.layer.cornerRadius = r1;
    
    self.bubbleLabel = [[UILabel alloc] init];
    self.bubbleLabel.frame = CGRectMake(0, 0, self.frontView.bounds.size.width, self.frontView.bounds.size.height);
    self.bubbleLabel.textColor = [UIColor whiteColor];
    self.bubbleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.frontView addSubview:self.bubbleLabel];
    
    [self.containerView addSubview:backView];
    [self.containerView addSubview:self.frontView];
    
    oldBackViewFrame = backView.frame;
    oldBackViewCenter = backView.center;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGes:)];
    [self.frontView addGestureRecognizer:panGesture];
    
}

-(void)handlePanGes:(UIPanGestureRecognizer *)gesture
{
    CGPoint dragPoint = [gesture locationInView:self.containerView];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        fillColorForCute = self.bubbleColor;
        backView.hidden = NO;
    } else if (gesture.state == UIGestureRecognizerStateChanged){
        self.frontView.center = dragPoint;
        [self drawRect];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateFailed) {
        backView.hidden = YES;
        fillColorForCute = [UIColor clearColor];
        [shapeLayer removeFromSuperlayer];
    

        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frontView.center = oldBackViewCenter;
        } completion:^(BOOL finished) {
            
        }];
    }
}


@end
