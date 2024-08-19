package com.amap.flutter.map.overlays.circle;

import com.amap.api.maps.model.LatLng;

public interface CircleOptionsSink {

    void setCenter(LatLng latLng);

    void setRadius(double radius);

    void setStrokeWidth(float strokeWidth);

    void setStrokeColor(int strokeColor);

    void setFillColor(int fillColor);

    void setVisible(boolean visible);

    void setZIndex(float zIndex);

}
