//
//  EUExCreditCardRec.h
//  AppCan
//
//  Created by AppCan on 13-4-18.
//
//

#import <UIKit/UIKit.h>
#import "EUExBase.h"
#import "EUExBaseDefine.h"
#import "CardIO.h"

@interface EUExCreditCardRec : EUExBase<CardIOPaymentViewControllerDelegate>


- (void)openCreditCardRec:(NSMutableArray *)inArguments;

@end
