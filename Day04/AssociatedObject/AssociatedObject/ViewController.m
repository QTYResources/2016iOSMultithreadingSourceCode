//
//  ViewController.m
//  AssociatedObject
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+MyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgView = [UIImageView new];
    
    imgView.urlString = @"123abc";
    
    NSLog(@"%@",imgView.urlString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
