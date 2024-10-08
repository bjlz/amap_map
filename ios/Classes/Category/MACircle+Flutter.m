//
//  MACircle+Flutter.m
//  amap_map
//
//  Created by bjlz on 2024/08/19.
//

#import "MACircle+Flutter.h"
#import <objc/runtime.h>

@implementation MACircle (Flutter)

- (NSString *)circleId {
    return objc_getAssociatedObject(self, @selector(circleId));
}

- (void)setCircleId:(NSString * _Nonnull)circleId {
    objc_setAssociatedObject(self, @selector(circleId), circleId, OBJC_ASSOCIATION_COPY);
}

- (instancetype)initWithCircleId:(NSString *)circleId {
    self = [super init];
    if (self) {
        self.circleId = circleId;
    }
    return self;
}

@end
