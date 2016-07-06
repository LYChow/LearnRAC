//
//  ViewController.m
//  LearnRAC
//
//  Created by LY'S MacBook Air on 7/2/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Calculator.h"
#import "Person.h"
#import "NSObject+KVO.h"
#import "calculatorManager.h"

#import "SecondViewController.h"
#import "LoginViewController.h"


#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property(nonatomic,strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //链式编程
//    [self programmingChain];
    
    //响应式编程
//    [self progammingReactive];
    
     //函数式编程
//    [self programmingFunctional];
    
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"presentVC" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *PresentMVVMBtn =[[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [PresentMVVMBtn setTitle:@"presentMVVM" forState:UIControlStateNormal];
    PresentMVVMBtn.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:PresentMVVMBtn];
    [[PresentMVVMBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LoginViewController *loginVC =[[LoginViewController alloc] init];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }];
}

#pragma mark -RAC的实践
-(void)btnClick:(UIButton *)btn
{
    SecondViewController *secondVC =[[SecondViewController alloc] init];
    //设置代理信号
    secondVC.delegateSubject =[RACSubject subject];
    
    //订阅代理信号
    [secondVC.delegateSubject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [self presentViewController:secondVC animated:YES completion:nil];
}


-(void)RacReplaceDelegate
{

}

-(void)RACSignal
{
    RACDisposable *(^disposable)(id<RACSubscriber> subscriber)  = ^RACDisposable *(id<RACSubscriber> subscriber) {
        //每当有订阅者订阅信号,就会调用block
        
        //2、发送信号
        [subscriber sendNext:@"send data"];
        
        return [RACDisposable disposableWithBlock:^{
            //当信号发送完或者发送错误,就会执行这个block取消订阅信号
            //执行完block后,当前信号就不被订阅了
        }];
    };
    //1、创建信号
    RACSignal *signal =[RACSignal createSignal:disposable];
    
    //3、订阅信号,才会激活信号
    [signal subscribeNext:^(id x) {
        //每当发送信号,就会调用该block
        
        NSLog(@"接收到数据:%@",x);
    }];

}

#pragma mark -链式编程、响应式编程、函数式编程

-(void)programmingChain
{
    int result= [NSObject zly_makeCalculator:^(calculatorMaker *maker) {
        maker.add(4).add(5).divide(3).minus(1).mutip(9);
    }];
    NSLog(@"result=%d",result);
}

-(void)progammingReactive
{
    Person *p =[Person new];
    //    //p的isa指针指向Person
    //
    //    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    //    //p增加观察者时,isa指针指向NSKVONotifying_Person
    
    _p=p;
    
    //模仿KVO实现的思路
    //1、对一个对象(p)添加observer时,把这个对象的isa指针指向这个对象(p) 的类(Person) 的子类(ZLYKVONotifying_Person),并把观察者对象(self)通过key保存起来
    //2、当调用对象的setName方法时,就会调用ZLYKVONotifying_Person对象的setName方法,通过key把self取出来,通知控制器监听到值得改变
    
    [p zly_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)programmingFunctional
{
    //目的:想让一系列的执行操作全部在一个代码块里面完成,返回的对象为对象本身,可以多次调用自己的方法
    calculatorManager *mgr =[calculatorManager new];
    int result = [[mgr calculator:^int(int value) {
        value+=8;
        value*=9;
        return value;
    }] result];
    NSLog(@"result =%d",result);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
   
    if ([keyPath isEqualToString:@"name"]) {
         NSLog(@"name=%@",_p.name);
    }
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int index =0;
    index++;
    _p.name=[NSString stringWithFormat:@"name_%d",index];
}


@end
