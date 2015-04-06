//
//  ResultView.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/11/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Util.h"
#import "ResultView.h"
#import "CircleView.h"

@interface ResultView ()
@property (strong, nonatomic) UILabel *tipAmountLabel;
@property(strong, nonatomic) CircleView *circle;
@property(nonatomic)CGFloat tipAmount;
@end

@implementation ResultView

- (instancetype) init {
    return [self initWithFrame:CGRectZero];
}

-(CircleView *)circle {
    if (!_circle) {
        _circle = [[CircleView alloc] initWithColor:nil
                                          andLength:self.bounds.size.width
                                          andBorderColor:[self baseCircleColor]];
    }
    return _circle;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.tipAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self updateTipAmountTo:0.0];
        self.tipAmountLabel.textColor = [UIColor whiteColor];
        self.tipAmountLabel.font = [UIFont fontWithName:@"Helvetica" size:46.0f];
        self.tipAmountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.tipAmountLabel];
    }

    return self;
}

-(void)updateTipAmountTo:(CGFloat)tipAmount {
    self.tipAmount = tipAmount;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    self.tipAmountLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
}

- (void)drawRect:(CGRect)rect {
    [self.circle drawCircle];
}

-(UIColor *)baseCircleColor {
    return [Util opaqueColorWithOpacity:0.25];
}

#pragma mark - constraints

-(void)updateConstraints {
    [self addConstraintsForTipAmountLabel];
    [super updateConstraints];
}

-(void)addConstraintsForTipAmountLabel {
    
    NSLayoutConstraint *constraintWidth = [self constraintForPositionWithAttribute:NSLayoutAttributeWidth
                                                                     andMultiplier:1];
    NSLayoutConstraint *constraintHeight = [self constraintForPositionWithAttribute:NSLayoutAttributeHeight
                                                                      andMultiplier:0.5];
    NSLayoutConstraint *horizontalConstraint = [self constraintForPositionWithAttribute:NSLayoutAttributeCenterX
                                                                          andMultiplier:1.4];
    NSLayoutConstraint *verticalConstraint = [self constraintForPositionWithAttribute:NSLayoutAttributeCenterY
                                                                        andMultiplier:1];
    [self addConstraints:@[constraintWidth, constraintHeight, horizontalConstraint, verticalConstraint]];
    
}

-(NSLayoutConstraint *)constraintForPositionWithAttribute:(NSLayoutAttribute)attribute andMultiplier:(CGFloat)multiplier{
    return [NSLayoutConstraint constraintWithItem:self.tipAmountLabel
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                        attribute:attribute
                                       multiplier:multiplier
                                         constant:0.0];
}

@end
