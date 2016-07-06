//
//  calculatorManager.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "calculatorManager.h"

@implementation calculatorManager
-(instancetype)calculator:(int (^)(int))block
{
    _result = block(_result);
    return self;
}
@end
