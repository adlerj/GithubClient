//
//  ViewController.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JALoginViewController.h"

#define kRepoTableViewControllerSegueIdentifier @"repoTableViewSegue"

@interface JALoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation JALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)resetButtonPressed:(UIButton *)sender {
    
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:kRepoTableViewControllerSegueIdentifier sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
