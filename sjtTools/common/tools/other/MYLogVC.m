//
//  MYLogVC.m
//  antQueen
//
//  Created by 寇广超 on 2018/10/26.
//  Copyright © 2018 yibyi. All rights reserved.
//

#import "MYLogVC.h"


@interface MYLogVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MYLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"日志查看";
    
    NSFileManager* fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:[self filePath]]){
        //取得一个目录下得所有文件名
        NSArray *files = [fm subpathsAtPath:[self filePath]];
        self.dataSource = files;
        [self.tableView reloadData];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarWhite];
}
-(NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    return logDirectory;
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate, UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"historyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *path = [[self filePath] stringByAppendingPathComponent:[self.dataSource objectAtIndex:indexPath.row]];
    
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:tableView.frame];
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = content;
    textView.textColor = [UIColor blueColor];
    textView.editable = NO;
    [self.view addSubview:textView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideText:)];
    [textView addGestureRecognizer:tap];
    
}

-(void)hideText:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
}

#pragma mark -
#pragma mark Getter

-(UITableView *)tableView
{
    if (!_tableView) {
        
        CGFloat tableView_X = 0;
        CGFloat tableView_Y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat tableView_W = SCREEN_W;
        CGFloat tableView_H = SCREEN_H - tableView_Y;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableView_X, tableView_Y, tableView_W, tableView_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
