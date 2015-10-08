//
//  WeTalkListViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "WeTalkListViewController.h"
#import "Cell_TalkContact.h"
#import "Model_TalkContact.h"
#import "ChatViewController.h"
static NSString * cellIdentifier = @"Cell_TalkContact";
@interface WeTalkListViewController () <UITableViewDataSource,UITableViewDelegate,IChatManagerDelegate>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation WeTalkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [self createUI];
}
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    //自定义navi
//    self.navigationController.navigationBar.hidden = YES;
//    UINavigationBar * naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kMainScreenWidth, 64)];
//    [naviBar setBarTintColor:[UIColor orangeColor]];
//    [self.view addSubview:naviBar];
    //rightItem
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth-40, 0, 40, 40)];;
//        [self.navigationController.navigationBar addSubview:btn];
//    [btn showPlaceHolderWithLineColor:[UIColor blackColor]];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(naviBar.mas_right).with.offset(0);
//        make.top.mas_equalTo(naviBar.mas_top).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(64, 64));
//    }];
//    btn.backgroundColor = [UIColor redColor];
//    [btn setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"Cell_TalkContact" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

///rightBarItem

#pragma mark - Action
- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)addAction:(UIButton *)btn
{
    NSLog(@"---------添加按钮Action");
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_TalkContact * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Model_TalkContact * model = [[Model_TalkContact alloc]init];
    model.name = @"奇拉比";
    model.time = @"上午 9：00";
    model.content = @"我不想去我不想去不想去不想去了";
    model.contactID = indexPath.row;
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转聊天页面
    ChatViewController * chatVC = [[ChatViewController alloc]initWithChatter:@"test2" isGroup:NO];
    chatVC.title = @"test2";
    [self.navigationController pushViewController:chatVC animated:YES];
}
#pragma mark - ReceiveMessage
/*!
 @method
 @brief 收到消息时的回调
 @param message      消息对象
 @discussion 当EMConversation对象的enableReceiveMessage属性为YES时, 会触发此回调
 针对有附件的消息, 此时附件还未被下载.
 附件下载过程中的进度回调请参考didFetchingMessageAttachments:progress:,
 下载完所有附件后, 回调didMessageAttachmentsStatusChanged:error:会被触发
 */
- (void)didReceiveMessage:(EMMessage *)message
{
    NSLog(@"message == %@",message);
}




- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}
@end
