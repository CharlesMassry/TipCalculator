//
//  TipCalculatorView.h
//  TipCalculator
//
//  Created by Charlie Massry on 3/27/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultView.h"

@interface TipCalculatorView : UIView
@property (strong, nonatomic) ResultView *resultView;
@property (strong, nonatomic) UIButton *calculateTipButton;
@end
