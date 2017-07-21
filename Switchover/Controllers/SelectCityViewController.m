//
//  SelectCityViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/21.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "SelectCityViewController.h"
#import "Masonry.h"
#import "CityViewModel.h"
#import "CompleteInfoViewController.h"

@interface SelectCityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@end

@implementation SelectCityViewController
{
    NSArray *dataArray;
}
//NSMutableArray *cityArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择城市";
    [self initCodeView];
//    [self setDataSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void) setDataSource:(NSMutableArray *)citys {
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSArray *titles = collation.sectionTitles;
    
    NSMutableArray *secionArray = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0; i < titles.count; i++) {
        NSMutableArray *subArr = [NSMutableArray array];
        [secionArray addObject:subArr];
    }
    
    for (int i = 0; i < citys.count; i++) {
        CityViewModel * city = [[CityViewModel alloc] init];
        city.name = citys[i][@"text"];
        city.code = citys[i][@"value"];
        NSInteger section = [collation sectionForObject:city collationStringSelector:@selector(name)];
        NSMutableArray *subArr = secionArray[section];
        
        [subArr addObject:city];
    }
    
    for (NSMutableArray *subArr in secionArray) {
        NSArray *sortArr = [collation sortedArrayFromArray:subArr collationStringSelector:@selector(name)];
        [subArr removeAllObjects];
        [subArr addObjectsFromArray:sortArr];
    }
    
    dataArray = [NSArray arrayWithArray:secionArray];
    
//    NSLog(@"collation title %@", titles);

}

-(void) initCodeView {
    
//    dataArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] init];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.leading.equalTo(self.view.mas_leading).offset(0);
        make.trailing.equalTo(self.view.mas_trailing).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [CityViewModel getCityList:^(id  _Nullable responseObject) {
        
        [self setDataSource:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        NSLog(@"getcitylist%@", error);
    }];
}

#pragma mark SectionTitles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - Cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityViewModel *city = [dataArray[indexPath.section] objectAtIndex:indexPath.row];
    
    
    CompleteInfoViewController *completeController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
    completeController.city = city;
    [self.navigationController popToViewController:completeController animated:YES];
//    NSLog(@"hello world%@", city.code);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *QBCellId = @"QBCell11";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBCellId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBCellId];
    }
    
    
    cell.textLabel.text = [[dataArray[indexPath.section] objectAtIndex:indexPath.row] name];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [UILocalizedIndexedCollation currentCollation].sectionTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray[section] count];
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
