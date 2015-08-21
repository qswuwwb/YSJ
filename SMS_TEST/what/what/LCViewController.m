//
//  LCViewController.m
//  what
//
//  Created by LcGero on 15/8/18.
//  Copyright (c) 2015年 LcGero. All rights reserved.
//

#import "LCViewController.h"
#import "SMS_HYZBadgeView.h"

@interface LCViewController ()

@end

@implementation LCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SMS_HYZBadgeView *badgeView = [[SMS_HYZBadgeView alloc] init];
   
    [badgeView setNumber:1111222];
    badgeView.center = CGPointMake(100, 100);
    [self.view addSubview:badgeView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
