//
//  ViewController.m
//  Attributor
//
//  Created by Qian on 4/19/20.
//  Copyright © 2020 Stella Xu. All rights reserved.
//

#import "ViewController.h"
#import "TextAnalyzeViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;

@end

@implementation ViewController

// MARK:-
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        TextAnalyzeViewController *destController = (TextAnalyzeViewController *)segue.destinationViewController;
        destController.textToAnalyze = self.body.textStorage;
    }
}


// MARK: -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// update UI whenever: 1)when the view is showing, there is a notification change on system default font
// 2) the view is not on-show, and there is a change in the system default font
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self updateUI];
    
    // add observer to listen to system default font change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontChange:) name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)updateUI {
    [self usePreferredfont];
    // todo, maybe there are other stuff, like data refreshing here you'd like to do as well
}

// here is the method that'd be invoked if the system default fond IS changed
- (void)preferredFontChange:(NSNotification *)notification {
    [self usePreferredfont];
}

- (void)usePreferredfont {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

// remove the observer!!! important stuff
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification object:nil];
}

// MARK: -

- (IBAction)changeBodySeletionToMatchBackgroundButton:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{NSForegroundColorAttributeName: sender.backgroundColor}
                                   range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3,
                                           NSStrokeColorAttributeName: [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(UIButton *)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

@end
