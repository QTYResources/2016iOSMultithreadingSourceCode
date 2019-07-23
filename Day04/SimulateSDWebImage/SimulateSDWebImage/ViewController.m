//
//  ViewController.m
//  SimulateSDWebImage
//
//  Created by QinTuanye on 2019/7/23.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "ViewController.h"
#import "HMAppInfo.h"
#import "HMAppInfoCell.h"
#import "NSString+Sandbox.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *appInfos;


@end


@implementation ViewController
//懒加载
- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [HMAppInfo appInfos];
    }
    return _appInfos;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1 测试模型数据
    //    NSLog(@"%@",self.appInfos);
}
//2 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1 创建可重用的cell
    static NSString *reuseId = @"appInfo";
    HMAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    //2 获取数据，给cell内部子控件赋值
    HMAppInfo *appInfo = self.appInfos[indexPath.row];
    
    cell.appInfo = appInfo;
    //3 返回cell
    return cell;
}

@end

