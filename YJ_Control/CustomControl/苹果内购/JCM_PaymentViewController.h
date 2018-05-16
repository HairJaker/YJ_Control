//
//  JCM_PaymentViewController.h
//  竞彩猫
//
//  Created by yujie on 2017/6/28.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <StoreKit/StoreKit.h>

typedef void(^JCM_PaymentPaySuccessBlock)();

@interface JCM_PaymentViewController : UIViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic,assign) JCM_PriceType buyType;

+(id)sharedPaymentManger;

- (void)requestProUpgradeProductData;

-(void)RequestProductData;

-(void)buy:(JCM_PriceType)type;

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;

- (void)completeTransaction:(SKPaymentTransaction *)transaction;

- (void) failedTransaction: (SKPaymentTransaction *)transaction;

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;

- (void) restoreTransaction: (SKPaymentTransaction *)transaction;

-(void)provideContent:(NSString *)product;

-(void)recordTransaction:(NSString *)product;

@property (nonatomic,copy) JCM_PaymentPaySuccessBlock  paySuccessBlock;

@end
