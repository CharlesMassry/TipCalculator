//
//  ViewController.m
//  TipCalculator
//
//  Created by Charlie Massry on 2/28/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "TipCalculatorViewController.h"
#import "TipCalculatorView.h"
#import "NumberView.h"
#import "ResultView.h"
#import "Util.h"

@interface TipCalculatorViewController ()
@property(strong, nonatomic) NSArray *buttons;
@property(strong, nonatomic) NSMutableString *result;
@property(strong, nonatomic) ResultView *resultView;
@end

@implementation TipCalculatorViewController

#pragma mark setupView
-(NSMutableString *)result {
    if (!_result) {
        _result = [NSMutableString stringWithString:@"0"];
    }
    return _result;
}

- (void)loadView {
    TipCalculatorView *tipCalculatorView = [[TipCalculatorView alloc] init];
    self.view = tipCalculatorView;
    self.resultView = tipCalculatorView.resultView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(numberButtonTapped:)
                                                 name:@"numberButtonTapped"
                                               object:nil];
    
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.view updateConstraints];
}

-(void)addNumberViews {
    for (NSInteger columnCount = 1; columnCount <= 4; columnCount++) {
        [self addNumberViewsForColumn:columnCount
                    withXYCoordinates:CGPointMake((self.view.bounds.size.width * (columnCount / 4.0)) - 75, 250)];
    }
}

-(void)addNumberViewsForColumn:(NSInteger)columnNumber withXYCoordinates:(CGPoint)point {
    NSInteger counter = 1;
    NSArray *columnNumbers = @[@0, @4, @8, @12];
    NSInteger columnStart = [[columnNumbers objectAtIndex:(columnNumber-1)] integerValue];
    for (NSInteger i = columnStart; i < (4 * columnNumber); i++) {
        NSString *button = [[Util buttonFaces] objectAtIndex:i];
        NumberView *numberView = [[NumberView alloc] initWithFrame:CGRectMake(point.x, point.y + (75 * counter), 64, 64)
                                                     andButtonFace:button];
        [self.view addSubview:numberView];
        counter++;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(CGFloat)calculateExpression {
    return 0.0;
}

-(void)numberButtonTapped:(NSNotification *)buttonFace {
    CGFloat tipAmount;
    NSString *buttonFaceTapped = [buttonFace object];
    
    if ([buttonFaceTapped isEqualToString:@"C"]) {
        self.result = nil;
    } else if([buttonFaceTapped isEqualToString:@"."]) {
        [self.result appendString:@"."];
    } else {
        [self.result appendString:buttonFaceTapped];
    }
    
    tipAmount = [self.result floatValue];
    [self.resultView updateTipAmountTo:tipAmount];
}

@end
