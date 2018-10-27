
#import "WLCargoTrackModel.h"
#import "NSDictionary+Extension.h"

@implementation WLCargoTrackModel

+ (void) requestQueryOrderWithModel:(WLCargoTrackModel *)model
                      SuccessHandle:(void(^)(id responseObject))successCompletion
                               Fail:(void(^)(NSError *error))failHandle; {
    
    //test
    NSDictionary *dict_test = [NSDictionary requestWithUrl:@"cargotrack"
                                                param:@{
                                                        @"entNumber":@"GM4160",
                                                        @"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b",
                                                        }];
    
//    NSDictionary *dict = [NSDictionary requestWithUrl:@"cargotrack"
//                                                param:@{@"":model.orderStr,
//                                                        @"entNumber":[UserManager sharedManager].user.entNumber,
//                                                        @"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b",
//                                                        }];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:dict_test model:nil cache:NO success:^(FCBaseResponse *response) {
//        [FCProgressHUD hideHUDForView:self.view animation:YES];
        if ([response.json[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            successCompletion(dict);
        }else {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            successCompletion(dict);
        }
    } failure:^(FCBaseResponse *response) {
//        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}
@end
