//
//  JCM_PaymentViewController.m
//  竞彩猫
//
//  Created by yujie on 2017/6/28.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_PaymentViewController.h"

#define ProductID_IAP60 @"JingCaiMao.fish60"//60
#define ProductID_IAP88 @"JingCaiMao.fish88" //88
#define ProductID_IAP128 @"JingCaiMao.fish128" //128
#define ProductID_IAP188 @"JingCaiMao.fish188" //188
#define ProductID_IAP268 @"JingCaiMao.fish268" //268
#define ProductID_IAP288 @"JingCaiMao.fish288x" //288
#define ProductID_IAP98 @"JingCaiMao.fish98" //欧亚 98
#define ProductID_IAP138 @"JingCaiMao.fish138" // 超级计算机  138

@interface JCM_PaymentViewController ()
{
    NSString * product_id;
}
@end

@implementation JCM_PaymentViewController

static  JCM_PaymentViewController * paymentVc;

+(id)sharedPaymentManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        paymentVc = [[JCM_PaymentViewController alloc] init];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:paymentVc];
    });
    return paymentVc;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

-(void)buy:(JCM_PriceType)type
{
    _buyType = type;
    
    NSArray* transactions = [SKPaymentQueue defaultQueue].transactions;
    if (transactions.count > 0) {
        //检测是否有未完成的交易
        SKPaymentTransaction* transaction = [transactions firstObject];
        if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
            [self completeTransaction:transaction];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return;
        }
    }
    
    if ([SKPaymentQueue canMakePayments]) {
        [self RequestProductData];
        NSLog(@"允许程序内付费购买");
    }
    else
    {
        NSLog(@"不允许程序内付费购买");
        UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您的手机没有打开程序内付费购买"
                                                           delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
        
        [alerView show];
        
    }
}

// 请求对应的产品信息
-(void)RequestProductData
{
    UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    [MBProgressHUD showMessag:@"充值中..." toView:view];
    
    NSLog(@"---------请求对应的产品信息------------");
    NSArray *product = nil;
    switch (_buyType) {
        case JCM_PriceType60:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP60,nil];
            break;
        case JCM_PriceType88:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP88,nil];
            break;
        case JCM_PriceType128:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP128,nil];
            break;
        case JCM_PriceType188:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP188,nil];
            break;
        case JCM_PriceType268:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP268,nil];
            break;
        case JCM_PriceType288:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP288,nil];
            break;
        case JCM_PriceTypeEur98:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP98,nil];
            break;
        case JCM_PriceTypeSuperComp138:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP138,nil];
            break;
            
        default:
            break;
    }
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate=self;
    [request start];
    
}

#pragma mark  --  <SKProductsRequestDelegate> 请求协议  --
//收到的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    
    if (myProduct.count == 0) {
        [MBProgressHUD showProgress:@"无法获取商品信息" toView:self.view afterDelay:1.0f];
        return;
    }
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    
    // populate UI
    
    SKPayment *payment = nil;
    
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
        
        product_id = product.productIdentifier;
        
        payment = [SKPayment paymentWithProduct:product];
    }
    
    NSLog(@"---------发送购买请求------------");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
- (void)requestProUpgradeProductData
{
    NSLog(@"------请求升级数据---------");
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.productid"];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
}
//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    [self hideMBProgressHud];
    
    NSLog(@"-------弹出错误信息----------");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"购买失败",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
    
}

-(void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
    
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}

#pragma mark  -- <SKPaymentTransactionObserver> 千万不要忘记绑定，代码如下：  --
//----监听购买结果
//[[SKPaymentQueue defaultQueue] addTransactionObserver:self];

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    NSLog(@"-----paymentQueue--------  %@",transactions);
    
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:{//交易完成
                
                [self hideMBProgressHud];
                
                NSString * receiptStr = [self receiptWithTransaction:transaction];
                
                //                [self verifyPruchaseWithTransaction:transaction];
                
                [self completeTransaction:transaction];
                
                [self requestUserRechangeWithReceiptStr:receiptStr isFirst:YES];
                
                NSLog(@"-----交易完成 --------");
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CZReload" object:nil];
                
            } break;
            case SKPaymentTransactionStateFailed:{//交易失败
                
                NSLog(@"-----交易失败 --------");
                
                [self hideMBProgressHud];
                
                [self failedTransaction:transaction];
                
            }break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                
                [self restoreTransaction:transaction];
                
                NSLog(@"-----已经购买过该商品 --------");
                
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                
                NSLog(@"-----商品添加进列表 --------,购买中...");
                
                break;
            default:
                break;
        }
    }
}

-(void)completeTransaction:(SKPaymentTransaction *)transaction{
    
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}

- (void)failedTransaction: (SKPaymentTransaction *)transaction{
    
    NSLog(@"------- 购买失败   ---------");
    
    NSString * errorMessage = @"购买取消";
    if (transaction.error.code != SKErrorPaymentCancelled){
        errorMessage = @"购买失败";
    }
    
    [MBProgressHUD showProgress:errorMessage toView:[UIApplication sharedApplication].keyWindow afterDelay:1.0f];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
-(void)paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
    //    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@" 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    
    NSLog(@"-------paymentQueue----  %@",error);
    
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"test");
}

-(void)close
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
    
}

#pragma mark - 获取票据信息并64编码 --
- (NSString *)receiptWithTransaction:(SKPaymentTransaction*)transaction {
    NSData *receipt = nil;
    if ([[NSBundle mainBundle] respondsToSelector:@selector(appStoreReceiptURL)]) {
        NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
        receipt = [NSData dataWithContentsOfURL:receiptUrl];
    } else {
        if ([transaction respondsToSelector:@selector(transactionReceipt)]) {
            //Works in iOS3 - iOS8, deprected since iOS7, actual deprecated (returns nil) since iOS9
            receipt = [transaction transactionReceipt];
        }
    }
    
    //    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receipt options:NSJSONReadingAllowFragments error:nil];
    
    //base64编码
    NSString *encodingReceipt = [receipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return encodingReceipt;
}

#pragma mark 验证购买凭据
- (void)verifyPruchaseWithTransaction:(SKPaymentTransaction *)transaction
{
    
#ifdef DEBUG
#define RECEIPT_STR @"https://sandbox.itunes.apple.com/verifyReceipt"  //沙盒测试环境验证
#else
#define RECEIPT_STR @"https://buy.itunes.apple.com/verifyReceipt"      //正式环境验证
#endif
    
    // 发送网络POST请求，对购买凭据进行验证
    NSURL *url = [NSURL URLWithString:RECEIPT_STR];
    // 国内访问苹果服务器比较慢，timeoutInterval需要长一点
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    request.HTTPMethod = @"POST";
    
    // 对苹果凭票进行base64 编码
    
    NSString * receiptStr = [self receiptWithTransaction:transaction];
    
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = payloadData;
    
    // 提交验证请求，并获得官方的验证JSON结果
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // 官方验证结果为空
    if (result == nil) {
        [MBProgressHUD showProgress:@"购买凭证验证失败" toView:[UIApplication sharedApplication].keyWindow.rootViewController.view afterDelay:1.0f];
    }
    
    if (result) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"dict  == %@",dict);
        
        if (dict != nil) {
            NSLog(@"验证成功");
        }
    }
    
}

#pragma mark  -- 获取苹果充值凭票后，服务器充值请求  --

-(void)requestUserRechangeWithReceiptStr:(NSString *)receiptStr isFirst:(BOOL)isFirst{
    
//    // 获取充值/续费成功后请求数据
//    NSMutableDictionary * userRechangeDic = [self getRechangeDicWithReceiptStr:receiptStr];
//    // 获取充值/续费类型 _buyType < 6  为充值;其余为续费
////    NSString * requestUrl = _buyType < 6?USER_RECHARGE_URL_STR:USER_BUY_VIP_URL_STR;
//    NSString * requestUrl = @"http://www.baidu.com";
//
//    if (isFirst) { // 如果是新的充值/续费请求 保存凭票信息
//        // 凭票信息存入本地
//        [self saveRechangeRequestInfoWithUrl:requestUrl rechangeData:userRechangeDic];
//    }
//
//    UIView * view = isFirst?self.view:nil;
//
//    // 获取当前全部凭票订单
//    NSMutableArray * receipts = [self getReceipts];
//
//    [JCM_HTTPCommunicate createRequest:requestUrl
//                                module:usersModule
//                         curReqVersion:curReqVersion
//                             withParam:userRechangeDic
//                            withMethod:POST
//                               success:^(id result) {
//
//                                   UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
//
//                                   if ([result[@"status"] integerValue] == 0) {
//
//                                       if (isFirst) {
//                                           NSString * successMessage = _buyType<6?@"充值成功":@"会员购买成功";
//
//                                           [MBProgressHUD showProgress:successMessage toView:view afterDelay:1.0f];
//
//                                           self.paySuccessBlock();  // 充值或会员续费成功 更新当前用户余额/会员到期日期
//                                       }
//
//                                   }else if([result[@"status"] integerValue] == 3){
//                                       //                                       [self showRemoveLoginWithResult:result];
//                                   }else{
//
//                                       if (isFirst) {
//                                           [MBProgressHUD showProgress:result[@"message"] toView:view afterDelay:1.0f];
//                                       }
//
//                                   }
//
//                                   [self updateReceiptsWithReceipts:receipts];  // 连接服务器成功，删除当前凭票，并更新本地凭票列表
//
//                               } failure:^(NSError *erro) {
//
//                                   [self dispatchAfterTimeRequestWithReceiptStr:receiptStr];
//
//                               } showHUD:view];
    
}
// (拿到凭票后)获取当前充值/续费的请求信息
-(NSMutableDictionary *)getRechangeDicWithReceiptStr:(NSString *)receiptStr{
    
    
    NSMutableDictionary * uesrRechangeDic = [NSMutableDictionary requestDictionary];
    
    if (_buyType < 6) {  // 充值
        [uesrRechangeDic setValue:@(3) forKey:@"type"];
    }else{               // 会员续费
        
        NSString * type = _buyType == JCM_PriceTypeEur98?@"1":@"4";
        NSString * expert_id = _buyType == JCM_PriceTypeEur98?@"0":@"106";
        [uesrRechangeDic setValue:type forKey:@"type"];
        [uesrRechangeDic setValue:expert_id forKey:@"expert_id"];
        
    }
    
    [uesrRechangeDic setValue:product_id forKey:@"product_id"];
    NSInteger total_fee = [self getTotalFee];
    [uesrRechangeDic setValue:@(total_fee) forKey:@"total_fee"];
    [uesrRechangeDic  setValue:receiptStr forKey:@"verity_receipt"];
    
    return uesrRechangeDic;
    
}
// 获取当前充值/续费金额
-(NSInteger )getTotalFee{
    
    NSInteger  total_free = 60;
    
    switch (_buyType) {
        case JCM_PriceType60:
            total_free = 60;
            break;
        case JCM_PriceType88:
            total_free = 88;
            break;
        case JCM_PriceType128:
            total_free = 128;
            break;
        case JCM_PriceType188:
            total_free = 188;
            break;
        case JCM_PriceType268:
            total_free = 268;
            break;
        case JCM_PriceType288:
            total_free = 288;
            break;
        case JCM_PriceTypeEur98:
            total_free = 98;
            break;
        case JCM_PriceTypeSuperComp138:
            total_free = 138;
            break;
        default:
            break;
    }
    
    return total_free;
    
}
// 保存当前请求信息和请求类别到本地凭票信息列表
-(void)saveRechangeRequestInfoWithUrl:(NSString *)requestUrl rechangeData:(NSMutableDictionary *)rechangeData{
    
    // 拼接订单 存储本地 二次验证防丢单
    
    [JCM_UserManager sharedUserManager].receiptId += 1;  // 当前凭票序号加1并写入本地
    [JCM_UserManager writeUserManagerObjectToFile];
    
    NSMutableDictionary * receiptData = [NSMutableDictionary dictionary];
    [receiptData setValue:rechangeData forKey:@"data"];
    [receiptData setValue:requestUrl forKey:@"url"];
    [receiptData setValue:@([JCM_UserManager sharedUserManager].receiptId) forKey:@"receiptId"];
    
    [self saveReceiptsWithData:receiptData];
    
}

// 把凭票信息，请求信息封装成字典到本地列表
-(void)saveReceiptsWithData:(NSMutableDictionary *)dic{
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:@"receipts.xml"];
    
    NSMutableArray * receipts = [NSMutableArray arrayWithContentsOfFile:documentPath];
    
    if (!receipts) {
        receipts = [NSMutableArray array];
    }
    
    [receipts addObject:dic];
    
    [receipts writeToFile:documentPath atomically:YES];
    
}

// (一旦连接服务器成功)删除当前凭票并更新本地存储凭票列表

-(void)updateReceiptsWithReceipts:(NSMutableArray *)receipts{
    
    for (NSMutableDictionary * dic in receipts) {
        if ([[dic valueForKey:@"receiptId"]integerValue] == [JCM_UserManager sharedUserManager].receiptId) {
            [receipts removeObject:dic];
        }
    }
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:@"receipts.xml"];
    
    [receipts writeToFile:documentPath atomically:YES];
    
}
// 获取本地存储凭票列表
-(NSMutableArray *)getReceipts{
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:@"receipts.xml"];
    
    NSMutableArray * receipts = [NSMutableArray arrayWithContentsOfFile:documentPath];
    
    return receipts;
}

// 重新验证/服务器没收到凭票

-(void)dispatchAfterTimeRequestWithReceiptStr:(NSString *)receiptStr{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * 60)), dispatch_get_main_queue(), ^{
        [self requestUserRechangeWithReceiptStr:receiptStr isFirst:NO];
    });
    
}

-(void)hideMBProgressHud{
    
    UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [MBProgressHUD hideHUDForView:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [self close];
    
}

@end
