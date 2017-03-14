//
//  LLDataSource.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLDataSource.h"
#import "LLDemoModel.h"
@implementation LLDataSource

+(void)init:(dataSourceBlock)callBack {
    
    
       
        NSArray * timeArr = @[@"2017-03-14",@"2017-03-15"];
        
        NSMutableArray * tempArr = [NSMutableArray array];
        
        for (int i =0; i<timeArr.count; i++) {
            LLDemoModel * model = [LLDemoModel new];
            model.updateTime = timeArr[i];
            switch (i) {
                case 0:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"时间日历",@"购物车动画",@"AFN3.0封装,接口并缓存使用YYCace" ,@"仿简书个人中心页,带下拉刷新",nil];
                    break;
                case 1:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"其他1",@"爱她" ,nil];
                    break;
                default:
                    break;
            }
            
            [tempArr addObject:model];
        }
        
       callBack(tempArr);
        
    
}

@end
