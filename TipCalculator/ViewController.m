//
//  ViewController.m
//  TipCalculator
//
//  Created by Charlie Massry on 2/28/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@end

@implementation ViewController
- (IBAction)touchDecimal:(UIButton *)sender {
    self.totalAmount.text = [self.totalAmount.text stringByAppendingString:@"."];
}

- (IBAction)touchNumber:(UIButton *)sender {
    if ([self.totalAmount.text isEqualToString:@"0"]) {
        self.totalAmount.text = @"";
    }
    NSUInteger integer = sender.currentTitle.integerValue;
    NSString *integerString = [NSString stringWithFormat:@"%lu", integer];
    self.totalAmount.text = [self.totalAmount.text stringByAppendingString:integerString];
}

- (IBAction)clearTouch:(UIButton *)sender {
    self.totalAmount.text = @"0";
}

- (IBAction)percentageTouch:(UIButton *)sender {
    CGFloat floatValue = sender.currentTitle.floatValue;
    CGFloat percentage = floatValue / 100.0;
    CGFloat total = [self.totalAmount.text floatValue];
    CGFloat percentageAmount = total * percentage;
    self.totalAmount.text = [NSString stringWithFormat:@"%.02f", percentageAmount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.totalAmount.text = @"0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
