//
//  NSObject+KVO.h
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)
- (void)zly_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
