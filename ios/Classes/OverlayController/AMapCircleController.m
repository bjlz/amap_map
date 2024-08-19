//
//  AMapCircleController.m
//  amap_map
//
//  Created by bjlz on 2024/08/19.
//

#import "AMapCircleController.h"
#import "AMapCircle.h"
#import "AMapJsonUtils.h"
#import "AMapConvertUtil.h"
#import "FlutterMethodChannel+MethodCallDispatch.h"

@interface AMapCircleController ()

@property (nonatomic,strong) NSMutableDictionary<NSString*,AMapCircle*> *circleDict;
@property (nonatomic,strong) FlutterMethodChannel *methodChannel;
@property (nonatomic,strong) NSObject<FlutterPluginRegistrar> *registrar;
@property (nonatomic,strong) MAMapView *mapView;

@end

@implementation AMapCircleController

- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(MAMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    self = [super init];
    if (self) {
        _methodChannel = methodChannel;
        _mapView = mapView;
        _circleDict = [NSMutableDictionary dictionaryWithCapacity:1];
        _registrar = registrar;
        
        __weak typeof(self) weakSelf = self;
        [_methodChannel addMethodName:@"circles#update" withHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            id circlesToAdd = call.arguments[@"circlesToAdd"];
            if ([circlesToAdd isKindOfClass:[NSArray class]]) {
                [weakSelf addCircles:circlesToAdd];
            }
            id circlesToChange = call.arguments[@"circlesToChange"];
            if ([circlesToChange isKindOfClass:[NSArray class]]) {
                [weakSelf changeCircles:circlesToChange];
            }
            id circleIdsToRemove = call.arguments[@"circleIdsToRemove"];
            if ([circleIdsToRemove isKindOfClass:[NSArray class]]) {
                [weakSelf removeCircleIds:circleIdsToRemove];
            }
            result(nil);
        }];
    }
    return self;
}

- (nullable AMapCircle *)circleForId:(NSString *)circleId {
    return _circleDict[circleId];
}

- (void)addCircles:(NSArray*)circlesToAdd {
    for (NSDictionary* circleDict in circlesToAdd) {
        AMapCircle *circleModel = [AMapJsonUtils modelFromDict:circleDict modelClass:[AMapCircle class]];

        // 先加入到字段中，避免后续的地图回调里，取不到对应的circle数据
        if (circleModel.id_) {
            _circleDict[circleModel.id_] = circleModel;
        }
        [self.mapView addOverlay:circleModel.circle];
    }
}

- (void)changeCircles:(NSArray*)circlesToChange {
    for (NSDictionary* circleToChange in circlesToChange) {
        NSLog(@"changeCircles:%@",circleToChange);
        AMapCircle *circleModelToChange = [AMapJsonUtils modelFromDict:circleToChange modelClass:[AMapCircle class]];
        AMapCircle *currentCircleModel = _circleDict[circleModelToChange.id_];
        NSAssert(currentCircleModel != nil, @"需要修改的circle不存在");
        
        [currentCircleModel updateCircle:circleModelToChange];
    }
}

- (void)removeCircleIds:(NSArray*)circleIdsToRemove {
    for (NSString* circleId in circleIdsToRemove) {
        if (!circleId) {
            continue;
        }
        
        AMapCircle* circle = _circleDict[circleId];
        if (!circle) {
            continue;
        }

        [self.mapView removeOverlay:circle.circle];
        [_circleDict removeObjectForKey:circleId];
    }
}

@end
