

#import "WLCargoTrackRowsCell.h"

@interface WLCargoTrackRowsCell ()


@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation WLCargoTrackRowsCell

+ (instancetype) cellWithModel:(NSDictionary *)model ReuseIdentifier:(NSString *)reuseIdentifier; {
    WLCargoTrackRowsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WLCargoTrackRowsCell" owner:nil options:nil] lastObject];
    
    cell.timeLabel.text = [model valueForKey:@""];
    cell.cityLabel.text = [model valueForKey:@""];
    cell.addressLabel.text = [model valueForKey:@""];
    
    return cell;
}

@end
