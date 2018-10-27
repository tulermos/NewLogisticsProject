
#import "WLCargoTrackQueryResultCell.h"


@interface WLCargoTrackQueryResultCell ()

@property (nonatomic, assign) CellStyle cellStyle;


@property (nonatomic, strong) UILabel *topTitleLabel;

@property (nonatomic, strong) UIImageView *middleQRImageView;


// ----


//@property (nonatomic, weak) IBOutlet UILabel *inputCargoInfoLab;

@property (nonatomic, weak) IBOutlet UILabel *inputCargoNumLab;

@property (nonatomic, weak) IBOutlet UILabel *inputCargoOrderLab;

@property (nonatomic, weak) IBOutlet UILabel *inputCargoTypeLab;

//@property (nonatomic, weak) IBOutlet UILabel *outputCargoInfoLab;

@property (nonatomic, weak) IBOutlet UILabel *outputCargoNameLab;

@property (nonatomic, weak) IBOutlet UILabel *outputCargoOrderLab;

@property (nonatomic, weak) IBOutlet UILabel *outputCargoAddreessLab;


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
            
            NSDictionary *dict1 = [NSDictionary dictionaryWithDictionary:model];
//                cell.inputCargoInfoLab.text = [dict1 valueForKey:@""];
            cell.inputCargoNumLab.text = [dict1 valueForKey:@"billNumber"];
            cell.inputCargoOrderLab.text = [dict1 valueForKey:@"billCode"];
            cell.inputCargoTypeLab.text = [dict1 valueForKey:@"pathType"];
//            cell.outputCargoInfoLab.text = [dict1 valueForKey:@""];
            cell.outputCargoNameLab.text = [dict1 valueForKey:@"recName"];
            if (![[dict1 valueForKey:@"recPhone"] isKindOfClass:[NSNull class]]) {
                cell.outputCargoOrderLab.text = [dict1 valueForKey:@"recPhone"];
            }else {
                cell.outputCargoOrderLab.text = @"无";
            }
            cell.outputCargoAddreessLab.text = [dict1 valueForKey:@"recAddress"];
            
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
                self.middleQRImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"条形码"]];
                [self.contentView addSubview:self.middleQRImageView];
                [self.middleQRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.topTitleLabel.mas_bottom).offset(10);
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
