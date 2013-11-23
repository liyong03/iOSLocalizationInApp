//
//  YLViewController.m
//  changeLanguage
//
//  Created by Yong Li on 9/27/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import "YLViewController.h"
#import "YLTextDefine.h"
#import "YLLanguageManager.h"
#import "YLLanguageSelectViewController.h"


#define LANGUAGE_CHANGED_NOTIFICATION   @"LANGUAGE_CHANGED"

@interface YLViewController ()<YLLanguageSelectViewControllerDelegate>

@end

@implementation YLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.textLabel.text = NSLocalizedString(TEXT_CONTENT, nil);
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@".strings"];
    NSLog(@"path = %@", path);
    NSLog(@"main Path = %@", [[NSBundle mainBundle] bundlePath]);
    NSLog(@"is Exist: %d", [[NSFileManager defaultManager] fileExistsAtPath:path]);
//    [self copyOldLanguage];
//    [self printAllContent:[[NSBundle mainBundle] bundlePath]];
    
//    NSLog(@"%@",[[NSBundle mainBundle] preferredLocalizations]);
//    [NSBundle preferredLocalizationsFromArray:[NSArray arrayWithObject:@"en"]];
//    NSLog(@"%@",[[NSBundle mainBundle] preferredLocalizations]);
//    NSLog(@"%@", [[NSBundle mainBundle] developmentLocalization]);
    NSArray* locals = [[NSBundle mainBundle] localizations];
    NSLog(@"all languages: %@", locals);
    NSLog(@"all bundles: %@", [[NSBundle mainBundle] preferredLocalizations]);
    
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"base", nil]
//                                              forKey:@"AppleLanguages"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)printAllContent:(NSString*)path
{
    NSError* error = nil;
    NSArray* result = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if(error == nil) {
        for(NSString* p in result) {
            NSLog(@"%@", p);
            NSString* subPath = [path stringByAppendingPathComponent:p];
            BOOL isDirect = NO;
            if([[NSFileManager defaultManager] fileExistsAtPath:subPath isDirectory:&isDirect]){
                if(isDirect) {
                    [self printAllContent:subPath];
                }
            }
        }
    }
}

- (void)changeToEng
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@".strings"];
    NSMutableString* newPath = [path mutableCopy];
    [newPath replaceOccurrencesOfString:@"zh-Hans.lproj" withString:@"en.lproj" options:NSLiteralSearch range:NSMakeRange(0, newPath.length)];
    NSError* error = nil;
    if([[NSFileManager defaultManager] removeItemAtPath:path error:&error])
        NSLog(@"remove successed");
    else
        NSLog(@"error = %@", error);

    if([[NSFileManager defaultManager] copyItemAtPath:newPath toPath:path error:&error])
        NSLog(@"copy successed");
    else
        NSLog(@"error = %@", error);
}

- (void)changeBack
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@".strings"];
    NSMutableString* newPath = [path mutableCopy];
    [newPath appendString:@".bak"];
    [[NSFileManager defaultManager] copyItemAtPath:newPath toPath:path error:nil];
}

- (void)copyOldLanguage
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@".strings"];
    NSMutableString* newPath = [path mutableCopy];
    [newPath appendString:@".bak"];
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:newPath error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeToEn:(id)sender {
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"en", nil]
//                                              forKey:@"AppleLanguages"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSBundle mainBundle] unload];
//    [[NSBundle mainBundle] load];
    YLLocalizationSetLanguage(@"en");
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);

}

- (IBAction)changeToZh:(id)sender {
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-Hans", nil]
//                                              forKey:@"AppleLanguages"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSBundle mainBundle] unload];
    //    [[NSBundle mainBundle] load];
    YLLocalizationSetLanguage(@"zh-Hans");
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);

}

- (IBAction)resetLanguage:(id)sender {
    
    YLLocalizationReset;
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);
}

- (IBAction)selectLanguage:(id)sender {
    /*YLLanguageSelectViewController* controller = [[YLLanguageSelectViewController alloc] initWithNibName:nil bundle:nil];
    controller.delegate = self;
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:nil];*/
    [YLLanguageSelectViewController showLanguageSelectViewControllerWithDelegate:self];
}

- (void)finishedSelectLanguage:(YLLanguageSelectViewController *)controller {
    //[self dismissViewControllerAnimated:YES completion:nil];
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);
}

- (void)cancelSelectLangugae:(YLLanguageSelectViewController *)controller {
    //[self dismissViewControllerAnimated:YES completion:nil];
    self.textLabel.text = YLLocalizedString(TEXT_CONTENT, nil);
}

@end
