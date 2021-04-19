//
//  CarModel.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "CarModel.h"






@implementation CarModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{ @"list" : [CarListModel class],@"diffList" : [CarListModel class]};
}


@end


@implementation CarListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{ @"paramList" : [GroupParamsModel class]};
}

@end

@implementation GroupParamsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"paramList" : [ParamlistModel class]};
}


@end


@implementation ParamlistModel


@end



@implementation CarAccurateModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{ @"list" : [GroupParamsModel class]};
}


@end
