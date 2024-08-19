import 'package:flutter/foundation.dart' show setEquals;

import 'circle.dart';
import 'types.dart';

/// 用以描述 Circle 的更新项
class CircleUpdates {
  /// 根据之前的 circle 列表 [previous] 和当前的 circle 列表 [current] 创建 [MakerUpdates].
  CircleUpdates.from(Set<Circle> previous, Set<Circle> current) {
    // ignore: unnecessary_null_comparison
    if (previous == null) {
      previous = Set<Circle>.identity();
    }

    // ignore: unnecessary_null_comparison
    if (current == null) {
      current = Set<Circle>.identity();
    }

    final Map<String, Circle> previousMarkers = keyByCircleId(previous);
    final Map<String, Circle> currentMarkers = keyByCircleId(current);

    final Set<String> prevMarkerIds = previousMarkers.keys.toSet();
    final Set<String> currentMarkerIds = currentMarkers.keys.toSet();

    Circle idToCurrentMarker(String id) {
      return currentMarkers[id]!;
    }

    final Set<String> _markerIdsToRemove =
        prevMarkerIds.difference(currentMarkerIds);

    final Set<Circle> _markersToAdd = currentMarkerIds
        .difference(prevMarkerIds)
        .map(idToCurrentMarker)
        .toSet();

    bool hasChanged(Circle current) {
      final Circle? previous = previousMarkers[current.id];
      return current != previous;
    }

    final Set<Circle> _markersToChange = currentMarkerIds
        .intersection(prevMarkerIds)
        .map(idToCurrentMarker)
        .where(hasChanged)
        .toSet();

    circlesToAdd = _markersToAdd;
    circleIdsToRemove = _markerIdsToRemove;
    circlesToChange = _markersToChange;
  }

  /// 想要添加的 circle 集合.
  Set<Circle>? circlesToAdd;

  /// 想要删除的 circle 的 id 集合
  Set<String>? circleIdsToRemove;

  /// 想要更新的 circle 集合.
  Set<Circle>? circlesToChange;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('circlesToAdd', serializeOverlaySet(circlesToAdd!));
    addIfNonNull('circlesToChange', serializeOverlaySet(circlesToChange!));
    addIfNonNull('circleIdsToRemove', circleIdsToRemove?.toList());

    return updateMap;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! CircleUpdates) return false;
    final CircleUpdates typedOther = other;
    return setEquals(circlesToAdd, typedOther.circlesToAdd) &&
        setEquals(circleIdsToRemove, typedOther.circleIdsToRemove) &&
        setEquals(circlesToChange, typedOther.circlesToChange);
  }

  @override
  int get hashCode =>
      Object.hashAll([circlesToAdd, circleIdsToRemove, circlesToChange]);

  @override
  String toString() {
    return 'CircleUpdates { '
        'circlesToAdd: $circlesToAdd, '
        'circleIdsToRemove: $circleIdsToRemove, '
        'circlesToChange: $circlesToChange '
        '}';
  }
}
