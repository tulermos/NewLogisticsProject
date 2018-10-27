

#import "WLCargoTrackRowsCell.h"

@interface WLCargoTrackRowsCell ()


@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;


@end

@implementation WLCargoTrackRowsCell

+ (instancetype) cellWithModel:(NSDictionary *)model ReuseIdentifier:(NSString *)reuseIdentifier; {
    WLCargoTrackRowsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WLCargoTrackRowsCell" owner:nil options:nil] lastObject];
    
    cell.timeLabel.text = [model valueForKey:@"Date"];
    cell.cityLabel.text = [model valueForKey:@"Station"];
    cell.addressLabel.text = [model valueForKey:@"Operation"];
    
    return cell;
}

@end
