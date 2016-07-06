//
//  SecondViewController.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/3/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SecondViewController : UIViewController

@property(nonatomic,strong) RACSubject *delegateSubject;
@end
