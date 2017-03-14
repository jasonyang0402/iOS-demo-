//
//  ViewController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "ViewController.h"
#import "LLDemoModel.h"
#import "LLDemoHeaderFooterView.h"
#import "LLDataSource.h"
#import "NetWoringCacheViewController.h"
#import "ZXShopCartViewController.h"
#import "LLCalendarViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  NSMutableArray * demoTitleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"iOS Demo 集锦";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[LLDemoHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"LLDemoHeaderFooterView"];
    [self setupData];
    self.tableView.tableFooterView = [UIView new];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData{
    
 __weak typeof(self) _self = self;
  [LLDataSource init:^(NSArray *resultArr) {
      _self.demoTitleArr = [NSMutableArray arrayWithArray:resultArr];
      [_self.tableView reloadData];
  }];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demoTitleArr.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLDemoModel * model = self.demoTitleArr[section];
    return model.demoArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLDemoModel * model = self.demoTitleArr[indexPath.section];
    if (model.headFootClick) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = model.demoArr[indexPath.row];
        
        return cell;
    }else {
        
        return [UITableViewCell new];
    
    }

   

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLDemoModel * model = self.demoTitleArr[indexPath.section];
    
    if (model.headFootClick) {
        return 44;
    }else {
        return 0.0001;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLDemoHeaderFooterView * headFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLDemoHeaderFooterView"];
    LLDemoModel * model = self.demoTitleArr[section];
    headFootView.model =model;
    headFootView.block = ^(LLDemoHeaderFooterView * headFootView) {
        model.headFootClick = !model.headFootClick;
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    };
    return headFootView;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 55;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//时间日历
            LLCalendarViewController * calenVc = [LLCalendarViewController new];
            calenVc.title = @"时间日历";
            [self.navigationController pushViewController:calenVc animated:true];
            
        }else if (indexPath.row == 1)//购物车动画
        {
            ZXShopCartViewController  * shopVc = [ZXShopCartViewController new];
             shopVc.title = @"购物车动画";
            [self.navigationController pushViewController:shopVc animated:true];
        
        }else if (indexPath.row == 2) {//接口缓存使用YYCace
            
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"NetWoringCacheViewController" bundle:nil];
            NetWoringCacheViewController * netVc = sb.instantiateInitialViewController;
                netVc.title = @"AFN3.0封装 接口并缓存使用YYCace";
                [self.navigationController pushViewController:netVc animated:true];
           
        
        }else if (indexPath.row == 3) {
        
        }
    }

}

-(NSMutableArray *)demoTitleArr {
    if (_demoTitleArr == nil) {
        _demoTitleArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _demoTitleArr;
}



@end
