//
//  FeedbackViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/24.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textViewPlaceHolder;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FeedbackViewController

+ (instancetype)feedbackViewController {
    return [[UIStoryboard storyboardWithName:@"FeedbackViewController" bundle:nil]instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Profile_fankui", nil);
    self.textField.placeholder = NSLocalizedString(@"Profile_place_title", nil);
    self.textViewPlaceHolder.text = NSLocalizedString(@"Profile_place_feedback", nil);
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setTitle:NSLocalizedString(@"Login_btn_submit", nil) forState:UIControlStateNormal];
    self.textView.delegate = self;
}

- (IBAction)clickSubmit:(id)sender {
    if (self.textField.text.length == 0 || self.textView.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Profile_tip_feedback", nil)];
        return;
    }
    NSDictionary *dict = [NSDictionary requestWithUrl:@"feedback" param:@{@"title":_textField.text,@"content":_textView.text,@"entNumber":[UserManager sharedManager].user.entNumber,@"cusCode":[UserManager sharedManager].user.cusCode}];
    [FCProgressHUD showLoadingOn:self.view];
    [FCHttpRequest FCNetWork:HttpRequestMethodPost url:nil model:nil cache:NO param:dict success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        if ([response.json[@"state"] isEqualToString:@"success"]) {
            NSString *msg = ((NSArray *)response.json[@"data"]).firstObject[@"responseMsg"];
            [FCProgressHUD showText:msg];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        if ([response.json[@"state"] isEqualToString:@"error"]) {
             NSString *msg = ((NSArray *)response.json[@"data"]).firstObject[@"responseMsg"];
            [FCProgressHUD showText:msg];
        }
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textViewPlaceHolder.hidden = textView.text.length > 0;
}

@end
