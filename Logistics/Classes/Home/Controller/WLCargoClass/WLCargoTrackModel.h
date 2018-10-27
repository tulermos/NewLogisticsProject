
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLCargoTrackModel : NSObject

+ (void) requestQueryOrderWithModel:(WLCargoTrackModel *)model
                     SuccessHandle:(void(^)(id responseObject))successCompletion
                              Fail:(void(^)(NSError *error))failHandle;


@property (nonatomic, copy) NSString *orderStr;

@property (nonatomic, copy) NSString *errorStr;

@end

NS_ASSUME_NONNULL_END
