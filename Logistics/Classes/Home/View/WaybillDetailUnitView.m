//
//  WaybillDetailUnitView.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillDetailUnitView.h"

@interface WaybillDetailUnitView ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, strong)MASConstraint *bottomConstraint;
@property (nonatomic, assign)CGFloat width;

@end

@implementation WaybillDetailUnitView

+ (instancetype)unitViewWithTitle:(NSString *)title detail:(NSString *)detail defaultWidth:(CGFloat)width {
    WaybillDetailUnitView *unitView = [[WaybillDetailUnitView alloc]init];
    unitView.width = width;
    [unitView setupLayout];
    [unitView setupTitle:title detail:detail];
    return unitView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x999999] text:nil];
    self.detailLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
    _detailLabel.numberOfLines = 0;
    _titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
}

- (void)setupLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.leading.mas_equalTo(self);
        make.width.mas_equalTo(_width * 0.5 - 40);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading
        .mas_equalTo(_titleLabel.mas_trailing).offset(8);
        make.trailing.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(_titleLabel);
        self.bottomConstraint = make.bottom.mas_equalTo(self);
    }];
}

- (CGFloat)heightForTitle:(NSString *)title width:(CGFloat)width {
    return ceilf([NSString sizeWithText:title font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(width, MAXFLOAT)].height);
}

- (void)setupTitle:(NSString *)title detail:(NSString *)detail {
    self.titleLabel.text = title;
    if ([detail isKindOfClass:[NSAttributedString class]]) {
        self.detailLabel.attributedText = (NSAttributedString *)detail;
        detail = ((NSAttributedString *)detail).string;
    }else {
        self.detailLabel.text = detail;
    }
    CGFloat titleWidth = _width * 0.5 - 40;
    CGFloat titleHeight = [self heightForTitle:title width:titleWidth];
    CGFloat detailWidth = _width - titleWidth - 35;
    CGFloat detailHeight = [self heightForTitle:detail width:detailWidth];
    [self.bottomConstraint uninstall];
    if (titleHeight >= detailHeight) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            self.bottomConstraint = make.bottom.mas_equalTo(self);
        }];
    }else {
        [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            self.bottomConstraint = make.bottom.mas_equalTo(self);
        }];
    }
}

@end
