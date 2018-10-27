
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLCargoTrackRowsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *lineImgView;
@property (weak, nonatomic) IBOutlet UIImageView *cornerImgView2;

+ (instancetype) cellWithModel:(NSDictionary *)model ReuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
