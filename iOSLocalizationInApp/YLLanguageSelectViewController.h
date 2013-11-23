//
//  YLLanguageSelectViewController.h
//  changeLanguage
//
//  Created by Yong Li on 11/21/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLLanguageSelectViewController;

@protocol YLLanguageSelectViewControllerDelegate <NSObject>

- (void)finishedSelectLanguage:(YLLanguageSelectViewController*)controller;
- (void)cancelSelectLangugae:(YLLanguageSelectViewController*)controller;

@end

@interface YLLanguageSelectViewController : UITableViewController

@property(nonatomic, weak) id<YLLanguageSelectViewControllerDelegate> delegate;

@end
