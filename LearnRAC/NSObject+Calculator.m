//
//  NSObject+Calculator.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "NSObject+Calculator.h"

@implementation NSObject (Calculator)

+(int)zly_makeCalculator:(void (^)(calculatorMaker *maker))block
{
    calculatorMaker *maker =[[calculatorMaker alloc] init];
    
    block(maker);
    
    return maker.result;
}

@end
