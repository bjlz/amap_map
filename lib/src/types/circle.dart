import 'dart:ui';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/x_amap_base.dart';

/// 圆形覆盖物
class Circle extends BaseOverlay {
  Circle({
    required this.center,
    required this.radius,
    this.strokeWidth = 10.0,
    this.strokeColor = Colors.black,
    this.fillColor = Colors.transparent,
    this.zIndex = 0,
    this.visible = true,
  });

  /// 中心位置
  final LatLng center;

  /// 圆半径
  final double radius;

  /// 框线宽度
  final double strokeWidth;

  /// 框线颜色
  final Color strokeColor;

  /// 填充颜色
  final Color fillColor;

  /// Z 轴位置
  final int zIndex;

  /// 是否可见
  final bool visible;

  /// 拷贝
  Circle copyWith({
    LatLng? center,
    double? radius,
    double? strokeWidth,
    Color? strokeColor,
    Color? fillColor,
    int? zIndex,
    bool? visible,
  }) {
    final copy = Circle(
      center: center ?? this.center,
      radius: radius ?? this.radius,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      fillColor: fillColor ?? this.fillColor,
      zIndex: zIndex ?? this.zIndex,
      visible: visible ?? this.visible,
    );
    copy.setIdForCopy(this.id);
    return copy;
  }

  Circle clone() => copyWith();

  @override
  Map<String, dynamic> toMap() {
    final json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('id', id);
    addIfPresent('center', center.toJson());
    addIfPresent('radius', radius);
    addIfPresent('strokeWidth', strokeWidth);
    addIfPresent('strokeColor', strokeColor.value);
    addIfPresent('fillColor', fillColor.value);
    addIfPresent('zIndex', zIndex);
    addIfPresent('visible', visible);
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! Circle) return false;
    final Circle typedOther = other;
    return id == typedOther.id &&
        center == typedOther.center &&
        radius == typedOther.radius &&
        strokeWidth == typedOther.strokeWidth &&
        strokeColor == typedOther.strokeColor &&
        fillColor == typedOther.fillColor &&
        zIndex == typedOther.zIndex &&
        visible == typedOther.visible;
  }

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'Circle@$hashCode { '
        'id: $id, '
        'center: $center, '
        'radius: $radius, '
        'strokeWidth: $strokeWidth, '
        'strokeColor: $strokeColor, '
        'fillColor: $fillColor, '
        'zIndex: $zIndex, '
        'visible: $visible, '
        '}';
  }
}

Map<String, Circle> keyByCircleId(Iterable<Circle> circles) {
  return Map<String, Circle>.fromEntries(
    circles.map(
      (Circle circle) => MapEntry<String, Circle>(circle.id, circle.clone()),
    ),
  );
}
