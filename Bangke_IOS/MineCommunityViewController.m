//
//  MineCommunityViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/5.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "MineCommunityViewController.h"
#import "Cell_MineCommunity.h"
#import "Model_Community.h"
#import "View_AddCommunity.h"
#import "AddCommunityViewController.h"
#import "UserInfoTool.h"


@interface MineCommunityViewController () <UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate,sendModel,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UIWindow * addWindow;
@property (nonatomic, assign) NSInteger currentIndex;
//@property (nonatomic, strong) Model_Community * currentModel;
@property (nonatomic, strong) NSIndexPath * currentIndexPath;


@end
static NSString * cellIdentifier = @"Cell_MineCommunity";
@implementation MineCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    
//    self.navigationController.navigationBar.hidden = NO;
    self.addWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.dataArr = [NSMutableArray array];
//    NSArray * arr1 = [NSArray arrayWithObjects:@"1", nil];
//    [self.dataArr addObjectsFromArray:arr1];
    [self createUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
    
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"Cell_MineCommunity" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editAction:)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.flag = YES;
    
}


- (void)requestData
{
    [self.dataArr removeAllObjects];
    NSDictionary * param = [NSDictionary dictionaryWithObject:[UserInfoTool getToken] forKey:@"access_token"];
    NSLog(@"%@",param);
    [AFNHttpTools getDataWithUrl:@"permissions/address" andParameters:param successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSLog(@"json = %@",[AFNHttpTools jsonStringWithDict:dict]);
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSString * state = [dict objectForKey:@"state"];
        NSString * message = [dict objectForKey:@"message"];
        if ([state isEqualToString:dStateSuccess]) {
            NSArray * responseText = [dict objectForKey:@"responseText"];
            for (NSInteger i = 0 ; i < responseText.count; i++ ) {
                NSDictionary * community = responseText[i];
                NSString * json = [AFNHttpTools jsonStringWithDict:community];
                NSLog(@"%@",json);
                Model_Community * model = [[Model_Community alloc]initWithString:json error:nil];
                NSLog(@"model = %@",model.phone);
                
                [self.dataArr addObject:model];

            }
            [self.tableView reloadData];
        }else if ([state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
        }
//
//            if (responseText.count > 0) {
//                for (NSInteger i = 0 ; i < responseText.count; i++ ) {
//                    NSDictionary * community = responseText[i];
//                    NSString * json = [AFNHttpTools jsonStringWithDict:community];
//                    NSLog(@"%@",json);
//                    Model_Community * model = [[Model_Community alloc]initWithString:json error:nil];
//                    NSLog(@"model = %@",model.id);
//                    NSString * MID = [community objectForKey:@"id"];
//                    NSString * community_id = [community objectForKey:@"community_id"];
//                    NSString * account = [community objectForKey:@"account"];
//                    NSString * default_select = [community objectForKey:@"default_select"];
//                    NSString * receive_address = [community objectForKey:@"receive_address"];
//                    NSString * contact_name = [community objectForKey:@"contact_name"];
//                    NSString * phone = [community objectForKey:@"phone"];
//                    NSString * community_name = [community objectForKey:@"community_name"];
//                    NSString * city_id = [community objectForKey:@"city_id"];
////                    NSString * area_id = [community objectForKey:@"area_id"];
//                    NSString * city_name = [community objectForKey:@"city_name"];
//                    NSString * area_name = [community objectForKey:@"area_name"];
//                    NSString * latitude = [community objectForKey:@"latitude"];
//                    NSString * longitude = [community objectForKey:@"longitude"];
                    //Model_Community * model = [[Model_Community alloc]initWithDictionary:community error:nil];
//                    model.MID = MID;
//                    model.community_id = community_id;
//                    model.account = account;
//                    model.default_select = default_select;
//                    model.receive_address = receive_address;
//                    model.contact_name = contact_name;
//                    model.phone = phone;
//                    model.community_name = community_name;
//                    model.city_id = city_id;
////                    model.area_id = area_id;
//                    model.city_name = city_name;
//                    model.area_name = area_name;
//                    model.latitude = latitude;
//                    model.longitude = longitude;
//                    NSLog(@"model = %@",model);
//                    [self.dataArr addObject:model];
            
//                }
//                [self.tableView reloadData];
//                
//            }
//        }else{
//            [self.view makeToast:message duration:1.0 position:CSToastPositionCenter];
//        }
        
    } failed:^(NSError *err) {
        NSLog(@"%@",err);
        NSLog(@"err = %@",[err localizedDescription] );
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

#pragma mark - Action
-(void)editAction:(UIBarButtonItem *)item
{
    self.flag = !self.flag;
    if (self.flag == YES) {
        item.title = @"编辑";
    }else{
        item.title = @"完成";
    }

    [self.tableView reloadData];
}

- (void)backAction
{
    if (self.source == 1) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else if (self.source ==2){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (void)cancelAction
{
    [[[[UIApplication sharedApplication].delegate window] viewWithTag:1000] removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == self.dataArr.count) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImageView * addBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.26 * kMainScreenWidth)];
        addBtn.backgroundColor = [UIColor blueColor];
        addBtn.image = [UIImage imageNamed:@"添加_06"];
        [cell.contentView addSubview:addBtn];
        return cell;
    }else{
        Cell_MineCommunity * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.rightUtilityButtons = [self rightButtons];
        Model_Community * model = self.dataArr[indexPath.row];
        cell.model = model;
        return cell;

    }

    
    
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    if (self.flag == YES) {
        [rightUtilityButtons removeAllObjects];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor orangeColor] title:@"设为默认"];
    }else{
        [rightUtilityButtons removeAllObjects];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor lightGrayColor] title:@"编辑"];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor orangeColor] title:@"删除"];
        
    }
    
    
    return rightUtilityButtons;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArr.count){
        CGFloat height = 0.26 * kMainScreenWidth;
        return height;
    }else{
        return 116;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.source == 2) {
        //发单流程进入
        if (indexPath.row == self.dataArr.count) {
            
            AddCommunityViewController * addVC = [[AddCommunityViewController alloc]init];
            addVC.delegate = self;
            addVC.type = 2;
            [self.navigationController pushViewController:addVC animated:YES];
            //        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
            //        bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            //        bgView.tag = 1000;
            //
            //
            //
            //        UIView * addView = [[UIView alloc]initWithFrame:CGRectMake(50, kMainScreenHeight * 0.2, kMainScreenWidth-100, kMainScreenHeight-kMainScreenHeight * 0.4)];
            //        addView.backgroundColor = [UIColor redColor];
            //        [bgView addSubview:addView];
            //        [self.view addSubview:addView];
            //        UIButton * cancelBtn = view.cancelBtn;
            //        [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else{
            Model_Community * model = self.dataArr[indexPath.row];
            self.decideCommunity(model);
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else{
        if (indexPath.row == self.dataArr.count) {
            
            AddCommunityViewController * addVC = [[AddCommunityViewController alloc]init];
            addVC.delegate = self;
            addVC.type = 2;
            [self.navigationController pushViewController:addVC animated:YES];
            //        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
            //        bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            //        bgView.tag = 1000;
            //
            //
            //
            //        UIView * addView = [[UIView alloc]initWithFrame:CGRectMake(50, kMainScreenHeight * 0.2, kMainScreenWidth-100, kMainScreenHeight-kMainScreenHeight * 0.4)];
            //        addView.backgroundColor = [UIColor redColor];
            //        [bgView addSubview:addView];
            //        [self.view addSubview:addView];
            //        UIButton * cancelBtn = view.cancelBtn;
            //        [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else{
            
        }
    }

}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    Cell_MineCommunity * currentCell = (Cell_MineCommunity *)cell;
    self.currentModel = currentCell.model;
    switch (index) {
        case 0:
        {
            if (self.flag == YES) {
                NSLog(@"设为默认");
                
                NSLog(@"model.id = %@",self.currentModel.id);
                NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
//                [param setValue:model.community_id forKey:@"id"];
                [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
                
                
                NSLog(@"%@",param);
                [AFNHttpTools putDataWithUrl:[NSString stringWithFormat:@"permissions/address/%@",self.currentModel.id] andParameters:param successed:^(NSDictionary *dict) {
                    NSLog(@"dict = %@",dict);
                    NSString * state = [dict objectForKey:@"state"];
                    NSString * message = [dict objectForKey:@"message"];
                    if ([state isEqualToString:dStateSuccess]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [self requestData];
//                        [self.tableView setNeedsDisplay];
                        
                    }else if ([state isEqualToString:dStateTokenInvalid]) {
                        [UserInfoTool deleteToken];
                        [APPLICATION setHomePageVC];
                    }else{
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    }
                } failed:^(NSError *err) {
                    NSLog(@"err = %@",err);
                    NSLog(@"err = %@",[err localizedDescription]);
                }];
                [cell hideUtilityButtonsAnimated:YES];
                
                
            }else{
                NSLog(@"编辑");
                AddCommunityViewController * addVC = [[AddCommunityViewController alloc]init];
                addVC.type = 1;
                addVC.delegate = self;
                addVC.currentCommunity = self.currentModel;
//                self.currentIndex = index;
                
                [self.navigationController pushViewController:addVC animated:YES];
                [cell hideUtilityButtonsAnimated:YES];
                
            }
            
        }
            break;
        case 1:
        {
             self.currentIndexPath = [self.tableView indexPathForCell:cell];
            if (curVersion == 7) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"是否确认删除社区" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.delegate = self;
                [alert show];
                
            }else{
                NSLog(@"%d", curVersion);
                
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"是否确认删除社区" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        
                                    [self.dataArr removeObjectAtIndex:self.currentIndexPath.row];
                                    [self.tableView deleteRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        
                        NSLog(@"%@",self.currentModel.id);
                        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
                        //                [param setValue:model.community_id forKey:@"id"];
                        [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
                        
                        
                        NSLog(@"%@",param);
                        [AFNHttpTools deleteDataWithUrl:[NSString stringWithFormat:@"permissions/address/%@",self.currentModel.id] andParameters:param successed:^(NSDictionary *dict) {
                            NSLog(@"dict = %@",dict);
                            NSString * state = [dict objectForKey:@"state"];
                            NSString * message = [dict objectForKey:@"message"];
                            if ([state isEqualToString:dStateSuccess]) {
                                [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                            }else{
                                [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                            }
                        } failed:^(NSError *err) {
                            NSLog(@"err = %@",err);
                            [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
                        }];

                        
                    }];
                    [alertCtrl addAction:okAction];
                    [alertCtrl addAction:cancelAction];
                
                
                
                [self presentViewController:alertCtrl animated:YES completion:nil];
            }
            // Delete button was pressed
//            NSIndexPath *cellIndexPath = [self.tv indexPathForCell:cell];
//            
//            [self.arr removeObjectAtIndex:cellIndexPath.row];
//            [self.tv deleteRowsAtIndexPaths:@[cellIndexPath]
//                           withRowAnimation:UITableViewRowAnimationAutomatic];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - sendModel

-(void)sendEditCommunity:(Model_Community *)model withType:(NSInteger)type
{
    if (type == 1) {
        [self.dataArr replaceObjectAtIndex:self.currentIndex withObject:@"3"];
        [self.tableView reloadData];
            NSLog(@"%@",self.dataArr);
    }else{
        [self.dataArr addObject:@"6"];
        [self.tableView reloadData];
            NSLog(@"%@",self.dataArr);
    }

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            
            
            [self.dataArr removeObjectAtIndex:self.currentIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            NSLog(@"%@",self.currentModel.id);
            NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
            //                [param setValue:model.community_id forKey:@"id"];
            [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
            
            
            NSLog(@"%@",param);
            [AFNHttpTools deleteDataWithUrl:[NSString stringWithFormat:@"permissions/address/%@",self.currentModel.id] andParameters:param successed:^(NSDictionary *dict) {
                NSLog(@"dict = %@",dict);
                NSString * state = [dict objectForKey:@"state"];
                NSString * message = [dict objectForKey:@"message"];
                if ([state isEqualToString:dStateSuccess]) {
                    [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                }else if ([state isEqualToString:dStateTokenInvalid]) {
                    [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    [UserInfoTool deleteToken];
                    [APPLICATION setHomePageVC];
                }else{
                    [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                }
            } failed:^(NSError *err) {
                NSLog(@"err = %@",err);
                [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - block
-(void)returnCommunityModel:(CallBackCommunityModel)model
{
    self.decideCommunity = model;
}

@end
