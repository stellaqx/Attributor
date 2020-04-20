//
//  TextAnalyzeViewController.m
//  Attributor
//
//  Created by Qian on 4/19/20.
//  Copyright © 2020 Stella Xu. All rights reserved.
//

#import "TextAnalyzeViewController.h"

@interface TextAnalyzeViewController ()

@property (weak) IBOutlet UILabel *colorfulTextLabel;
@property (weak) IBOutlet UILabel *outlinedTextLabel;

@end

@implementation TextAnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _textToAnalyze = [[NSAttributedString alloc] initWithString:@"testing" attributes:@{NSForegroundColorAttributeName: [UIColor greenColor],
//                                                                                        NSStrokeWidthAttributeName:@-3
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUI];
}

// MARK: -

- (void) updateUI {
    self.colorfulTextLabel.text = [NSString stringWithFormat:@"%lu colorful characters", [[self characterWithAttribute: NSForegroundColorAttributeName] length]];
    self.outlinedTextLabel.text = [NSString stringWithFormat:@"%lu outlined characters", [[self characterWithAttribute: NSStrokeWidthAttributeName] length]];
}

// MARK: -
- (NSAttributedString *)characterWithAttribute: (NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index += range.length;
        } else {
            index++;
        }
    }
    return characters;
}


// MARK: -

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    
    if (self.view.window) [self updateUI]; // in case we're already on show
}


@end
