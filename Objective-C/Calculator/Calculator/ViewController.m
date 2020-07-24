//
//  ViewController.m
//  Calculator
//
//  Created by DaEun Kim on 2020/07/23.
//  Copyright © 2020 DaEun Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.num1 = 0;
    self.num2 = 0;
    self.operand = plus;
    self.result = 0.0;
    self.theNumber = @"";
}

- (IBAction)pressNumber:(id)sender
{
    self.theNumber = [self.theNumber stringByAppendingString:[sender currentTitle]];
    [self.lblResult setText:self.theNumber];
}

- (IBAction)pressOperand:(id)sender
{
    self.num1 = [self.theNumber integerValue];
    self.theNumber = @"";
    switch ([sender tag]) {
        case 0:
            self.operand = plus;
            break;
        case 1:
            self.operand = minus;
            break;
        case 2:
            self.operand = multiply;
            break;
        case 3:
            self.operand = divide;
            break;
        default:
            break;
    }
}

- (IBAction)pressCalulate:(id)sender
{
    self.num2 = [self.theNumber integerValue];
    switch (self.operand) {
        case plus:
            self.result = self.num1 + self.num2;
            break;
        case minus:
            self.result = self.num1 - self.num2;
            break;
        case multiply:
            self.result = self.num1 * self.num2;
            break;
        case divide:
            self.result = self.num1 / self.num2;
            break;
    }
    self.num1 = 0;
    self.num2 = 0;
    self.theNumber = [NSString stringWithFormat:@"%f", self.result];
    [self.lblResult setText:self.theNumber];
}

- (IBAction)pressClear:(id)sender
{
    self.num1 = 0;
    self.num2 = 0;
    self.theNumber = @"";
    [self.lblResult setText:self.theNumber];
}

@end
