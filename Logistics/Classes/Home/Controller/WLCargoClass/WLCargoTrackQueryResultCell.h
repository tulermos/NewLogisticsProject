
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger) {
    CellStyle_Default = 0,
    CellStyle_Result
}CellStyle;

@interface WLCargoTrackQueryResultCell : UITableViewCell

+ (instancetype) cellWithCellStyle:(CellStyle)style WithModel:(NSDictionary *)model ReuseIdentifier:(NSString *)reuseIdentifier;



@end
