#import <Foundation/Foundation.h>

@interface FYRole : NSObject


/**
 *  服务器Id
 */
@property (nonatomic, strong) NSString *serverId;

/**
 *  服务器名称
 */
@property (nonatomic, strong) NSString *serverName;

/**
 *  角色Id
 */
@property (nonatomic, strong) NSString *roleId;

/**
 *  角色名称
 */
@property (nonatomic, strong) NSString *roleName;

/**
 *  角色等级
 */
@property (nonatomic, assign) NSUInteger roleLevel;

/**
 *  登陆时间
 */
@property (nonatomic, strong) NSString *loginTime;


@end
