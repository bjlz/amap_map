package com.amap.flutter.map.overlays.circle;

import com.amap.flutter.map.utils.ConvertUtil;

import java.util.Map;

public class CircleUtil {
    public static String interpretCircleOptions(Object o, CircleOptionsSink sink) {
        if (null == o) {
            return null;
        }

        final Map<?, ?> data = ConvertUtil.toMap(o);

        final Object alpha = data.get("center");
        if (alpha != null) {
            sink.setCenter(ConvertUtil.toLatLng(alpha));
        }

        final Object radius = data.get("radius");
        if (radius != null) {
            sink.setRadius(ConvertUtil.toDouble(radius));
        }

        final Object strokeWidth = data.get("strokeWidth");
        if (strokeWidth != null) {
            sink.setStrokeWidth(ConvertUtil.toFloat(strokeWidth));
        }

        final Object strokeColor = data.get("strokeColor");
        if (strokeColor != null) {
            sink.setStrokeColor(ConvertUtil.toInt(strokeColor));
        }

        final Object fillColor = data.get("fillColor");
        if (fillColor != null) {
            sink.setFillColor(ConvertUtil.toInt(fillColor));
        }

        final Object visible = data.get("visible");
        if (visible != null) {
            sink.setVisible(ConvertUtil.toBoolean(visible));
        }

        final Object zIndex = data.get("zIndex");
        if (zIndex != null) {
            sink.setZIndex(ConvertUtil.toFloat(zIndex));
        }

        final String circleId = (String) data.get("id");
        if (circleId == null) {
            throw new IllegalArgumentException("circleId was null");
        } else {
            return circleId;
        }
    }
}
