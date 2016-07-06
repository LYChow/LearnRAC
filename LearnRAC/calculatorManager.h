//
//  calculatorManager.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculatorManager : NSObject
@property(nonatomic,assign)int result;

-(instancetype)calculator:(int (^)(int))block;
@end
