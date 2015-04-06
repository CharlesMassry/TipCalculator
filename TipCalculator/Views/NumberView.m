//
//  NumberView.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/5/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Util.h"
#import "NumberView.h"
#import "CircleView.h"

@interface NumberView ()
@property (strong, nonatomic) CircleView *circle;
@property (strong, nonatomic) UILabel *numberLabel;
@end

@implementation NumberView

#pragma mark - initialization

-(CircleView *)circle {
    if (!_circle) {
        _circle = [[CircleView alloc] initWithColor:[self baseCircleColor]
                                          andLength:self.bounds.size.width];
    }
    
    return _circle;
}

- (instancetype)initWithButtonFace:(NSString *)buttonFace {
    return [self initWithFrame:CGRectZero andButtonFace:buttonFace];
}

- (instancetype)initWithFrame:(CGRect)frame andButtonFace:(NSString *)buttonFace {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonFace = buttonFace;
        self.numberLabel = [[UILabel alloc] init];
        [self.numberLabel setTextColor:[UIColor whiteColor]];
        [self.numberLabel setFont:[UIFont fontWithName:@"Helvetica" size:32.0f]];
        self.numberLabel.text = buttonFace;
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.numberLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.circle drawCircle];
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.circle = [[CircleView alloc] initWithColor:[self touchedCircleColor]
                                          andLength:self.bounds.size.width];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.circle = [[CircleView alloc] initWithColor:[self baseCircleColor]
                                          andLength:self.bounds.size.width];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"numberButtonTapped"
                                                        object:self.buttonFace];
    [self setNeedsDisplay];
}

#pragma mark - colors

-(UIColor *)baseCircleColor {
    return [Util opaqueColorWithOpacity:0.25];
}

-(UIColor *)touchedCircleColor {
    return [Util opaqueColorWithOpacity:0.5];
}

#pragma mark - constraints

- (void)updateConstraints {
    [self addConstraintsForNumberLabel];
    [super updateConstraints];
}

-(void)addConstraintsForNumberLabel {
    CGFloat horizontalMultiplier;
    CGFloat verticalMultiplier;
    
    if ([self.buttonFace isEqualToString:@"."]) {
        horizontalMultiplier = 1.25;
        verticalMultiplier = 0.75;
    } else {
        horizontalMultiplier = 1.15;
        verticalMultiplier = 1;
    }
    
    NSLayoutConstraint *constraintWidth = [self constraintForPositionWithAttribute:NSLayoutAttributeWidth
                                                                     andMultiplier:0.4];
    NSLayoutConstraint *constraintHeight = [self constraintForPositionWithAttribute:NSLayoutAttributeHeight
                                                                      andMultiplier:0.4];
    NSLayoutConstraint *horizontalConstraint = [self constraintForPositionWithAttribute:NSLayoutAttributeCenterX
                                                                          andMultiplier:horizontalMultiplier];
    NSLayoutConstraint *verticalConstraint = [self constraintForPositionWithAttribute:NSLayoutAttributeCenterY
                                                                          andMultiplier:verticalMultiplier];
    [self addConstraints:@[constraintWidth, constraintHeight, horizontalConstraint, verticalConstraint]];
    
}

-(NSLayoutConstraint *)constraintForPositionWithAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier{
    return [NSLayoutConstraint constraintWithItem:self.numberLabel
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                        attribute:attribute
                                       multiplier:multiplier
                                         constant:0.0];
}
@end
