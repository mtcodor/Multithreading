//
//  ViewController.m
//  Multithreading
//
//  Created by 马涛 on 2019/3/11.
//  Copyright © 2019 马涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}

- (void)createQueue {
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("newQueue", NULL);
    NSLog(@"%@", queue);
    // 使用主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    NSLog(@"%@", mainQueue);
    
    // 并发队列
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"%@", queue1);
}

/**
 * 用异步函数往全局队并发列中添加任务
 */
- (void)test1 {
    // 获取全局队列
    dispatch_queue_t queue1 =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.添加任务到队列中，就可以执行任务
    //异步函数：具备开启新线程的能力
    dispatch_async(queue1, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    //打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    
    // 总结
    /**
     * 顺序是随机的，但是因为是异步，所以新建了三个子线程
     */
}

/**
 * 用异步函数往手动串行队列中添加e任务
 */
- (void)test2 {
    // 手动创建串行队列
    dispatch_queue_t  queue= dispatch_queue_create("wendingding", NULL);
    //第一个参数为串行队列的名称，是c语言的字符串
    //第二个参数为队列的属性，一般来说串行队列不需要赋值任何属性，所以通常传空值（NULL）
    //2.添加任务到队列中执行
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    
    // 总结
    /**
     * 异步函数只会创建一个新的线程
     */
}

/**
 * 用同步函数往并行队列中添加e任务
 */
- (void)test3 {
    NSLog(@"主线程----%@",[NSThread mainThread]);
    // 手动创建串行队列
    dispatch_queue_t  queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //第一个参数为串行队列的名称，是c语言的字符串
    //第二个参数为队列的属性，一般来说串行队列不需要赋值任何属性，所以通常传空值（NULL）
    //2.添加任务到队列中执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    
    // 总结
    /**
     * 并发队列失去了并发功能，比不会创建新的线程
     */
}

/**
 * 用同步函数往串行队列中添加e任务
 */
- (void)test4 {
    NSLog(@"主线程----%@",[NSThread mainThread]);
    // 手动创建串行队列
    dispatch_queue_t  queue= dispatch_queue_create("wendingding", NULL);
    //第一个参数为串行队列的名称，是c语言的字符串
    //第二个参数为队列的属性，一般来说串行队列不需要赋值任何属性，所以通常传空值（NULL）
    //2.添加任务到队列中执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    
    // 总结
    /**
     *  不会a开启新线程
     */
}

/**
 * 确定几个异步线程完成之后再做某些处理
 */
- (void)test5 {
    // 1、用 dispatch_group_t ，当 dispatch_group_t 执行完后，会执行 dispatch_group_notify 回调
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"======异步操作1");
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"======异步操作2");
//    });
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"======异步操作完成了");
//    });
    
    // 2、用 dispatch_barrier_async，它会让之前的线程执行完之后才会执行
//    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue1, ^{
//        NSLog(@"======异步操作3");
//    });
//    dispatch_async(queue1, ^{
//        NSLog(@"======异步操作4");
//    });
//    dispatch_barrier_sync(queue1, ^{
//        NSLog(@"======异步操作3和4完成了");
//    });
//    dispatch_async(queue1, ^{
//        NSLog(@"======异步操作5");
//    });
    
    // 3、使用NSOperationQueue
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSBlockOperation *p1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"A");
//    }];
//    NSBlockOperation *p2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"B");
//    }];
//    NSBlockOperation *p3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"C");
//    }];
//    [p3 addDependency:p1];
//    [p1 addDependency:p2];
//    // waitUntilFinished是否阻塞当前线程
//    [queue addOperations:@[p1,p2,p3] waitUntilFinished:YES];
//    // 如果是NO,那么这行打印就是随机的, 反之就是等A,B,C都打印完之后才执行
//    NSLog(@"D");
    
    // 4、使用 RunLoop
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"A");
        CFRunLoopStop(CFRunLoopGetMain());
    }] ;
    [task resume];
    CFRunLoopRun();
    NSLog(@"B");
}



@end
