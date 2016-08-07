//
//  Login.h
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPrinciple.h"

@interface Login : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UIPrinciple *UIPrinciple;

@property (weak, nonatomic) IBOutlet UITextField *idTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

- (IBAction)loginButtonAction:(id)sender;


@end
