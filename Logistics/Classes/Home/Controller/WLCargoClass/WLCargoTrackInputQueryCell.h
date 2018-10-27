

#import <UIKit/UIKit.h>

@protocol WLCargoTrackInputQueryCellDelegate <NSObject>

@required
- (void) WLCargoTrackInputQueryCellDelegateModel:(NSDictionary *)responseObject;

@end

@interface WLCargoTrackInputQueryCell : UITableViewCell

+ (instancetype) cellWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<WLCargoTrackInputQueryCellDelegate> delegate;

@end
