//
//  AMapCircle.m
//  amap_map
//
//  Created by bjlz on 2024/08/19.
//

#import "AMapCircle.h"
#import "MACircle+Flutter.h"

@interface AMapCircle ()

@property (nonatomic, strong,readwrite) MACircle *circle;

@end

@implementation AMapCircle

- (instancetype)init {
    self = [super init];
    if (self) {
        _visible = YES;
    }
    return self;
}

- (MACircle *)circle {
    if (_circle == nil) {
        _circle = [[MACircle alloc] initWithCircleId:self.id_];
        [_circle setCircleWithCenterCoordinate:self.center radius:self.radius];
    }
    return _circle;
}

/// 更新 circle 的信息
/// @param changedCircle            待更新的 circle
- (void)updateCircle:(AMapCircle *)changedCircle {
    
    NSAssert((changedCircle != nil && [self.id_ isEqualToString:changedCircle.id_]), @"更新circle数据异常");
    
    self.center = changedCircle.center;
    self.radius = changedCircle.radius;
    self.strokeWidth = changedCircle.strokeWidth;
    self.strokeColor = changedCircle.strokeColor;
    self.fillColor = changedCircle.fillColor;
    self.visible = changedCircle.visible;
    self.zIndex = changedCircle.zIndex;
    
    if (_circle) {
        [_circle setCircleWithCenterCoordinate:self.center radius:self.radius];
    }
    
}

@end
