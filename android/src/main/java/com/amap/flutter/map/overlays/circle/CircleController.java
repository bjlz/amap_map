package com.amap.flutter.map.overlays.circle;

import com.amap.api.maps.model.Circle;
import com.amap.api.maps.model.LatLng;

class CircleController implements CircleOptionsSink {
    private final Circle circle;
    private final String circleId;

    CircleController(Circle circle) {
        this.circle = circle;
        circleId = circle.getId();
    }

    public String getCircleId() {
        return circleId;
    }

    public void remove() {
        if (null != circle) {
            circle.remove();
        }
    }

    @Override
    public void setCenter(LatLng latLng) {
        circle.setCenter(latLng);
    }

    @Override
    public void setRadius(double radius) {
        circle.setRadius(radius);
    }

    @Override
    public void setStrokeWidth(float strokeWidth) {
        circle.setStrokeWidth(strokeWidth);
    }

    @Override
    public void setStrokeColor(int strokeColor) {
        circle.setStrokeColor(strokeColor);
    }

    @Override
    public void setFillColor(int fillColor) {

    }

    @Override
    public void setZIndex(float zIndex) {
        circle.setZIndex(zIndex);
    }

    @Override
    public void setVisible(boolean visible) {
        circle.setVisible(visible);
    }
}
