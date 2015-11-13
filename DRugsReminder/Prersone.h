//
//  Prersone.h
//  DRugsReminder
//
//  Created by KarouiNoour on 2/27/15.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prersone : NSObject

@property NSString *nom;
@property NSString *prenom;
@property NSInteger *age;

-(Prersone *)initwithname: (NSString *)nom withprenom : (NSString *)prenom andage:(NSInteger *) age;
@end
