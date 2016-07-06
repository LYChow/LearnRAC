//
//  LoginViewController.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/6/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+XMG.h"
#import "LoginViewModel.h"
@interface LoginViewController()
@property (nonatomic, strong) LoginViewModel *loginVM;
@end
@implementation LoginViewController

-(LoginViewModel *)loginVM
{
    if (_loginVM == nil) {
        _loginVM =[[LoginViewModel alloc] init];
    }
    return _loginVM;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM,account) = _accountTextField.rac_textSignal;
    RAC(self.loginVM,pwd) = _pwdTextField.rac_textSignal;
    
    
    //2.设置按钮是否可以点击
    RAC(_loginBtn,enabled) = self.loginVM.loginSignal;
    
    
    //3.监听登陆按钮的点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       //处理登录事件
        [self.loginVM.command execute:nil];
    }];
    
    [self requestData];
}

-(void)requestData
{
    [_loginVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"必须放在execute:方法之前才执行-网络请求的数据-%@",x);
    }];
    
    //获取信号中的信号请求的数据
    RACSignal *requestSignal = [_loginVM.requestCommand execute:nil];
    [requestSignal subscribeNext:^(id x) {
        NSLog(@"网络请求的数据---%@",x);
    }];
}



@end
