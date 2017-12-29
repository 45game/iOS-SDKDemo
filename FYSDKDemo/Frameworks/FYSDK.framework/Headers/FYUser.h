#import <Foundation/Foundation.h>

@interface FYUser : NSObject


/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *userId;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  会话ID
 */
@property (nonatomic, strong) NSString *accessToken;




@end
