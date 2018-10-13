//
//  WaybillDetailTableViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillDetailTableViewCell.h"
#import "WaybillDetailPartView.h"

@interface WaybillDetailTableViewCell()

@property (nonatomic, strong)WaybillDetailPartView *partView;
@property (nonatomic, strong)MASConstraint *bottomConstraint;

@end

@implementation WaybillDetailTableViewCell

- (void)setObj:(id)obj {
    if (obj == _obj) return;
    _obj = obj;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    BOOL isGoods = [obj isKindOfClass:[WaybillGoodsInfoItem class]];
    NSArray *titles = [self titlesWithCellType:obj];
    NSArray *details = [self detailsWithCellType:obj];
    WaybillDetailPartView *partView = [WaybillDetailPartView partViewWithTitles:titles details:details width:!isGoods?(FCWidth - 35):(FCWidth - 50)];
    self.partView = partView;
    [self.contentView addSubview:partView];
    CGFloat leadingOffset = !isGoods?20:35;
    [partView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.leading
        .mas_equalTo(self.contentView).offset(leadingOffset);
        make.trailing.mas_equalTo(self.contentView).offset(-15);
        self.bottomConstraint = make.bottom.mas_equalTo(self.contentView).offset(-15);
    }];
    if (isGoods) {
        [self updateForGoods];
    }
}

- (void)updateForGoods {
    
    WaybillGoodsInfoItem *item = (WaybillGoodsInfoItem *)self.obj;
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = kGlobalMainColor;
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(0.5);
    }];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"xuhao"];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(leftView);
    }];
    
    if (item.isLastObj) return;
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = kGlobalLineColor;
    [self.contentView addSubview:lineView];
    [self.bottomConstraint uninstall];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_partView.mas_bottom).offset(15);
        make.leading.mas_equalTo(_partView);
        make.trailing
        .mas_equalTo(self.contentView).offset(-15);
        make.bottom.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
}

- (NSArray *)titlesWithCellType:(id)obj {
    NSArray *titles = nil;
    if ([obj isKindOfClass:[WaybillSenderItem class]]) {
        titles = @[NSLocalizedString(@"Home_start_station", nil),
                   NSLocalizedString(@"Home_sender_name", nil),
                   NSLocalizedString(@"Home_sender_tel", nil),
                   NSLocalizedString(@"Home_sender_address", nil),
                   NSLocalizedString(@"Home_sender_house", nil)];
    }
    else if ([obj isKindOfClass:[WaybillReceiveItem class]]) {
        titles = @[NSLocalizedString(@"Home_end_station", nil),
                   NSLocalizedString(@"Home_receive_name", nil),
                   NSLocalizedString(@"Home_receive_tel", nil),
                   NSLocalizedString(@"Home_receive_address", nil)];
    }
    else if ([obj isKindOfClass:[WaybillGoodsInfoItem class]]) {
        titles = @[NSLocalizedString(@"Home_goods_no", nil),
                   NSLocalizedString(@"Home_goods_name", nil),
                   NSLocalizedString(@"Home_goods_pinpai", nil),
                   NSLocalizedString(@"Home_goods_caizhi", nil),
                   NSLocalizedString(@"Home_goods_baoshu", nil),
                   NSLocalizedString(@"Home_goods_tiji", nil),
                   NSLocalizedString(@"Home_goods_zhongliang", nil),
                   NSLocalizedString(@"Home_goods_shuliang", nil),
                   NSLocalizedString(@"Home_goods_zhuangtai", nil),
                   NSLocalizedString(@"Home_goods_time", nil)];
    }
    else if ([obj isKindOfClass:[WaybillFinaceItem class]]) {
        titles = @[NSLocalizedString(@"Home_finace_huilv", nil),
                   NSLocalizedString(@"Home_finace_yunfei", nil),
                   NSLocalizedString(@"Home_finace_baoxian", nil),
                   NSLocalizedString(@"Home_finace_jiekuan", nil),
                   NSLocalizedString(@"Home_finace_daifu", nil),
                   NSLocalizedString(@"Home_finace_daishou", nil),
                   NSLocalizedString(@"Home_finace_other", nil),
                   NSLocalizedString(@"Home_finace_price", nil)];
    }
    return titles;
}

- (NSArray *)detailsWithCellType:(id)obj {
    NSArray *details = nil;
    if ([obj isKindOfClass:[WaybillSenderItem class]]) {
        WaybillSenderItem *item = (WaybillSenderItem *)obj;
        details = @[item.StartStation,item.Name,[self transfromForTel:item.Tel],item.Address,item.RoomNo];
    }
    else if ([obj isKindOfClass:[WaybillReceiveItem class]]) {
        WaybillReceiveItem *item = (WaybillReceiveItem *)obj;
        details = @[item.EndStation,item.Name,[self transfromForTel:item.Tel],item.Address];
    }
    else if ([obj isKindOfClass:[WaybillGoodsInfoItem class]]) {
        WaybillGoodsInfoItem *item = (WaybillGoodsInfoItem *)obj;
        details = @[[NSString stringWithFormat:@"%zd",self.tag],item.GoodsName,item.Brand,item.Texture,item.Qty,item.Cube,item.Weight,item.Number,[self transformForState:item.State dState:item.dstate disstate:item.disstate currOrganizition:item.ShiCurrOrganizition],[self callForArriving:item.dstate state:item.State ETA:item.ETA]];
    }
    else if ([obj isKindOfClass:[WaybillFinaceItem class]]) {
        WaybillFinaceItem *item = (WaybillFinaceItem *)obj;
        details = @[item.Rate,item.yf,item.bxf,item.khjk,item.gndf,item.gwds,item.qtfy,[NSString stringWithFormat:@"CNY¥%@\nUSD$%@",item.CSum,item.DSum]];
    }
    return details;
}

- (NSString *)callForArriving:(NSString *)dState state:(NSString *)state ETA:(NSString *)ETA {
    NSString *title = @"";
    if (ETA.integerValue == 0) {
        return title;
    }
    if (dState.integerValue == 1 ) {
        long long times = ETA.longLongValue;
        NSInteger day =  (NSInteger)(times/3600/24);
        NSInteger h = (NSInteger)((times/3600) % 24);
        NSInteger m = (NSInteger)((times/60) % 60);
        NSInteger s = (NSInteger)(times%60);
        title = [NSString stringWithFormat:@"%zd天%zd时%zd分%zd秒",day,h,m,s];
    }else if (state.integerValue == 1 || state.integerValue == 2) {
        long long times = ETA.longLongValue;
        NSInteger day =  (NSInteger)(times/3600/24);
        NSInteger h = (NSInteger)((times/3600) % 24);
        NSInteger m = (NSInteger)((times/60) % 60);
        NSInteger s = (NSInteger)(times%60);
        title = [NSString stringWithFormat:@"%zd天%zd时%zd分%zd秒",day,h,m,s];
    }
    return title;
}

- (NSAttributedString *)transformForState:(NSString *)state dState:(NSString *)dState disstate:(NSString *)disstate currOrganizition:(NSString *)organizition{
    NSString *title = nil;
    NSInteger stateNum = state.integerValue;
    UIColor *foreColor = [UIColor blackColor];
    if (stateNum == 1) {
        foreColor = kGlobalMainColor;
        title = NSLocalizedString(@"Home_goods_state_send", nil);
    }else if (stateNum == 2){
        foreColor = [UIColor brownColor];
        title = NSLocalizedString(@"Home_goods_state_route", nil);
    }else if (stateNum == 3) {
        foreColor = [UIColor greenColor];
        title = NSLocalizedString(@"Home_goods_state_end", nil);
    }
    if (dState.integerValue == 1) {
        title = NSLocalizedString(@"Home_goods_state_arriving", nil);
    }
    if ([organizition containsString:@"口岸"] && state.integerValue == 1) {
        foreColor = [UIColor redColor];
        title = NSLocalizedString(@"Home_goods_state_Depart", nil);
    }else {
        if (disstate.integerValue == 3) {
            foreColor = [UIColor redColor];
            title = NSLocalizedString(@"Home_goods_state_Depart", nil);
        }
    }
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:title];
    [attribute addAttribute:NSForegroundColorAttributeName value:foreColor range:NSMakeRange(0, title.length)];
    return attribute;
}

- (NSString *)transfromForTel:(NSString *)tel {
    NSString *telStr = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    telStr = [telStr stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    return telStr;
}

@end
