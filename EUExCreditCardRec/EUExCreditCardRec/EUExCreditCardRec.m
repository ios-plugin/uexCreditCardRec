//
//  EUExCreditCardRec.m
//  AppCan
//
//  Created by AppCan on 13-4-18.
//
//

#import "EUExCreditCardRec.h"
#import "EUtility.h"

@implementation EUExCreditCardRec

- (id)initWithBrwView:(EBrowserView *)eInBrwView
{
    if (self=[super initWithBrwView:eInBrwView]) {
        
    }
    return self;
}

#pragma mark - open

- (void)openCreditCardRec:(NSMutableArray *)inArguments
{
    if (inArguments != nil && [inArguments count] == 1)
    {
        NSString *tokenStr = [inArguments objectAtIndex:0];
        CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
        // 从card.io网站，得到你的应用程序口令
        scanViewController.appToken = tokenStr;
        
        [EUtility brwView:meBrwView presentModalViewController:scanViewController animated:YES];
    } else {
        return;
    }
}

#pragma mark - CardIOPaymentViewControllerDelegate methods

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // 在这里处理用户取消
    [scanViewController dismissModalViewControllerAnimated:YES];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    // 完整的卡号是可作为info.cardNumber，但没有登录！
    
    // 使用该卡信息
    if (info.cardNumber != nil && info.expiryMonth != 0 && info.expiryYear != 0 && info.cvv != nil)
    {
        NSString *jsString = [NSString stringWithFormat:@"if(uexCreditCardRec.callBackCreditCard!=null){uexCreditCardRec.callBackCreditCard('%@','%02i/%i','%@');}",info.cardNumber,info.expiryMonth, info.expiryYear, info.cvv];
        NSLog(@"jsString = %@",jsString);
        [EUtility brwView:meBrwView evaluateScript:jsString];
        NSString *jsStringCB = [NSString stringWithFormat:@"if(uexCreditCardRec.cbCreditCard!=null){uexCreditCardRec.cbCreditCard('%@','%02i/%i','%@');}",info.cardNumber,info.expiryMonth, info.expiryYear, info.cvv];
        NSLog(@"jsString = %@",jsString);
        [EUtility brwView:meBrwView evaluateScript:jsStringCB];
    } else {
        //
    }
    
    [scanViewController dismissModalViewControllerAnimated:YES];
}

- (void)clean
{
    
}

@end
