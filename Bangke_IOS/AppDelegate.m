//
//  AppDelegate.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AppDelegate.h"
#import "ECSlidingViewController.h"
#import "MineMessageViewController.h"
#import "WeTalkListViewController.h"
#import "LeftMenuViewController.h"
#import "HomePageViewController.h"
#import "AddCommunityViewController.h"
#import "UserInfoTool.h"
#import "SelectTagViewController.h"
#import "OrderDetail_AViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"

//个推
#define APPKEY @"haIzU7Xpcc5Uvsl80P8HG4"
#define APPSECRET @"zvbyOKvBr67R6AwOeMbYH8"
#define APPID @"cg3KujKRZ597BQjWdGqLU4"


@interface AppDelegate () <UIGestureRecognizerDelegate>



@end

@implementation AppDelegate

@synthesize window = _window;
//@synthesize viewController = _viewController;

@synthesize gexinPusher = _gexinPusher;
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize appID = _appID;
@synthesize clientId = _clientId;
@synthesize sdkStatus = _sdkStatus;
@synthesize lastPayloadIndex = _lastPaylodIndex;
@synthesize payloadId = _payloadId;



+(id)shareInstance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:NAVICOLOR]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    
    [self easeMobLogin];
    //进入我的信息
    //[self setMineMessageVC];
    //进入我的微聊
    //[self setWeTalkVC];
    
    //测试VC
    //[self testVC];
    //首页
    [self setHomePageVC];
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:APPID appKey:APPKEY appSecret:APPSECRET];
    // [2]:注册APNS
    [self registerRemoteNotification];
    // [2-EXT]: 获取启动时收到的APN
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        NSLog(@"record = %@",record);
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    return YES;
}

///注册APNS
- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    // [EXT] 切后台关闭SDK，让SDK第一时间断线，让个推先用APN推送
    [self stopSdk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // [EXT] 重新上线
    [self startSdkWith:_appID appKey:_appKey appSecret:_appSecret];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    [self saveContext];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    //    [_deviceToken release];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", _deviceToken);
    
    
    // [3]:向个推服务器注册deviceToken
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:_deviceToken];
    }
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:@""];
    }
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    NSLog(@"record = %@",record);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
    NSLog(@"record = %@",record);
    
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.iwind.Bangke_IOS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Bangke_IOS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Bangke_IOS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)anchorLeft
{
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
}

-(void)handlePan:(UIPanGestureRecognizer *)reg
{
      NSLog(@"拖动");
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];

//    CGPoint touchLocation = [reg locationInView:reg.view];
//    NSLog(@"%f",touchLocation.x);
//    if (touchLocation.x < 20) {
//        
//    }
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    CGPoint touchLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
//    NSLog(@"%f",touchLocation.x);
//    if (touchLocation.x < 50) {
//        return YES;
//
//    }
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    NSLog(@"%@",touch.view);
    CGPoint touchLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if ([touch.view isKindOfClass:[UIView class]]) {
        return YES;
    }
    return NO;

}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, kMainScreenWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
///我的信息
- (void)setMineMessageVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MineMessageViewController * messageVC = [[MineMessageViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:messageVC];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}
///我的微聊
- (void)setWeTalkVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    WeTalkListViewController * weTalkVC = [[WeTalkListViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:weTalkVC];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}
///测试VC
- (void)testVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    OrderDetail_AViewController * testVC = [[OrderDetail_AViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:testVC];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}

///登陆VC
- (void)setLoginVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}

- (void)setHomePageVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LeftMenuViewController * leftVC = [[LeftMenuViewController alloc]init];
    UINavigationController * leftNavi = [[UINavigationController alloc]initWithRootViewController:leftVC];
    HomePageViewController * homeVC = [[HomePageViewController alloc]init];
    self.homeNavi = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.slidingViewController = [[ECSlidingViewController alloc]initWithTopViewController:self.homeNavi];
    if ([UserInfoTool getToken].length > 0) {
        [self.homeNavi.view addGestureRecognizer:self.slidingViewController.panGesture];
    }else{
    
    }
    
    
    // configure anchored layout
    if (kMainScreenWidth == 320) {
        self.slidingViewController.anchorRightPeekAmount  = 40.0;
    }else if (kMainScreenWidth == 375) {
        self.slidingViewController.anchorRightPeekAmount  = 80.0;
    }else{
        self.slidingViewController.anchorRightPeekAmount  = 80.0;
    }
    
//    self.slidingViewController.anchorLeftRevealAmount = 250.0;
    self.slidingViewController.underLeftViewController = leftNavi;
    self.window.rootViewController = self.slidingViewController;
    [self.window makeKeyAndVisible];
}
///环信账户登录
- (void)easeMobLogin
{
    
    //测试账户
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"52bangke#bangketest" apnsCertName:nil];
//    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"test1" password:@"123456" completion:^(NSDictionary *loginInfo, EMError *error) {
//        NSLog(@"-------- loginInfo = %@",loginInfo);
//    } onQueue:nil];
}

#pragma mark - Push server
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher) {
        _sdkStatus = SdkStatusStopped;
        
        self.appID = appID;
        self.appKey = appKey;
        self.appSecret = appSecret;
        
        //        [_clientId release];
        _clientId = nil;
        
        NSError *err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:_appID
                                             appKey:_appKey
                                          appSecret:_appSecret
                                         appVersion:@"1.0.0"
                                           delegate:self
                                              error:&err];
        if (!_gexinPusher) {
            NSLog(@"err = %@",[err localizedDescription]);
        } else {
            _sdkStatus = SdkStatusStarting;
        }
        
        //        [_viewController updateStatusView:self];
        NSLog(@"PushStatus:%u",_sdkStatus);
    }
    
}

- (void)stopSdk
{
    if (_gexinPusher) {
        [_gexinPusher destroy];
        //        [_gexinPusher release];
        _gexinPusher = nil;
        
        _sdkStatus = SdkStatusStopped;
        
        //        [_clientId release];
        _clientId = nil;
        
        //        [_viewController updateStatusView:self];
    }
}

- (BOOL)checkSdkInstance
{
    if (!_gexinPusher) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"SDK未启动" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        //        [alertView release];
        return NO;
    }
    return YES;
}

- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSdkInstance]) {
        return;
    }
    
    [_gexinPusher registerDeviceToken:aToken];
}

- (BOOL)setTags:(NSArray *)aTags error:(NSError **)error
{
    if (![self checkSdkInstance]) {
        return NO;
    }
    
    return [_gexinPusher setTags:aTags];
}

- (NSString *)sendMessage:(NSData *)body error:(NSError **)error {
    if (![self checkSdkInstance]) {
        return nil;
    }
    
    return [_gexinPusher sendMessage:body error:error];
}

- (void)bindAlias:(NSString *)aAlias {
    if (![self checkSdkInstance]) {
        return;
    }
    
    return [_gexinPusher bindAlias:aAlias];
}

- (void)unbindAlias:(NSString *)aAlias {
    if (![self checkSdkInstance]) {
        return;
    }
    
    return [_gexinPusher unbindAlias:aAlias];
}

//- (void)testSdkFunction
//{
//    UIViewController *funcsView = [[TestFunctionController alloc] initWithNibName:@"TestFunctionController" bundle:nil];
//    [_naviController pushViewController:funcsView animated:YES];
//    [funcsView release];
//}

//- (void)testSendMessage
//{
//    UIViewController *sendMessageView = [[SendMessageController alloc] initWithNibName:@"SendMessageController" bundle:nil];
//    [_naviController pushViewController:sendMessageView animated:YES];
//    [sendMessageView release];
//}

//- (void)testGetClientId {
//    NSString *clientId = [_gexinPusher clientId];
//
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前的CID" message:clientId delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alertView show];
//    [alertView release];
//}
#pragma mark - GexinSdkDelegate
///获取cid
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    
    //创建GexinSdk对象后，SDK会自动向个推服务器注册SDK，当成功注册时，SDK通知应用注册成功。
    NSLog(@"clientId = %@",clientId);
    // [4-EXT-1]: 个推SDK已注册
    _sdkStatus = SdkStatusStarted;
    if ([clientId isEqualToString:[UserInfoTool getGeXinClientID]]) {
        
    }else{
        //删除原有cid
        [UserInfoTool deleteGeXinClientID];
        //存储新cid
        [UserInfoTool saveGeXinClientID:clientId];
        //发送新cid给后台
//        AFNHttpTools requestWithUrl:@"partner/bingGeXinAppClient" successed:^(NSDictionary *dict) {
//            <#code#>
//        } failed:^(NSError *err) {
//            <#code#>
//        } andKeyVaulePairs:(NSString *), ..., nil
        
        
    }
    
    [UserInfoTool saveGeXinClientID:clientId];
    //    [_clientId release];
    _clientId = clientId;
    //    [_viewController updateStatusView:self];
    
    //    [self stopSdk];
}
- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    //    [_payloadId release];
    NSLog(@"payloadId = %@",payloadId);
    NSLog(@"appId = %@",appId);
    
    _payloadId = payloadId;
    
    NSData *payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
    }
    NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++_lastPaylodIndex, [NSDate date], payloadMsg];
    NSLog(@"record = %@",record);
    //    [payloadMsg release];
}

- (void)GexinSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"record = %@",record);
    //    [_viewController logMsg:record];
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"err = %@",[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]);
    //    [_viewController logMsg:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]];
}
#pragma mark - 支付宝回跳
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    
    return YES;
}




@end
