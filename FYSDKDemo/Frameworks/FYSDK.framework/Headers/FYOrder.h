#import <Foundation/Foundation.h>

@interface FYOrder : NSObject

/**
 *  金额 单位：分
 */
@property (nonatomic, assign) int totalFee;

/**
 *  订单号
 */
@property (nonatomic, strong) NSString *cpOrderId;

/**
 *  服务器Id
 */
@property (nonatomic, strong) NSString *serverId;

/**
 *  角色Id
 */
@property (nonatomic, strong) NSString *roleId;

/**
 *  角色名称
 */
@property (nonatomic, strong) NSString *roleName;

/**
 *  对应的Apple道具产品Id
 */
@property (nonatomic, strong) NSString *productId;

/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *productName;

/**
 *  商品描述
 */
@property (nonatomic, strong) NSString *productDescription;

/**
 *  自定义信息
 */
@property (nonatomic, strong) NSString *customInfo;

/**
 *  订单信息
 */
@property (nonatomic, strong) NSString *orderInfo;

@end
