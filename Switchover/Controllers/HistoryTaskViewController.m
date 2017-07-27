//
//  HistoryTaskViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/25.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "HistoryTaskViewController.h"
#import "Masonry.h"
#import "HistoryTaskTableViewCell.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "HistoryTaskDetailViewController.h"
#import "HistoryTaskViewModel.h"
#import "ReactiveObjC.h"

@interface WSRefreshControl : UIRefreshControl

@end

@implementation WSRefreshControl

-(void)beginRefreshing
{
    [super beginRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)endRefreshing
{
    [super endRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
@end

@interface HistoryTaskViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong ,nonatomic)NSMutableArray *modelArray;
@property (strong ,nonatomic) HistoryTaskViewModel *historyTaskViewModel;
@end

@implementation HistoryTaskViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCodeView];
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"历史任务";
    self.historyTaskViewModel = [[HistoryTaskViewModel alloc] init];
    
    [self initRAC];
    
//    [self.historyTaskViewModel fetchTasks:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initRAC {

    [[self.historyTaskViewModel fetchTasks:nil] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
}

-(void) initCodeView
{

    self.view.backgroundColor = [UIColor colorWithHexString:APP_MAIN_BGCOLOR];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    

    UIRefreshControl *refresh = [[WSRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.tableView.contentOffset = CGPointMake(0,-self.refreshControl.frame.size.height);
    [refresh beginRefreshing];

}

-(void)viewDidAppear:(BOOL)animated
{
    
//    [self.tableView setContentInset: UIEdgeInsetsMake(200, 0, 0, 0)];
//    CGRect rect = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    self.tableView.
}

-(void) refresh:(UIRefreshControl*)refreshControl
{
    if (refreshControl.isRefreshing) {
        refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
//        refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        [self.historyTaskViewModel resetData];
        [[self.historyTaskViewModel fetchTasks:nil] subscribeNext:^(id  _Nullable x) {
            
            NSLog(@"tasks .... %@", self.historyTaskViewModel.tasks);
            
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        }];
//        [refreshControl endRefreshing];
    }
    
}



-(void) testAction
{
    [self.refreshControl endRefreshing];
    
}


#pragma mark -tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.historyTaskViewModel.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"QBTableCell";
    
    
    HistoryTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HistoryTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.layer.cornerRadius = 3;
    if(self.historyTaskViewModel.tasks.count > 0) {
        NSDictionary *task = self.historyTaskViewModel.tasks[indexPath.section][indexPath.row];
        
        cell.moneyTitle.text = task[@"reward"];
        cell.taskTime.text = task[@"time"];
        cell.switchNum.text = [NSString stringWithFormat:@"换电数量:%@个", task[@"switchNum"]];
        cell.useTime.text = [NSString stringWithFormat:@"用时:%@分钟", task[@"useTime"]];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 600)];
    UIView *center = [[UIView alloc] init];
    
    center.backgroundColor = [UIColor colorWithHexString:@"d9d9d9"];
    center.layer.cornerRadius = 12;
    
    [view addSubview:center];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = [UIColor whiteColor];
    
    [center addSubview:dateLabel];
    [center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
        make.height.equalTo(@25);
        make.width.equalTo(@93);
    }];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(center.mas_centerX);
        make.centerY.equalTo(center.mas_centerY);
    }];
    
    if (self.historyTaskViewModel.taskSection.count > 0) {
        dateLabel.text = self.historyTaskViewModel.taskSection[section];
    }
    view.backgroundColor = [UIColor colorWithHexString:APP_MAIN_BGCOLOR];
    
    return view;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // headerView多高这里就是多少
    CGFloat sectionHeaderHeight = 55;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(self.refreshControl.frame.size.height - scrollView.contentOffset.y, 0,0 ,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0,0 ,0);
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.historyTaskViewModel.tasks.count > 0) {
        return self.historyTaskViewModel.tasks[section].count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HistoryTaskDetailViewController *taskDetailController = [[HistoryTaskDetailViewController alloc] init];
    
    [self.navigationController pushViewController:taskDetailController animated:YES];
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
