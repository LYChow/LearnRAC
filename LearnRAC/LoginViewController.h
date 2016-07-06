//
//  LoginViewController.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/6/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end
