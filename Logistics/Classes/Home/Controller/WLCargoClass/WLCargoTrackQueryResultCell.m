
#import "WLCargoTrackQueryResultCell.h"


@interface WLCargoTrackQueryResultCell ()

@property (nonatomic, assign) CellStyle cellStyle;


@property (nonatomic, strong) UILabel *topTitleLabel;

@property (nonatomic, strong) UIImageView *middleQRImageView;


// ----


@property (nonatomic, strong) UILabel *inputCargoInfoLab;

@property (nonatomic, strong) UILabel *inputCargoNumLab;

@property (nonatomic, strong) UILabel *inputCargoOrderLab;

@property (nonatomic, strong) UILabel *inputCargoTypeLab;

@property (nonatomic, strong) UILabel *outputCargoInfoLab;

@property (nonatomic, strong) UILabel *outputCargoNumLab;

@property (nonatomic, strong) UILabel *outputCargoOrderLab;

@property (nonatomic, strong) UILabel *outputCargoTypeLab;


// ----

@end

@implementation WLCargoTrackQueryResultCell

+ (instancetype) cellWithCellStyle:(CellStyle)style WithModel:(NSDictionary *)model ReuseIdentifier:(NSString *)reuseIdentifier; {
    switch (style) {
        case CellStyle_Default:
        {
            WLCargoTrackQueryResultCell *cell = [[WLCargoTrackQueryResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.cellStyle = style;
            return cell;
        }
            break;
        case CellStyle_Result:
        {
            WLCargoTrackQueryResultCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WLCargoTrackQueryResultCell" owner:nil options:nil] lastObject];
            
            if ([[model valueForKey:@"state"] isEqualToString:@"success"]) {
                NSArray *dataArr = [model valueForKey:@"data"];
                
                NSDictionary *dict1 = [NSDictionary dictionaryWithDictionary:dataArr.firstObject];
                cell.inputCargoInfoLab.text = [dict1 valueForKey:@""];
                cell.inputCargoNumLab.text = [dict1 valueForKey:@""];
                cell.inputCargoOrderLab.text = [dict1 valueForKey:@""];
                cell.inputCargoTypeLab.text = [dict1 valueForKey:@""];
                NSDictionary *dict2 = [NSDictionary dictionaryWithDictionary:dataArr.lastObject];
                cell.outputCargoInfoLab.text = [dict2 valueForKey:@""];
                cell.outputCargoNumLab.text = [dict2 valueForKey:@""];
                cell.outputCargoOrderLab.text = [dict2 valueForKey:@""];
                cell.outputCargoTypeLab.text = [dict2 valueForKey:@""];
            }
            
            return cell;
        }
            break;
    }
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.topTitleLabel = [[UILabel alloc] init];
        self.topTitleLabel.font = [UIFont systemFontOfSize:14];
        self.topTitleLabel.textColor = [UIColor blackColor];
        self.topTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.topTitleLabel];
        
        switch (self.cellStyle) {
            case CellStyle_Default:
            {
                self.topTitleLabel.text = @"点击下图扫描运单条形码";
                [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_top).offset(8);
                    make.left.equalTo(self.contentView.mas_left).offset(8);
                    make.height.mas_equalTo(22);
//                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
                    make.right.equalTo(self.contentView.mas_right).offset(-16);
                }];
                self.middleQRImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wlqrimg"]];
                [self.contentView addSubview:self.middleQRImageView];
                [self.middleQRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.topTitleLabel.mas_bottom);
                    make.left.equalTo(self.contentView.mas_left).offset(16);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
                    make.right.equalTo(self.contentView.mas_right).offset(-16);
                }];
            }
                break;
            case CellStyle_Result:
            {
                
                
                
            }
                break;
        }
    }
    return self;
}

@end
