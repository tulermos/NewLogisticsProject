//
//  WaybillDetailPartView.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillDetailPartView.h"
#import "WaybillDetailUnitView.h"

@interface WaybillDetailPartView ()

@property (nonatomic, strong)NSMutableArray *unitViews;

@end

@implementation WaybillDetailPartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.unitViews = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)partViewWithTitles:(NSArray *)titles details:(NSArray *)details width:(CGFloat)width{
    WaybillDetailPartView *partView = [[WaybillDetailPartView alloc]init];
    NSInteger index = 0;
    for (NSString *title in titles) {
        WaybillDetailUnitView *unitView = [WaybillDetailUnitView unitViewWithTitle:title detail:details[index] defaultWidth:width];
        [partView addSubview:unitView];
        [partView.unitViews addObject:unitView];
        index++;
    }
    [partView setupLayout];
    return partView;
}

- (void)setupLayout {
    
    UIView *lastView = self;
    for (WaybillDetailUnitView *unitView in self.unitViews) {
        [unitView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([lastView isEqual:self]) {
                make.top.mas_equalTo(self);
            }else {
                make.top
                .mas_equalTo(lastView.mas_bottom).offset(13);
            }
            make.leading.trailing.mas_equalTo(self);
            if ([unitView isEqual:self.unitViews.lastObject]) {
                make.bottom.mas_equalTo(self);
            }
        }];
        lastView = unitView;
    }
}

@end
