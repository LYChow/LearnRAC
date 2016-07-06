//
//  calculatorMaker.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculatorMaker : NSObject
@property(nonatomic,assign) int result;

-(instancetype)add:(int)value;

-(calculatorMaker *(^)(int))add;
-(calculatorMaker *(^)(int))minus;
-(calculatorMaker *(^)(int))mutip;
-(calculatorMaker *(^)(int))divide;




@end
