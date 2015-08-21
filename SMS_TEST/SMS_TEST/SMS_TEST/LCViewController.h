//
//  LCViewController.h
//  SMS_TEST
//
//  Created by LcGero on 15/8/17.
//  Copyright (c) 2015年 LcGero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
