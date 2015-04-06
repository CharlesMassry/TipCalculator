//
//  CircleView.h
//  TipCalculator
//
//  Created by Charlie Massry on 3/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
-initWithColor:(UIColor *)color andLength:(CGFloat)length andBorderColor:(UIColor *)borderColor;
-(id)initWithColor:(UIColor *)color andLength:(CGFloat)length;
-(void)drawCircle;
@end
