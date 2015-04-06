//
//  TipCalculatorView.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/27/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "TipCalculatorView.h"
#import "NumberCollectionView.h"

@interface TipCalculatorView ()
@property (strong, nonatomic) NumberCollectionView *numberCollectionView;
@end

@implementation TipCalculatorView

- (ResultView *)resultView {
    if (!_resultView) {
        _resultView = [[ResultView alloc] init];
    }
    return _resultView;
}

- (UIButton *)calculateTipButton {
    if (!_calculateTipButton) {
        _calculateTipButton = [[UIButton alloc] init];
    }
    return _calculateTipButton;
}

- (NumberCollectionView *)numberCollectionView {
    if (!_numberCollectionView) {
        _numberCollectionView = [[NumberCollectionView alloc] init];
    }
    return _numberCollectionView;
}

- (instancetype)init {
    return [self initWithFrame:CGRectNull];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        UIImage *backgroundImage = [UIImage imageNamed:@"background"];
        self.layer.contents = CFBridgingRelease(backgroundImage.CGImage);
        
        [self addSubview:self.calculateTipButton];
        [self addSubview:self.numberCollectionView];
        [self addSubview:self.resultView];
    }
    
    return self;
}

- (void)updateConstraints {
    [self setupConstraints];
    [super updateConstraints];
}

- (void)setupConstraints {
    [self removeConstraints:self.constraints];
    if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]) == UIDeviceOrientationPortrait) {
        [self addConstraintsForPortrait];
    } else {
        [self addConstraintsForLandscape];
    }
}

- (void)addConstraintsForPortrait {
    self.resultView.contentMode = UIViewContentModeTop;
    [self addConstraintsForView:self.resultView
                     withOrigin:CGPointMake(1.0, 0.5)
                        andSize:CGSizeMake(0.66, 0.66)];
    
    self.numberCollectionView.contentMode = UIViewContentModeBottom;
    [self addConstraintsForView:self.numberCollectionView
                     withOrigin:CGPointMake(1.0, 1.5)
                        andSize:CGSizeMake(0.75, 0.75)];
}

- (void)addConstraintsForLandscape {
    self.resultView.contentMode = UIViewContentModeLeft;
    [self addConstraintsForView:self.resultView
                     withOrigin:CGPointMake(0.75, 1.0)
                        andSize:CGSizeMake(0.66, 0.66)];
    
    self.numberCollectionView.contentMode = UIViewContentModeRight;
    [self addConstraintsForView:self.numberCollectionView
                     withOrigin:CGPointMake(1.5, 1)
                        andSize:CGSizeMake(0.45, 0.45)];
}

- (void)addConstraintsForView:(UIView *)view withOrigin:(CGPoint)origin andSize:(CGSize)size {
    // Width constraint, half of parent view width
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:size.width
                                                      constant:0.0]];
    // Height constraint, half of parent view height
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:size.height
                                                      constant:0.0]];
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:origin.x
                                                      constant:0.0]];
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:origin.y
                                                      constant:0.0]];
}

@end
