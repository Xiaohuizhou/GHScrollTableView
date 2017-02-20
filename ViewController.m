//
//  ViewController.m
//  GHScrollTableView
//
//  Created by 周光辉 on 2016/12/31.
//  Copyright © 2016年 demo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, assign) int timerInt;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 284) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   // self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    // 开启滚动
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollTheWinnerList:) userInfo:nil repeats:YES];

}
//滚动获奖者名单
- (void)scrollTheWinnerList:(NSTimer *)time
{
    self.timerInt ++;
    if (self.timerInt == 50) {
        self.timerInt = 0;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } else {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark 循环滚动
- (void)resetContentOffsetIfNeeded
{
    NSArray *indexpaths = [self.tableView indexPathsForVisibleRows];
    int totalVisibleCells = [indexpaths count];
    CGPoint contentOffset  = self.tableView.contentOffset;
    //check the top condition
    if  ( contentOffset.y <= 0.0) {
        contentOffset.y = 0;
        self.timerInt = 0;
    } else if ( contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height) ) {
        // scrollview content offset reached bottom minus the height of the tableview
        contentOffset.y = - self.tableView.bounds.size.height;
        //        self.timerInt = 0;
    }
    [self.tableView setContentOffset: contentOffset];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LitigaCellIdentifier = @"GHRecommendViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LitigaCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LitigaCellIdentifier];
        
    }
    for (UIView *subViews in cell.contentView.subviews) {
        [subViews removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 30, 21)];
    label.text = @"恭喜";
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:label];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 90, 21)];
    userLabel.text = @"11";
    userLabel.font = [UIFont systemFontOfSize:13.0f];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    userLabel.frame = CGRectMake(40, 2, 100, 21);
    [cell.contentView addSubview:userLabel];
    
    UILabel *HuoDeLabel = [[UILabel alloc] initWithFrame:CGRectMake(userLabel.frame.origin.x + CGRectGetWidth(userLabel.frame) + 5, 2, 30, 21)];
    HuoDeLabel.text = @"获得";
    HuoDeLabel.font = [UIFont systemFontOfSize:13.0];
    HuoDeLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:HuoDeLabel];
    
    UILabel *awardName = [[UILabel alloc] initWithFrame:CGRectMake(HuoDeLabel.frame.origin.x + CGRectGetWidth(HuoDeLabel.frame) + 5, 2, 80, 21)];
    awardName.text = @"22";
    awardName.font = [UIFont systemFontOfSize:13.0];
    awardName.textColor = [UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1.0];
    [cell.contentView addSubview:awardName];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, 2, 80, 21)];
    timeLabel.text = @"33";
    NSArray *timeARR = [timeLabel.text componentsSeparatedByString:@" "];
    timeLabel.text = [timeARR firstObject];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:timeLabel];    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    int number = scrollView.contentOffset.y / 44;
//    self.timerInt = number;
//   // [self resetContentOffsetIfNeeded];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
