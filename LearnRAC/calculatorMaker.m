//
//  calculatorMaker.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "calculatorMaker.h"

@implementation calculatorMaker


-(instancetype)add:(int)value
{
    self.result+= value;
    return self;
}


-(calculatorMaker *(^)(int))add
{
    return ^calculatorMaker *(int value){
        self.result+= value;
        return self;
    };
}

-(calculatorMaker *(^)(int))minus
{
    return ^calculatorMaker *(int value){
        self.result-= value;
        return self;
    };
}
-(calculatorMaker *(^)(int))mutip
{
    return ^calculatorMaker *(int value){
        self.result*= value;
        return self;
    };
}

-(calculatorMaker *(^)(int))divide
{
    return ^calculatorMaker *(int value){
        self.result/= value;
        return self;
    };
}

@end
