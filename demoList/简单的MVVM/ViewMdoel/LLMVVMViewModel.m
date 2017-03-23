//
//  LLMVVMViewModel.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMVVMViewModel.h"
#import "AFNetworking.h"
#import "LLMVVMModel.h"
#import "NSObject+BAMJParse.h"
#import "PPNetworkHelper.h"
#import "MovieViewController.h"
#import "LLMVVMDetailModel.h"
@interface LLMVVMViewModel()

 @property (nonatomic,strong)  NSMutableArray * modelArr;
@end
@implementation LLMVVMViewModel

+(LLMVVMViewModel *)shareViewModel{
    
    static LLMVVMViewModel * shareViewModel  ;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareViewModel = [[self alloc]init];
    });
    return shareViewModel;
}


-(void)setupRequsetDate :(NSInteger)pageIndex :(SuccessBlock)successblock :(ErrorBlock) errorblock {
    

    //模拟异步加载数据
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
        NSString * dataPath = [[NSBundle mainBundle]pathForResource:@"MVVM" ofType:nil];
        
        NSData * data = [NSData dataWithContentsOfFile:dataPath];
        
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray * modelTemp = [LLMVVMModel BAMJParse:[jsonDict objectForKey:@"subjects"]];
        
        
        if (pageIndex == 1) {
            NSLog(@"下拉刷新");
            weakSelf.modelArr = [NSMutableArray arrayWithArray:modelTemp];
            
            }else {
            [weakSelf.modelArr addObjectsFromArray:weakSelf.modelArr];
                NSLog(@"上拉加载");
        }
        successblock( weakSelf.modelArr);
    });
    
}

-(void)movieDetailWithPublicModel:(LLMVVMModel *)movieModel WithViewController:(UIViewController *)superController {
    
    MovieViewController *movieVC = [[MovieViewController alloc] init];
   
    
  LLMVVMDetailModel * model =  movieModel.casts.firstObject;
   movieVC.url = model.alt;
    [superController.navigationController pushViewController:movieVC animated:YES];

}

-(NSMutableArray *)modelArr {
    
    if (_modelArr == nil ) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
@end
