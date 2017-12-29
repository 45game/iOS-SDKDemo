#import "FYViewController.h"
#import <FYSDK/FYSDK.h>


@interface FYViewController ()
{
    UIImageView *_bgImageView;
}
@end

@implementation FYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIImageView *bgImageView = [UIImageView new];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [bgImageView setImage:[UIImage imageNamed:@"BG1_L"]];
    }
    else
    {
        [bgImageView setImage:[UIImage imageNamed:@"BG1"]];
    }
    [bgImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:bgImageView];
    _bgImageView = bgImageView;
    
    
    UIImage *buttonImage = [UIImage imageNamed:@"Button_Normal"];
    UIImage *buttonImageHighlighted = [UIImage imageNamed:@"Button_Highlighted"];
    UIButton *loginButton = [UIButton new];
    [loginButton setFrame:CGRectMake(140, 40, 100, 36)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImageHighlighted forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    UIButton *payButton = [UIButton new];
    [payButton setFrame:CGRectMake(140, 100, 100, 36)];
    [payButton setTitle:@"买个表" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    UIButton *logOutButton = [UIButton new];
    [logOutButton setFrame:CGRectMake(140, 160, 100, 36)];
    [logOutButton setTitle:@"注 销" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(logOutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutButton];
    
    
    UIButton *centerButton = [UIButton new];
    [centerButton setFrame:CGRectMake(140, 220, 100, 36)];
    [centerButton setTitle:@"用户中心" forState:UIControlStateNormal];
    [centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [centerButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerButton];
    
    [[FYSDK sharedFYSDK] setLogoutBlock:^{
        NSLog(@"注销事件的回调");
    }];
    
    [[FYSDK sharedFYSDK] setCreateOrderBlock:^(FYPayCode payCode) {
        NSLog(@"IAP支付回调 - %ld", (long)payCode);
    }];
    
    [[FYSDK sharedFYSDK] setPayViewCloseBlock:^{
        NSLog(@"支付页面关闭的回调");
    }];
    
    [[FYSDK sharedFYSDK] setLoginSuccessBlock:^(FYUser *user, FYLoginSuccessSource loginSuccessSource) {
        NSString *userId    = user.userId;
        NSString *userName  = user.username;
        NSString *accessToken = user.accessToken;
        NSLog(@"userId      -- %@", userId);
        NSLog(@"userName    -- %@", userName);
        NSLog(@"accessToken -- %@", accessToken);
        if (loginSuccessSource == FYLoginSuccessByLogin) {
            NSLog(@"登陆来源");
        }
        else if (loginSuccessSource == FYLoginSuccessByRegister)
        {
            NSLog(@"注册来源");
        }
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *dateTime = [formatter stringFromDate:date];
        
        
        FYRole *role = [FYRole new];
        [role setServerId:@"serverId1"];
        [role setServerName:@"紫陌红尘"];
        [role setRoleId:@"9527"];
        [role setRoleName:@"凯特琳"];
        [role setRoleLevel:1];
        [role setLoginTime:dateTime];
        [[FYSDK sharedFYSDK] fyReportRole:role];
        
    }];
    
    
}


#pragma mark --支付按钮事件--
- (void)payButtonClick
{
    FYOrder *order = [FYOrder new];
    [order setServerId:@"serverId1"];
    [order setTotalFee:100];
    [order setRoleId:@"1"];
    [order setRoleName:@"角色名称"];
    [order setProductName:@"道具名称"];
    [order setProductDescription:@"道具描述"];
    [order setCpOrderId:[self getOrderStringByTime]];
    [order setCustomInfo:@"自定义参数"];
    [order setProductId:@"com.fy.sdkdemo.1"];
    [[FYSDK sharedFYSDK] fyPay:order];
}


#pragma mark --登陆按钮事件--
- (void)loginButtonClick
{
    
    [[FYSDK sharedFYSDK] fyLogin];
}


- (void)centerButtonClick
{
    [[FYSDK sharedFYSDK] fyCenter];
}


- (void)logOutButtonClick
{
    [[FYSDK sharedFYSDK] fyLogout];
}


- (NSString *)getOrderStringByTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddhhmmssSS"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"order:%@", dateString);
    return dateString;
}





- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_bgImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        [_bgImageView setImage:[UIImage imageNamed:@"BG1"]];
    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [_bgImageView setImage:[UIImage imageNamed:@"BG1_L"]];
    }
}


@end
