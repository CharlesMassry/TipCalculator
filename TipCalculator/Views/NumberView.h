//
//  NumberView.h
//  TipCalculator
//
//  Created by Charlie Massry on 3/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberView : UIButton
@property(strong, nonatomic) NSString *buttonFace;
- (instancetype)initWithButtonFace:(NSString *)buttonFace;
- (instancetype)initWithFrame:(CGRect)frame andButtonFace:(NSString *)buttonFace;
@end
