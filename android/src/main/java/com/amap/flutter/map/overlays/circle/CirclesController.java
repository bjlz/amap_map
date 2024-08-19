package com.amap.flutter.map.overlays.circle;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.amap.api.maps.AMap;
import com.amap.api.maps.model.Circle;
import com.amap.api.maps.model.CircleOptions;
import com.amap.flutter.map.MyMethodCallHandler;
import com.amap.flutter.map.overlays.AbstractOverlayController;
import com.amap.flutter.map.utils.Const;
import com.amap.flutter.map.utils.ConvertUtil;
import com.amap.flutter.map.utils.LogUtil;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CirclesController
        extends AbstractOverlayController<CircleController>
        implements MyMethodCallHandler {
    private static final String CLASS_NAME = "CirclesController";

    public CirclesController(MethodChannel methodChannel, AMap amap) {
        super(methodChannel, amap);
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_CIRCLE;
    }


    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        LogUtil.i(CLASS_NAME, "doMethodCall===>" + call.method);
        switch (call.method) {
            case Const.METHOD_CIRCLE_UPDATE:
                invokeCircleOptions(call, result);
                break;
        }
    }


    /**
     * 执行主动方法更新 circle
     */
    public void invokeCircleOptions(MethodCall methodCall, MethodChannel.Result result) {
        if (null == methodCall) {
            return;
        }
        Object circlesToAdd = methodCall.argument("circlesToAdd");
        addByList((List<Object>) circlesToAdd);
        Object circlesToChange = methodCall.argument("circlesToChange");
        updateByList((List<Object>) circlesToChange);
        Object circleIdsToRemove = methodCall.argument("circleIdsToRemove");
        removeByIdList((List<Object>) circleIdsToRemove);
        result.success(null);
    }

    public void addByList(List<Object> circlesToAdd) {
        if (circlesToAdd != null) {
            for (Object circleToAdd : circlesToAdd) {
                add(circleToAdd);
            }
        }
    }

    private void add(Object circleObj) {
        if (null != amap) {
            CircleOptionsBuilder builder = new CircleOptionsBuilder();
            String dartCircleId = CircleUtil.interpretCircleOptions(circleObj, builder);
            if (!TextUtils.isEmpty(dartCircleId)) {
                CircleOptions circleOptions = builder.build();
                final Circle circle = amap.addCircle(circleOptions);
                CircleController circleController = new CircleController(circle);
                controllerMapByDartId.put(dartCircleId, circleController);
                idMapByOverlyId.put(circle.getId(), dartCircleId);
            }
        }
    }

    private void updateByList(List<Object> circlesToChange) {
        if (circlesToChange != null) {
            for (Object circleToChange : circlesToChange) {
                update(circleToChange);
            }
        }
    }

    private void update(Object circleToChange) {
        Object dartCircleId = ConvertUtil.getKeyValueFromMapObject(circleToChange, "id");
        if (null != dartCircleId) {
            CircleController circleController = controllerMapByDartId.get(dartCircleId);
            if (null != circleController) {
                CircleUtil.interpretCircleOptions(circleToChange, circleController);
            }
        }
    }

    private void removeByIdList(List<Object> circleIdsToRemove) {
        if (circleIdsToRemove == null) {
            return;
        }
        for (Object rawCircleId : circleIdsToRemove) {
            if (rawCircleId == null) {
                continue;
            }
            String circleId = (String) rawCircleId;
            final CircleController circleController = controllerMapByDartId.remove(circleId);
            if (circleController != null) {
                idMapByOverlyId.remove(circleController.getCircleId());
                circleController.remove();
            }
        }
    }
}
