//
//  MXAPPCertificationModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCertificationModel.h"

@implementation MXAPPCertificationModel

- (CertificationType)type {
    if ([self.oyster isEqualToString:@"influentiala"]) {
        return Certification_Question;
    } else if ([self.oyster isEqualToString:@"influentialb"]) {
        return Certification_Card;
    } else if ([self.oyster isEqualToString:@"influentialc"]) {
        return Certification_Personal;
    } else if ([self.oyster isEqualToString:@"influentiald"]) {
        return Certification_Work;
    } else if ([self.oyster isEqualToString:@"influentiale"]) {
        return Certification_Contacts;
    } else if ([self.oyster isEqualToString:@"influentialf"]) {
        return Certification_Bank;
    }
    
    return Certification_Question;
}

@end
