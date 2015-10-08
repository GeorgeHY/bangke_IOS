//
//  AppDelegate.h
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ECSlidingViewController.h"
#import "GexinSdk.h"
typedef enum{
    SdkStatusStopped,
    SdkStatusStarting,
    SdkStatusStarted
} SdkStatus;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate>{
@private
    //    UINavigationController *_naviController;
    NSString *_deviceToken;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic ,strong) ECSlidingViewController * slidingViewController;
@property (nonatomic, strong) UINavigationController * homeNavi;

//个推属性
@property (strong, nonatomic) GexinSdk *gexinPusher;

@property (retain, nonatomic) NSString *appKey;
@property (retain, nonatomic) NSString *appSecret;
@property (retain, nonatomic) NSString *appID;
@property (retain, nonatomic) NSString *clientId;
@property (assign, nonatomic) SdkStatus sdkStatus;
@property (assign, nonatomic) int lastPayloadIndex;
@property (retain, nonatomic) NSString *payloadId;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

///返回app代理
+(instancetype)shareInstance;
- (void)setHomePageVC;
- (void)setLoginVC;

#pragma mark - Push Server
///创建个推SDK
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
- (void)stopSdk;

- (void)setDeviceToken:(NSString *)aToken;
- (BOOL)setTags:(NSArray *)aTag error:(NSError **)error;
- (NSString *)sendMessage:(NSData *)body error:(NSError **)error;

- (void)bindAlias:(NSString *)aAlias;
- (void)unbindAlias:(NSString *)aAlias;

//- (void)testSdkFunction;
//- (void)testSendMessage;
//- (void)testGetClientId;


@end

