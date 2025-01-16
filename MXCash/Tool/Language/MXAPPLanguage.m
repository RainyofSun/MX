//
//  MXAPPLanguage.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXAPPLanguage.h"

@interface MXAPPLanguage ()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation MXAPPLanguage

+ (instancetype)language {
    static MXAPPLanguage *lan;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (lan == nil) {
            lan = [[MXAPPLanguage alloc] init];
        }
    });
    
    return lan;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bundle = [NSBundle mainBundle];
    }
    return self;
}

- (NSString *)languageValue:(NSString *)languageKey {
    return [self.bundle localizedStringForKey:languageKey value:nil table:@"Localizable"];
}

- (void)setLanguageBundleType:(LanguageBundleType)type {
    NSString *languageCode = @"";
    switch (type) {
        case English:
            languageCode = @"en";
            break;
        case Mexico:
            languageCode = @"es";
            break;
        default:
            break;
    }
    
    NSString *languagePath = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    if (languagePath == nil || [languagePath isEqualToString:@""]) {
        languagePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    
    self.bundle = [[NSBundle alloc] initWithPath:languagePath];
}

@end
