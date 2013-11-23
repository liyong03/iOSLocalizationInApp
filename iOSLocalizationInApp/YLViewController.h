//
//  YLViewController.h
//  changeLanguage
//
//  Created by Yong Li on 9/27/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
- (IBAction)changeToEn:(id)sender;
- (IBAction)changeToZh:(id)sender;
- (IBAction)resetLanguage:(id)sender;
- (IBAction)selectLanguage:(id)sender;

@end
