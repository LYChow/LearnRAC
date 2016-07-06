//
//  LoginViewModel.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/6/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+XMG.h"

@interface LoginViewModel : NSObject
@property(nonatomic,strong) NSString *account;
@property(nonatomic,strong) NSString *pwd;
@property(nonatomic,strong) RACSignal *loginSignal;
@property(nonatomic,strong) RACCommand  *command;
@property(nonatomic,strong) RACCommand *requestCommand;
@end
