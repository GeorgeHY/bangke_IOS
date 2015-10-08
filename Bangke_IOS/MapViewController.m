//
//  MapViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/6.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "MapViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>
#import "MineCommunityViewController.h"
#import "Model_Search.h"
#import "AddCommunityViewController.h"

#define APIKey @"73bd80e73ca442d415160c47e789fd37"

@interface MapViewController () <MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField *  tf;
@property (nonatomic,strong) MAMapView * mapView;
@property (nonatomic,strong) AMapSearchAPI * mapSearch;
@property (nonatomic, strong)CLLocation * currentLocation;
@property (nonatomic, strong) NSArray * poisArr;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * annotations;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) UILabel * addressDis;//地址显示条
@property (nonatomic, strong) CurrentLocation * curLocation;//返回位置信息


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 1;
    [self createUI];
    [self initMapView];
    [self initAttributes];
    //[self initTableView];
//    NSLog(@"latitude = %@",[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude]);
//    NSLog(@"longitude = %@",[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude]);
//    [self getCommunityListWithLatitude:[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude]];

    
    
}

#pragma mark - init

- (void)createUI
{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar * naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    [naviBar setBarTintColor:[UIColor blackColor]];
    [self.view addSubview:naviBar];
//    self.tf = [[UITextField alloc]initWithFrame:CGRectMake((kMainScreenWidth * 0.4)/2, kStatusBarHeight,kMainScreenWidth * 0.6,40)];
    self.tf = [[UITextField alloc]initWithFrame:CGRectMake((kMainScreenWidth * 0.4)/2, kStatusBarHeight, kMainScreenWidth*0.6,40)];
//    [self.tf showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tf.placeholder = @"请输入您的位置";
    self.tf.delegate = self;
    self.tf.backgroundColor = [UIColor whiteColor];
    self.tf.layer.masksToBounds = YES;
    self.tf.layer.cornerRadius = 5;
    self.tf.layer.borderWidth = 1;
    self.tf.layer.borderColor = [[UIColor orangeColor]CGColor];
    //[naviBar addSubview:self.tf];
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    [naviBar addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"箭头17px_03"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tf.frame) + 10, kStatusBarHeight, 44, 44)];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:rightBtn];
}

- (void)initMapView
{
    WEAK_SELF(weakSelf);
    [MAMapServices sharedServices].apiKey = APIKey;
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight - 64)];
    //[self.mapView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;
    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 20);
    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 20);
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:17.5 animated:YES];
    UIImageView * pinIV = [UIImageView new];
    [self.mapView addSubview:pinIV];
    [pinIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mapView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(31), RECTFIX_HEIGHT(43)));
        make.centerY.mas_equalTo(weakSelf.mapView.mas_centerY).with.offset(RECTFIX_HEIGHT(-21));
    }];
    pinIV.image = [UIImage imageNamed:@"map"];
    

    //定位btn
    UIButton * userLocal = [[UIButton alloc]initWithFrame:CGRectMake(10, self.mapView.frame.size.height - 66, 36, 36)];
    [self.mapView addSubview:userLocal];
//    [userLocal setTitle:@"定位" forState:UIControlStateNormal];
    [userLocal setImage:[UIImage imageNamed:@"组 1"] forState:UIControlStateNormal];
    [userLocal addTarget:self action:@selector(userLocalAction:) forControlEvents:UIControlEventTouchUpInside];
    self.mapSearch = [[AMapSearchAPI alloc]initWithSearchKey:APIKey Delegate:self];
    //点击定位手势
    UILongPressGestureRecognizer *Lpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressClick:)];
    Lpress.delegate = self;
    Lpress.minimumPressDuration = 1.0;//1.0秒响应方法
    Lpress.allowableMovement = 50.0;
    [self.mapView addGestureRecognizer:Lpress];
    
    //地址显示条
    self.addressDis = [UILabel new];
    [self.mapView addSubview:self.addressDis];
    [self.addressDis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mapView.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.mapView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.mapView.mas_bottom).with.offset(RECTFIX_HEIGHT(-20));
        make.height.equalTo(@(RECTFIX_HEIGHT(20)));
    }];
    self.addressDis.backgroundColor = [UIColor blackColor];
    self.addressDis.alpha = 0.5;
    self.addressDis.hidden = YES;
    self.addressDis.textAlignment = NSTextAlignmentCenter;
    self.addressDis.textColor = [UIColor orangeColor];
    
    
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mapView.frame), kMainScreenWidth, kMainScreenHeight- CGRectGetMaxY(self.mapView.frame))];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}




- (void)initAttributes
{
    self.annotations = [NSMutableArray array];
    self.poisArr = nil;
}

#pragma mark - Action

- (void)confirmAction
{
    NSLog(@"确认");
    
    NSLog(@"self.curLocation.address = %@",self.curLocation.address);
    NSLog(@"self.curLocation.address = %@",self.curLocation.latitude);
    NSLog(@"self.curLocation.address = %@",self.curLocation.longitude);
    
    self.currentAddress(self.curLocation);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAction
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userLocalAction:(UIButton *)btn
{
    if (self.mapView.userTrackingMode != MAUserTrackingModeFollow) {
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        //搜索5公里内社区
        

        //[self searchAction];
    }
}
- (void)reGeoAction
{

    if (self.currentLocation) {
        AMapReGeocodeSearchRequest * request = [[AMapReGeocodeSearchRequest alloc]init];
        request.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
        [self.mapSearch AMapReGoecodeSearch:request];
    }
    
}
- (void)searchAction
{
//    NSLog(@"搜索");
//    if (self.currentLocation == nil || self.mapSearch == nil) {
//        NSLog(@"搜索失败");
//        return;
//    }
//    AMapPlaceSearchRequest * request = [[AMapPlaceSearchRequest alloc]init];
//    request.searchType = AMapSearchType_PlaceAround;
//    request.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
//    if (self.tf.text.length > 0) {
//        request.keywords = self.tf.text;
//    }else{
//        request.keywords = @"";
//    }
//    NSLog(@"request = %@",request);
//    [self.mapSearch AMapPlaceSearch:request];
}

///5公里内社区
- (void)getCommunityListWithLatitude:(NSString *)latitude
                        andLongitude:(NSString *)longitude
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"community/query5Community" successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Search * searchModel = [[Model_Search alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            weakSelf.poisArr = searchModel.responseText;
            [weakSelf.tableView reloadData];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    } andKeyVaulePairs:@"latitude",latitude,@"longitude",longitude, nil];
}

- (void)LongPressClick:(UIGestureRecognizer *)gesture
{
//    NSLog(@"长按手势");
//
//    //[view setSelected:NO animated:YES];
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        if (self.curAnnotation && ![self.curAnnotation isKindOfClass:[NSNull class]]) {
//            [self.mapView removeAnnotation:self.curAnnotation];
//        }
//        CGPoint touchPoint = [gesture locationInView:self.mapView];
//        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
//        CLLocation * local = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
//        self.longPressLoc = local;
//        //[self reGeoAction];
//        MAPointAnnotation * pointAnno = [[MAPointAnnotation alloc]init];
//        pointAnno.coordinate = touchMapCoordinate;
//        //pointAnno.title =
//        self.curAnnotation = pointAnno;
//        
//        [self.mapView addAnnotation:pointAnno];
    
        
        //[self searchReGeocodeWithCoordinate:touchMapCoordinate];
        
//    }
}

#pragma mark 长按手势标注地图
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
//    NSLog(@"searchReGeocodeWithCoordinate");
//    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    
//    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    regeo.requireExtension = YES;
//    //regeo.radius = 100;
//    regeo.searchType = AMapSearchType_ReGeocode;
//    CLLocation * local = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    self.longPressLoc = local;
//    //egeoRequest.requireExtension = YES;
//    
//    [self.mapSearch AMapReGoecodeSearch:regeo];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    self.addressDis.hidden = YES;
}


- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"地图区域改变调用");
    CGPoint mapCenter = self.mapView.center;
    CLLocationCoordinate2D convertCoordinate = [self.mapView convertPoint:mapCenter toCoordinateFromView:self.mapView];
    AMapReGeocodeSearchRequest * regeo = [[AMapReGeocodeSearchRequest alloc]init];
    regeo.location = [AMapGeoPoint locationWithLatitude:convertCoordinate.latitude longitude:convertCoordinate.longitude];
    [self.mapSearch AMapReGoecodeSearch:regeo];
    
}


- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{   self.flag ++;
    self.currentLocation = userLocation.location;
    if (self.flag == 2) {
        NSLog(@"latitude = %@",[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude]);
        NSLog(@"longitude = %@",[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude]);
//        [self getCommunityListWithLatitude:[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude]];
    }
    
    //[self searchAction];
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.0];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }else{
        view.canShowCallout = NO;;
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
//    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
//        NSLog(@"self.currentLocation.coordinate.latitude = %f",self.currentLocation.coordinate.latitude);
//        if (self.curAnnotation && ![self.curAnnotation isKindOfClass:[NSNull class]]) {
//            [self.mapView removeAnnotation:self.curAnnotation];
//        }
//        [self reGeoAction];
//    }else{
//        AMapReGeocodeSearchRequest * request = [[AMapReGeocodeSearchRequest alloc]init];
//        request.location = [AMapGeoPoint locationWithLatitude:self.longPressLoc.coordinate.latitude longitude:self.longPressLoc.coordinate.longitude];
//        [self.mapSearch AMapReGoecodeSearch:request];
//    }
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString * reuseIdentifier = @"annotationReuseIdentifier";
        MAPinAnnotationView * annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        if (!annotationView) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
        
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    return nil;
}




#pragma mark - AMapSearchDelegate
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"错误");
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"------ response = %@",response);
    NSLog(@"------ request = %@",request);

    NSString * title = response.regeocode.addressComponent.city;
    if (title.length == 0) {
        title = response.regeocode.addressComponent.province;
    }
//    self.mapView.userLocation.title = title;
//    self.mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    self.addressDis.text = response.regeocode.formattedAddress;
    self.addressDis.hidden = NO;
    self.curLocation = [[CurrentLocation alloc]init];
    self.curLocation.address = response.regeocode.formattedAddress;
    self.curLocation.latitude = [NSString stringWithFormat:@"%lf",response.regeocode.addressComponent.streetNumber.location.latitude];
    self.curLocation.longitude = [NSString stringWithFormat:@"%lf",response.regeocode.addressComponent.streetNumber.location.longitude];
    NSLog(@"%@",self.curLocation);
    
}
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    NSLog(@"request = %@",request);
    NSLog(@"response = %@",response);
    
//    if (response.pois.count > 0) {
//        self.poisArr = response.pois;
//        [self.tableView reloadData];
//        
//        //清空标注
//        [self.mapView removeAnnotations:self.annotations];
//        [self.annotations removeAllObjects];
//        
//    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poisArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    Model_SearchCommunity * model = self.poisArr[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.descrip;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddCommunityViewController * addCommunityVC = [[AddCommunityViewController alloc]init];
    Model_SearchCommunity * model = self.poisArr[indexPath.row];
    addCommunityVC.currentAddCommunity = model;
    addCommunityVC.type = 3;
    [self.navigationController pushViewController:addCommunityVC animated:YES];
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    //为点击的poi点添加标注
//    AMapPOI * poi = self.poisArr[indexPath.row];
//    MAPointAnnotation * annotation = [[MAPointAnnotation alloc]init];
//    annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
//    annotation.title = poi.name;
//    annotation.subtitle = poi.address;
//    [self.annotations addObject:annotation];
//    [self.mapView addAnnotation:annotation];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[self searchAction];
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark block返回当前地址
-(void)returnAddress:(Callback)address
{
    if (address) {
        self.currentAddress = address;
    }
}

@end
