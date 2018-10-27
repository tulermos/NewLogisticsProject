
#import "WLCargoTrackInputQueryCell.h"

#import "WLCargoTrackModel.h"

#import "Masonry.h"

@interface WLCargoTrackInputQueryCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *orderTextField;

@end

@implementation WLCargoTrackInputQueryCell

+ (instancetype) cellWithReuseIdentifier:(NSString *)reuseIdentifier; {
    WLCargoTrackInputQueryCell *cell = [[WLCargoTrackInputQueryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.orderTextField = [[UITextField alloc] init];
        self.orderTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.orderTextField.backgroundColor = [UIColor whiteColor];
        self.orderTextField.delegate = self;
        self.orderTextField.placeholder = @"请输入货号/手机号/单号";
        self.orderTextField.font = [UIFont systemFontOfSize:15];
        self.orderTextField.returnKeyType = UIReturnKeySearch;
        [self.contentView addSubview:self.orderTextField];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"搜索-关闭"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.orderTextField.rightView = closeBtn;
        UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Shape"]];
        self.orderTextField.leftView = searchImg;
        self.orderTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [queryBtn addTarget:self action:@selector(queryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:queryBtn];
        
        [self.orderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(queryBtn.mas_left).offset(-20);
            make.height.mas_equalTo(28);
        }];
        
        [queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderTextField.mas_top);
            make.left.equalTo(self.orderTextField.mas_right).offset(20);
            make.bottom.equalTo(self.orderTextField.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.equalTo(self.orderTextField.mas_height);
        }];
    }
    return self;
}

- (void) closeBtnAction:(UIButton *)sender {
    self.orderTextField.text = @"";
    [self.orderTextField endEditing:YES];
    [self.orderTextField resignFirstResponder];
}

- (void) queryBtnAction:(UIButton *)sender {
    [self.orderTextField endEditing:YES];
    [self.orderTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(WLCargoTrackInputQueryCellDelegateModel:)]) {
        if (self.orderTextField.text && self.orderTextField.text.length) {
            [self.delegate WLCargoTrackInputQueryCellDelegateModel:@{@"orderStr":self.orderTextField.text}];
        }else{
            [FCProgressHUD showText:@"请输入货号/单号/手机号"];
        }
    }
}

@end
