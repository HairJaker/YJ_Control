//
//  JCM_DataBaseManager.h
//  竞彩猫
//
//  Created by yujie on 17/1/12.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCM_DataBaseManager : NSObject

singlent_for_interface(JCM_DataBaseManager);

#pragma mark - 属性
#pragma mark 数据库引用，使用它进行数据库操作
@property (nonatomic,strong) FMDatabaseQueue * databaseQueue;


#pragma mark - 共有方法
/**
 *  打开数据库
 *
 *  @param dbname 数据库名称
 */
-(void)openDb:(NSString *)dbname;

/**
 *  执行无返回值的sql
 *
 *  @param sql sql语句
 */
-(void)executeNonQuery:(NSString *)sql;

/**
 *  执行有返回值的sql
 *
 *  @param sql sql语句
 *
 *  @return 查询结果
 */
-(NSArray *)executeQuery:(NSString *)sql;

@end
