//
//  ZLYKVONotifying_Person.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "ZLYKVONotifying_Person.h"
#import <objc/runtime.h>
extern NSString *const observerKey;
@implementation ZLYKVONotifying_Person
-(void)setName:(NSString *)name
{
  
    [super setName:name];
    
    //把Person的isa指针指向ZLYKVONotifying_Person这个类,调用person的setName方法就会在此处调用
    
    //根据key获取保存的Person
 id observer = objc_getAssociatedObject(self, observerKey);
    //通知控制器值得变化
    [observer observeValueForKeyPath:@"name" ofObject:self change:nil context:nil];
}
@end
