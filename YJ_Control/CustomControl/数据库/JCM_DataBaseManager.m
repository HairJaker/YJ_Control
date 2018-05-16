//
//  JCM_DataBaseManager.m
//  竞彩猫
//
//  Created by yujie on 17/1/12.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_DataBaseManager.h"

@implementation JCM_DataBaseManager

singlent_for_implementation(JCM_DataBaseManager)

-(instancetype)init{
    
    JCM_DataBaseManager * dbManager = [super init];
    
    if (dbManager) {
        [dbManager openDb:DATABASE_NAME];
    }

    return dbManager;
}


-(void)openDb:(NSString *)dbname{
    
    /*
     * 取得数据库保存路径，通常保存沙盒Documents目录
     */
    
    NSString *filePath=[DOCUMENT_DIRECTORY stringByAppendingPathComponent:dbname];
    
    NSLog(@"filePath = %@",filePath);
    
    //如果有数据库则直接打开，否则创建并打开（注意filePath是ObjC中的字符串，需要转化为C语言字符串类型）
    //创建FMDatabaseQueue对象
    self.databaseQueue=[FMDatabaseQueue databaseQueueWithPath:filePath];

}

-(void)executeNonQuery:(NSString *)sql{
    //执行更新sql语句，用于插入、修改、删除
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
}

-(NSArray *)executeQuery:(NSString *)sql{
    NSMutableArray *array=[NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        //执行查询sql语句
        FMResultSet *result= [db executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<result.columnCount; ++i) {
                dic[[result columnNameForIndex:i]]=[result stringForColumnIndex:i];
            }
            [array addObject:dic];
        }
    }];
    return array;
}

@end
