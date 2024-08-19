//
//  MACircle+Flutter.h
//  amap_map
//
//  Created by bjlz on 2024/08/19.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 该拓展类型主要用于对地图原 MACircle 添加一个唯一 id,
/// 便于在地图回调代理中，通过 id 快速找到对应的 AMapCircle 对象，
/// 以此来构建对应的 CircleRender

@interface MACircle (Flutter)

@property (nonatomic,copy,readonly) NSString *circleId;

/// 使用 circleId 初始化对应的 MACircle
/// @param circleId         circle 的唯一标识
- (instancetype)initWithCircleId:(NSString *)circleId;

@end

NS_ASSUME_NONNULL_END
