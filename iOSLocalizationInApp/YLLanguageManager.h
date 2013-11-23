//
//  YLLanguageManager.h
//  changeLanguage
//
//  Created by Yong Li on 11/20/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YLLocalizedString(key, comment) \
[[YLLanguageManager sharedManager] localizedStringForKey:(key) value:(comment)]

#define YLLocalizationSetLanguage(language) \
[[YLLanguageManager sharedManager] setLanguage:(language)]

#define YLLocalizationGetLanguage \
[[YLLanguageManager sharedManager] getLanguage]

#define YLLocalizationReset \
[[YLLanguageManager sharedManager] resetLanguage]

@interface YLLanguageManager : NSObject

+ (YLLanguageManager*)sharedManager;

- (NSArray*)allSupportedLanguages;
- (NSString*)getCurrentLanguage;
- (void)setLanguage:(NSString*)str;
- (void)resetLanguage;

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

@end
