//
//  NSObject+Calculator.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calculatorMaker.h"
@interface NSObject (Calculator)

+(int)zly_makeCalculator:(void (^)(calculatorMaker *maker))block;

@end
