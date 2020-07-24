//
//  ViewController.h
//  Calculator
//
//  Created by DaEun Kim on 2020/07/23.
//  Copyright © 2020 DaEun Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

enum Operand {
    plus = 0,
    minus = 1,
    multiply = 2,
    divide = 3
};

typedef enum Operand Operand;

@interface ViewController : UIViewController

@property NSInteger num1;
@property NSInteger num2;
@property double result;

@property Operand operand;
@property (strong, nonatomic) NSString *theNumber;

@end

