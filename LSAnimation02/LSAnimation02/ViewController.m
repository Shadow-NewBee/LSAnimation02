//
//  ViewController.m
//  LSLearnAni03
//
//  Created by xiaoT on 16/4/3.
//  Copyright © 2016年 赖三聘. All rights reserved.
//

#import "ViewController.h"
#import "LS_CuteView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    LS_CuteView *cuteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cuteView = [[LS_CuteView alloc] initWithPoint:self.view.center inSuperView:self.view];
    cuteView.viscosity = 20;
    cuteView.bubbleColor = [UIColor orangeColor];
    cuteView.bubbleWidth = 35;
    [cuteView setUp];
    
    cuteView.bubbleLabel.text = @"3";
    cuteView.frontView.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
