//
//  SecondViewController.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/3/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "SecondViewController.h"
#import "RedView.h"
@interface SecondViewController()
@property(nonatomic,strong) RedView *redView;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) RACSignal *signal;
@end
@implementation SecondViewController
-(void)viewDidLoad
{
    self.view.backgroundColor=[UIColor orangeColor];
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"dismissVC" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn=btn;
    
    RedView *redView=[RedView redView];
    [self.view addSubview:redView];
    _redView=redView;
    
//    self.view addSubview:[]
    //RACSubject的使用
//    [self RACSubject];
    
    //RACReplaySubject的使用
//    [self RACReplaySubject];
    
    //RACSequence的使用
//    [self RACSequence];
    
    //RACMulticastConnection的使用
//    [self RACMulticastConnection];
    
    //实用的几种用法
//    [self signalCommonsUses];
    
    //常见的宏
//    [self macroDefine];
    //信号绑定
    [_redView.textField.rac_textSignal bind:^RACStreamBindBlock{
      //绑定了一个信号
        return ^RACStream*(id value, BOOL *stop)
        {
            // 什么时候调用block:当信号有新的值发出，就会来到这个block。
            
            // block作用:做返回值的处理
            
            // 做好处理，通过信号返回出去.
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        };
    }];
    
    
}

-(void)macroDefine
{
    //给某个类的某个属性绑定一个信号,只要接收到信号,就改变这个类的属性
    //修改文本框的内容时,改变label的值
    RAC(_redView.labelView,text) = _redView.textField.rac_textSignal;
    
    //监听对象的某个属性转换成信号
    [RACObserve(_redView, center) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    @weakify(self); //将self弱引用
    RACSignal *signal =[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self); //保证self在block块内不被释放
        
        return nil;
    }];
    _signal = signal;
    
}

-(void)signalCommonsUses
{
    //1、代替代理,监听redView中按钮的点击情况
    [[_redView rac_signalForSelector:@selector(btnClick111:)] subscribeNext:^(id x) {
        NSLog(@"redView上的按钮被点击");
    }];
    
    //2.代替KVO,监听redView的Frame变化
    [[_redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"redView的frame变化了");
    }];
    
    //3.监听事件 把按钮点击事件转换成信号 点击按钮 就会发送信号
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"btn按钮被点击了");
    }];
    
    //4.代替通知,把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出来了");
    }];
    
    //5.监听textField内容的改变 把textField文字的改变作为一个信号
    [_redView.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"textField---%@",x);
    }];
    
    // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];

}

// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}


-(void)RACMulticastConnection
{
    // RACMulticastConnection:解决重复请求问题,只会调用一次
    RACSignal *signal =[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@"1"];
        return nil;
    }];
    
    //2.创建连接
    RACMulticastConnection *connect =[signal publish];
    
    //3.订阅信号也不能激活信号,只能保存到订阅者数组,只要调用连接才能一次性调用所有的sendNext
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者一信号");
        
    }];
    
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者二信号");
        
    }];
    
    //4.连接,激活信号
    [connect connect];

}



-(void)RACSequence
{
    NSArray *numbers = @[@1,@2,@3,@4];
    //1、把数组转成集合
    RACSequence *sequence =numbers.rac_sequence;
    //2、把集合转成信号类
    RACSignal *signal = sequence.signal;
    //3、订阅信号、激活信号，会自动把集合的所有值遍历出来
    [signal subscribeNext:^(id x) {
        NSLog(@"遍历集合--%@",x);
    }];
    
    NSArray *arr =@[@{@"name":@"zhou"},@{@"age":@25}];
    NSDictionary *dict = @{@"name":@"zhou",@"age":@25};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        NSLog(@"遍历字典--%@",x);
        //解包元组
        RACTupleUnpack(NSString *key,NSString *value)=x;
        NSLog(@"key--%@  value--%@",key,value);
    }];
    
    //高级用法
    [[arr.rac_sequence map:^id(id value) {
        NSLog(@"map:--%@",value);
        return value;
    }] array];
}

-(void)RACReplaySubject
{
//用法：可以先订阅信号，也可以先发送信号。
    //1、创建信号
    RACReplaySubject *subject =[RACReplaySubject subject];
    
    //2、发送信号
    [subject sendNext:@"发送字符串"];
    [subject sendNext:@2];
    
    //3、订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

-(void)RACSubject
{
    //实现思路:调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock
    //1、创建信号
    RACSubject *subject =[RACSubject subject];
    //2、订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者--%@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者--%@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"第三个订阅者--%@",x);
    }];
    //3、发送信号
    [subject sendNext:@"send signal"];
}

-(void)btnClick:(UIButton *)btn
{
    if (self.delegateSubject) {
        //被点击时发送信号
        [self.delegateSubject sendNext:@"按钮被点击"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _redView.frame=CGRectMake(100, 300, 200, 200);
}
@end
