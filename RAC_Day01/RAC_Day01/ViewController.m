//
//  ViewController.m
//  RAC_Day01
//
//  Created by huangbaoyu on 16/8/25.
//  Copyright © 2016年 chachong. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RAC_Day01-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *swiftButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    RACSignal *userNameSingal = [self.userName.rac_textSignal map:^id(id value) {
        NSString *text = value;
        if (text.length>3)
        {
            return @(true);
        }else
        {
            return @(false);
        }
        
        
    }];
    
    
    RACSignal *passwordSingal = [self.passWord.rac_textSignal map:^id(id value) {
        NSString *text = value;
        if (text.length>3)
        {
            return @(true);
        }else
        {
            return @(false);
        }
    }];
    

    RAC(self.userName,backgroundColor) = [userNameSingal map:^id(NSNumber *userNameValid) {
       
        return [userNameValid boolValue]?[UIColor yellowColor]:[UIColor clearColor];
    }];
    
    
    
    
    //组合到登录按钮上去
    RACSignal *loginSingal = [[RACSignal combineLatest:@[userNameSingal,passwordSingal]] reduceEach:^id(NSNumber *userNameValid,NSNumber *passwordValid){
//        NSLog(@"%d",(userNameValid&&passwordValid));
        return @([userNameValid boolValue]&&[passwordValid boolValue]);
    }];

    [loginSingal subscribeNext:^(NSNumber *loginValid) {
        self.loginButton.enabled = [loginValid boolValue];
    }];
    
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了登录按钮");
    }];
    
    
    [[self.swiftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击swift");
    }];
    
//   [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//       
//   }];
    
//    RAC(self.loginButton,backgroundColor) = [loginSingal map:^id(NSNumber *loginValid) {
//        return [loginValid boolValue]?[UIColor blueColor]:[UIColor redColor];
//    }];
//    
    
}


- (void)test
{
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    field.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:field];
    //    [field.rac_textSignal subscribeNext:^(id x) {
    //        NSLog(@"%@",x);
    //    }];
    
    [[[field.rac_textSignal map:^id(id value) {
        NSString *text = value;
        if(text.length>3)
        {
            NSLog(@"asd = %@",[text substringToIndex:3]);
            return [text substringToIndex:3];
        }else
        {
            return text;
        }
        
    }] filter:^BOOL(id value) {
        //在这里面把需要过滤的过滤掉
        NSString *text = value;
        if(text.length>3)
        {
            return false;
        }else
        {
            return true;
        }
        
        
        
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    RACSignal *validteUsernameSingal = [_userName.rac_textSignal map:^id(id value) {
        
        return @(true);
        return value;
    }];
    
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
