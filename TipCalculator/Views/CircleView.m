//
//  CircleView.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()
@property(strong, nonatomic) UIColor *color;
@property(nonatomic) CGFloat length;
@property(nonatomic) UIColor *borderColor;
@end

@implementation CircleView

-(instancetype)initWithColor:(UIColor *)color andLength:(CGFloat)length andBorderColor:(UIColor *)borderColor {
    self = [super init];
    
    if (self) {
        self.color = color ? color : [UIColor clearColor];
        self.length = length;
        self.borderColor = borderColor ? borderColor : [UIColor clearColor];
    }

    return self;
}

-(instancetype)initWithColor:(UIColor *)color andLength:(CGFloat)length {
    return [self initWithColor:color andLength:length andBorderColor:nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//}

-(void)drawCircle {
    CGPoint center;
    center.x = self.length / 2.0;
    center.y = self.length / 2.0;
    CGFloat radius = (self.length / 2.0) - 5;
    CGFloat startAngle = 0.0;
    CGFloat endAngle  = M_PI * 2;
    
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    
    [circlePath addArcWithCenter:center
                          radius:radius
                      startAngle:startAngle
                        endAngle:endAngle
                       clockwise:YES];
    
    circlePath.lineWidth = 5;
    
    [self.color setFill];
    [self.borderColor setStroke];
    [circlePath fill];
    [circlePath stroke];
}

@end
