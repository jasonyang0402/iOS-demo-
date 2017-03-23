//
//  LLMVVMTabView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMVVMTabView.h"
#import "LLMVVMModel.h"
#import "LLMVVMViewModel.h"
#import "MJRefresh.h"
@interface LLMVVMTabView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)  NSInteger  pageIndex;
@end
@implementation LLMVVMTabView

-(void)setModelArr:(NSArray *)modelArr {
    
    _modelArr = modelArr;
    
    [self reloadData];

}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
         __weak typeof(self) weak = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak.pageIndex = 1;
            weak.blockHeader(weak.pageIndex);
        }];
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weak.pageIndex++;
             weak.blockFooter(weak.pageIndex);
           
        }];

    }
    
    return self;
}

/// MARK: ---- 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    LLMVVMModel * model = self.modelArr[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.block(self.modelArr[indexPath.row]);
    
    
}

@end
