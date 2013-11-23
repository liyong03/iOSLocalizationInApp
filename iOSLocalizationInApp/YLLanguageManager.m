//
//  YLLanguageManager.m
//  changeLanguage
//
//  Created by Yong Li on 11/20/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import "YLLanguageManager.h"

@implementation YLLanguageManager {
    NSBundle* _bundle;
}

+ (YLLanguageManager*)sharedManager
{
    static YLLanguageManager* _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[YLLanguageManager alloc] init];
    });
    
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString* lang = [[NSUserDefaults standardUserDefaults] objectForKey:@"YLAppleLanguages"];
        if(lang) {
            NSString *path = [[ NSBundle mainBundle ] pathForResource:lang ofType:@"lproj"];
            _bundle = [NSBundle bundleWithPath:path];
        }
        else {
            _bundle = [NSBundle mainBundle];
        }
    }
    return self;
}

- (NSArray*)allSupportedLanguages
{
    return [[NSBundle mainBundle] localizations];
}

- (NSString*)getCurrentLanguage
{
    NSString* lang = [[NSUserDefaults standardUserDefaults] objectForKey:@"YLAppleLanguages"];
    if(lang)
        return lang;
    
	NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
	NSString *preferredLang = [languages objectAtIndex:0];
    
	return preferredLang;
}

- (void)setLanguage:(NSString*)str
{
    NSString *path = [[ NSBundle mainBundle ] pathForResource:str ofType:@"lproj"];
    
	if (path == nil)
		[self resetLanguage];
	else {
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"YLAppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		_bundle = [NSBundle bundleWithPath:path];
    }
}

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
	return [_bundle localizedStringForKey:key value:comment table:nil];
}

- (void)resetLanguage
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"YLAppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _bundle = [NSBundle mainBundle];
}

@end
