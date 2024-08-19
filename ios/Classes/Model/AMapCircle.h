//
//  AMapCircle.h
//  amap_map
//
//  Created by bjlz on 2024/08/19.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapCircle : NSObject

@property (nonatomic, copy) NSString *id_;

@property (nonatomic, assign) CLLocationCoordinate2D center;

@property (nonatomic, assign) CLLocationDistance radius;

@property (nonatomic, assign) CGFloat strokeWidth;

@property (nonatomic, retain) UIColor *strokeColor;

@property (nonatomic, retain) UIColor *fillColor;

@property (nonatomic, assign) bool visible;

@property (nonatomic, assign) double zIndex;

/// 由以上数据生成的 circle 对象
@property (nonatomic, strong,readonly) MACircle *circle;

/// 更新 circle 的信息
/// @param changedCircle 带修改信息的 circle
- (void)updateCircle:(AMapCircle *)changedCircle;

@end

NS_ASSUME_NONNULL_END
