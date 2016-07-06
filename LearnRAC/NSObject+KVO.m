//
//  NSObject+KVO.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "NSObject+KVO.h"
#import "ZLYKVONotifying_Person.h"
#import <objc/runtime.h>
NSString *const observerKey =@"observer";
@implementation NSObject (KVO)
- (void)zly_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{

    //把observer的isa指针指向ZLYKVONotifying_Person
    
    //把observer对象保存到self中
    objc_setAssociatedObject(self, (__bridge const void *)(observerKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //修改self的isa指针
    object_setClass(self, [ZLYKVONotifying_Person class]);
}

@end
