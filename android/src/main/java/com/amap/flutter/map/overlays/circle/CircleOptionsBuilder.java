package com.amap.flutter.map.overlays.circle;

import com.amap.api.maps.model.CircleOptions;
import com.amap.api.maps.model.LatLng;

class CircleOptionsBuilder implements CircleOptionsSink {
    final CircleOptions circleOptions;

    CircleOptionsBuilder() {
        this.circleOptions = new CircleOptions();
    }

    public CircleOptions build() {
        return circleOptions;
    }

    @Override
    public void setCenter(LatLng latLng) {
        circleOptions.center(latLng);
    }

    @Override
    public void setRadius(double radius) {
        circleOptions.radius(radius);
    }

    @Override
    public void setStrokeWidth(float strokeWidth) {
        circleOptions.strokeWidth(strokeWidth);
    }

    @Override
    public void setStrokeColor(int strokeColor) {
        circleOptions.strokeColor(strokeColor);
    }

    @Override
    public void setFillColor(int fillColor) {
        circleOptions.fillColor(fillColor);
    }

    @Override
    public void setVisible(boolean visible) {
        circleOptions.visible(visible);
    }

    @Override
    public void setZIndex(float zIndex) {
        circleOptions.zIndex(zIndex);
    }

}
