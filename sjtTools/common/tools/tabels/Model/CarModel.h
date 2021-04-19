//
//  CarModel.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class  CarListModel,GroupParamsModel, ParamlistModel,CarAccurateModel;


@interface CarModel : NSObject
@property (nonatomic,   copy) NSString *token;

@property (nonatomic,   copy) NSString *vin;

@property (nonatomic, assign) NSInteger carNum;

@property (nonatomic, assign) NSInteger isSelect;

@property (nonatomic, strong) NSArray<CarListModel *> *list;

@property (nonatomic, strong) NSArray<CarListModel *> *diffList;

@property (nonatomic,   copy) NSString *precision;

@property (nonatomic,   copy) NSString *model_name;

@end

@interface CarListModel : NSObject

@property (nonatomic, strong) NSArray<GroupParamsModel *> *paramList;

@property (nonatomic, strong) NSString *model_id;

@property (nonatomic,   copy) NSString *model_name;

@property (nonatomic, assign) NSInteger isSelect;

@end


@interface GroupParamsModel : NSObject

@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic,   copy) NSString *name;

@property (nonatomic, strong) NSArray<ParamlistModel *> *paramList;

@end


@interface ParamlistModel : NSObject


@property (nonatomic,   copy) NSString *name;

@property (nonatomic,   copy) NSString *value;

@end


@interface CarAccurateModel : NSObject
@property (nonatomic,   copy) NSString *imgUrl;

@property (nonatomic,   copy) NSString *vin;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic,   copy) NSString *modelName;

@property (nonatomic, strong) NSArray<GroupParamsModel *> *list;
@property (nonatomic,   copy) NSString *modelPrice;
@end
