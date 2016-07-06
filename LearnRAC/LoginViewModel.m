//
//  LoginViewModel.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/6/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
-(instancetype)init
{
    if (self = [super init]) {
        [self setUp];
        [self requestData];
    }
    return self;
}

-(void)setUp
{
    _loginSignal =[RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];

    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //执行命令就会调用,点击登录按钮时执行命令
        
        NSLog(@"点击登陆按钮");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //增加一个延迟的效果
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //发送请求
                [subscriber sendNext:@"请求到的接口中的数据"];
                
                //发送完成
                [subscriber sendCompleted];
                
            });
            return nil;
        }];
    }];
    
    
    // 3.处理登录请求返回的结果
    [_command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 4.处理登录执行过程
    [[_command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在登录ing.."];
            
        }else{
            // 执行完成
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            
            NSLog(@"执行完成");
        }
        
    }];

    
}

-(void)requestData
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            //请求数据,请求导数据之后传出去
            
            AFHTTPSessionManager *mgr =[AFHTTPSessionManager manager];
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //把请求到的数据发送出去
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            return nil;
        }];
    }];
    
}

@end
