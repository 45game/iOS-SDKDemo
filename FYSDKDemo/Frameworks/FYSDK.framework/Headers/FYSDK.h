#import <UIKit/UIKit.h>
#import "FYOrder.h"
#import "FYUser.h"
#import "FYRole.h"




//! Project version number for FYSDK.
FOUNDATION_EXPORT double FYSDKVersionNumber;

//! Project version string for FYSDK.
FOUNDATION_EXPORT const unsigned char FYSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FYSDK/PublicHeader.h>

typedef NS_ENUM(NSInteger, FYPayCode) {
    FYPayCreateOrderFail      = 1,    //创建订单失败
    FYPayDoesNotExistProduct  = 2,    //商品信息不存在
    FYPayUnknowFail           = 3,    //未知错误
    FYPayVerifyReceiptSucceed = 4,    //支付验证成功
    FYPayVerifyReceiptFail    = 5,    //支付验证失败
    FYPayURLFail              = 6     //未能连接苹果商店
};

typedef NS_ENUM(NSInteger, FYLoginSuccessSource) {
    FYLoginSuccessByLogin      = 1,    //登陆成功来源
    FYLoginSuccessByRegister   = 2,    //注册成功来源
};


typedef void (^loginSuccessBlock)(FYUser *user, FYLoginSuccessSource loginSuccessSource);
typedef void (^logoutBlock)(void);
typedef void (^payViewCloseBlock)(void);
typedef void (^createOrderBlock)(FYPayCode payCode);

@interface FYSDK : NSObject

/**
 *  游戏编号
 */
@property (nonatomic, readonly, assign) int gameId;

/**
 *  游戏渠道
 */
@property (nonatomic, readonly, assign) int subGameId;

/**
 *  游戏密钥
 */
@property (nonatomic, readonly, strong) NSString *secretKey;

/**
 *  登陆成功后当前用户信息
 */
@property (nonatomic, strong, readonly) FYUser *currUser;
@property (nonatomic, copy) loginSuccessBlock loginSuccessBlock;
@property (nonatomic, copy) logoutBlock logoutBlock;
@property (nonatomic, copy) payViewCloseBlock payViewCloseBlock;
@property (nonatomic, copy) createOrderBlock createOrderBlock;
/**
 *  获取FYSDK单例
 *
 *  @return FYSDK单例对象
 */
+ (FYSDK *)sharedFYSDK;

/**
 *  获取SDK版本号 eg:1.0.0 三段
 */
- (NSString *)fySDKVersion;


/**
 *  初始化SDK
 *
 *  @param gameId    游戏编号
 *  @param subGameId 游戏子包
 *  @param secretKey 游戏密钥
 *  @param ryAppId 热云运营ID
 *  @param secretKey 热云广告KEY
 *  @param ryChannelID 渠道ID
 */
- (void)fyInitWithSDKParameters:(int)gameId subGameId:(int)subGameId secretKey:(NSString *)secretKey
                        ryAppId:(NSString *)ryAppId ryKey:(NSString *)ryKey ryChannelID:(NSString *)ryChannelID;


/**
 *   用户登陆
 *
 */
- (void)fyLogin;


/**
 *  支付
 *
 *  @param order    订单信息
 */
- (void)fyPay:(FYOrder *)order;


/**
 *  注销用户登陆接口
 */
- (void)fyLogout;

/**
 *  用户中心
 */
- (void)fyCenter;

/**
 *  初始化SDK
 *
 *  @param role    游戏角色
 */
- (void)fyReportRole:(FYRole *)role;


/**
 *  注销事件回调
 */
- (void)setLogoutBlock:(logoutBlock)logoutBlock;


/**
 *  登陆成功回调
 */
- (void)setLoginSuccessBlock:(loginSuccessBlock)loginSuccessBlock;

/**
 *  支付页面关闭回调
 */
- (void)setPayViewCloseBlock:(payViewCloseBlock)payViewCloseBlock;


/**
 *  IAP支付回调
 */
- (void)setCreateOrderBlock:(createOrderBlock)createOrderBlock;



- (void)fyShowFloat;


- (void)fyDissmissFloat;
@end
