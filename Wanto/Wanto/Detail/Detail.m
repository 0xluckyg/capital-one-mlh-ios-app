//
//  Detail.m
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "Detail.h"

@interface Detail ()

@end

@implementation Detail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeDesign];
    // Do any additional setup after loading the view.
}

- (void)initializeDesign {
    self.navigationItem.title = self.type;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:normal target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.UIPrinciple = [[UIPrinciple alloc] init];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.label.text = @"Loading";
//    hud.bezelView.color = [self.UIPrinciple.defaultOrange
//                           colorWithAlphaComponent:1.0f];
//    
//    hud.tintColor = [UIColor whiteColor];
//    [hud showAnimated:YES];
    
    
    NSLog(@"%@", self.pageUrlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:self.pageUrlString]] ;
    
    [self.webView loadRequest:request];
    
//    [hud hideAnimated:YES];

}

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
