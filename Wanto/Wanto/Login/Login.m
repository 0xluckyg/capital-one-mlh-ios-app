//
//  Login.m
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDesign];
    
}

- (void)initializeDesign {
    
    self.UIPrinciple = [[UIPrinciple alloc] init];
    
    self.view.backgroundColor = self.UIPrinciple.defaultOrange;
    
    [self.idTextField setBackgroundColor:[UIColor whiteColor]];
    [self.idTextField.layer setCornerRadius:self.idTextField.frame.size.height/2];
    self.idTextField.textColor = self.UIPrinciple.defaultOrange;

    
    [self.passwordTextField setBackgroundColor:[UIColor whiteColor]];
    [self.passwordTextField.layer setCornerRadius:self.passwordTextField.frame.size.height/2];
    self.passwordTextField.textColor = self.UIPrinciple.defaultOrange;

    
    [self.loginButtonOutlet setBackgroundColor:self.UIPrinciple.lightOrange];
    [self.loginButtonOutlet.layer setCornerRadius:self.loginButtonOutlet.frame.size.height/2];
    [self.loginButtonOutlet setTintColor:[UIColor whiteColor]];
    
    
    self.logoImage.image = [UIImage imageNamed:@"WantoLogo"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//When begins editing, set textfield to none
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textView
{
    textView.attributedText = nil;
    return YES;
}

//Move screen up a bit when Keyboard appears for Description only
-(void)textFieldDidBeginEditing:(UITextView *)textView
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

//Move screen down a bit when Keyboard appears for Description only
-(void)textFieldDidEndEditing:(UITextView *)textView
{
    if ([self.passwordTextField.text isEqualToString:@""]) {
        self.passwordTextField.text = @"Password";
    }
    
    if ([self.idTextField.text isEqualToString:@""]) {
        self.idTextField.text = @"Email";
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +200., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//Touching on sceen will make keyboard disappear
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"menuSegue" sender:self];
    
}



















@end
