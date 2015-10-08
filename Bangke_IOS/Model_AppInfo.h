//
//  Model_AppInfo.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/26.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_AppInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * platform_name;//平台类型
@property (nonatomic, strong) NSString<Optional> * platform_number;//平台号
@property (nonatomic, strong) NSString<Optional> * version_number;//版本号
@property (nonatomic, strong) NSString<Optional> * version_desc;//版本描述
@property (nonatomic, strong) NSString<Optional> * app_name;//app名称
@property (nonatomic, strong) NSString<Optional> * download_url;
@property (nonatomic, strong) NSString<Optional> * real_download_url;//下载地址
@property (nonatomic, strong) NSString<Optional> * publish_state;//发布状态
@property (nonatomic, strong) NSString<Optional> * download_count;
@property (nonatomic, strong) NSString<Optional> * app_size;//app大小
@property (nonatomic, strong) NSString<Optional> * update_type;
@property (nonatomic, strong) NSString<Optional> * create_time;
@property (nonatomic, strong) NSString<Optional> * appinstall_name;




@end
