//
//  ViewController.m
//  ShowTimeDemo
//
//  Created by 涂婉丽 on 16/3/10.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "RemindDelCell.h"
#import "RemindModel.h"
#import "Tool.h"
#import "AFHTTPRequestOperationManager.h"
#define k_width  [UIScreen mainScreen].bounds.size.width
#define k_height [UIScreen mainScreen].bounds.size.height
#define BASE_URL(path) [NSString stringWithFormat:@"http://101.226.243.77:8882/SaasIosAuthServer/%@",path]
static NSString *orderCell = @"orderCell";
@interface ViewController ()
{

    AFHTTPRequestOperationManager *manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //请求数据


    
    [self creatTable];
    [self.tableView.mj_footer setHidden:NO];
    
    // 防止block循环retain，所以用__unsafe_unretained
    __unsafe_unretained ViewController *vc = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [vc loadRefreshWithUpOrDown:YES isPush:NO];;
//        [vc loadRefreshWithUpOrDown:YES isPush:NO];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [vc loadRefreshWithUpOrDown:NO isPush:NO];
    }];
    manager = [AFHTTPRequestOperationManager manager];
//    //    //    // 5.0.5秒后自动下拉刷新
//    [self.tableView.mj_header performSelector:@selector(beginRefreshing) withObject:nil afterDelay:0.5];
    
}
- (void)reloadDeals
{
    [self.tableView reloadData];
    // 结束刷新状态
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)loadRefreshWithUpOrDown:(BOOL)isUp isPush:(BOOL)isPush
{
    [self.tableView.mj_footer setHidden:NO];
    NSString *count;
    if (self.dataArra.count == 0||isUp == YES) {
        count = @"1";
    }
       count = [NSString stringWithFormat:@"%tu",[self.dataArra count]/10+1];
    
        NSDictionary * dic = @{@"verbId":@"getMessageList",@"userId":@"2c9280f750a1fa940150a35fbcbb2db7",@"tenantId":@"20150209",@"currentPage":count};
    [manager POST:BASE_URL(@"messageAction.do?") parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog
         (@"提醒------%@",responseObject);
         if ([[responseObject objectForKey:@"flag"] intValue] == 0){
             
             if (isUp==YES) {
                 [self.dataArra removeAllObjects];
             }
             /*请求到的数据 创建model 对象*/
             NSArray *array = [responseObject objectForKey:@"data"];
             for (NSDictionary *tempDic in array) {
                 RemindModel *model = [[RemindModel alloc]init];
                 [model setValuesForKeysWithDictionary:tempDic];
                 [self.dataArra addObject:model];
             }
             
             if ([self.dataArra count] %10!= 0 || [array count] == 0) {
                 [self.tableView.mj_footer setHidden:YES];
                 if ([self.dataArra count] %10!= 0 ) {
                     
                 }else if ([array count] == 0){
                     
                 }
             }

         }
         [self reloadDeals];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self reloadDeals];
              
          }
     ];
    
    
}
    

- (void)creatTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, k_width, k_height) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _tableView.rowHeight = 75;
    [self.view addSubview:_tableView];
    _dataArra= [[NSMutableArray alloc]init];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArra.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemindModel *model = [_dataArra objectAtIndex:indexPath.row];
    RemindDelCell *cell = [RemindDelCell cellWithTab:tableView];
  
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    NSArray *arr = [model.createDate componentsSeparatedByString:@" "];
    
    cell.remindL.text = model.title;
    if ([model.messageArr[0] intValue] == 21) {
        cell.typeL.text = @"";
        cell.remindLCon.constant =(cell.contentView.frame.size.height-CGRectGetHeight(cell.remindL.frame))/2;
        
    }else{
        if (model.messageArr.count>=4) {
            if ([[model.messageArr objectAtIndex:3]isEqualToString:@""]||[model.megTypeId isEqualToString:@"18"]||[model.megTypeId isEqualToString:@"21"]||[model.megTypeId isEqualToString:@"31"]||[model.megTypeId isEqualToString:@"29"]) {
                cell.typeL.text = @"";
                cell.remindLCon.constant =(cell.contentView.frame.size.height-CGRectGetHeight(cell.remindL.frame))/2;;
            }else{
                
                cell.typeL.text = [model.messageArr objectAtIndex:3];
                cell.remindLCon.constant = 14;
            }
            
        }else{
            cell.typeL.text = @"";
            cell.remindLCon.constant =(cell.contentView.frame.size.height-CGRectGetHeight(cell.remindL.frame))/2;
        }
    }
    //    cell.dateLabel.text = [arr objectAtIndex:0];
    cell.dateLabel.text = [Tool remindlistTime:model.createDate];
    NSArray *timeArr = [(NSString *)[arr objectAtIndex:1] componentsSeparatedByString:@":"];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@:%@",timeArr[0] ,timeArr[1]];
    
        if ([timeArr[0] intValue]< 12) {
            cell.timeLabel.text = [NSString stringWithFormat:@"上午  %@:%@",timeArr[0],timeArr[1]];
    
        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"下午  %@:%@",timeArr[0],timeArr[1]];
        }
    
    
    if ([model.isread isEqual:@"1"]) {//已读
        cell.lable.hidden = YES;

    }else{
        cell.lable.hidden = NO;

    }
    
    // cell 分割线左对齐
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        
        // Remove seperator inset
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            
            // Prevent the cell from inheriting the Table View's margin settings
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            
            // Explictly set your cell's layout margins
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
        }
    }
    
    
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
