package com.pega.vehicledamagemodeling.api;

import com.badlogic.gdx.graphics.Camera;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.math.collision.BoundingBox;
import com.badlogic.gdx.math.collision.Ray;
import com.badlogic.gdx.utils.Array;

import org.junit.Before;
import org.junit.Test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class PartSelectionDetectorTest {

    private int screenX;
    private int screenY;

    @Before
    public void setUp() {
        screenX = (int)(Math.random() % 100);
        screenY = (int)(Math.random() % 100);
    }

    @Test
    public void whenSwipeThenIgnoreAction() {
        // given
        SelectionService selectionService = mock(SelectionService.class);

        PartSelectionDetector selectedDetector = new PartSelectionDetector(null, null, selectionService);

        // when
        selectedDetector.touchDown(screenX, screenY, 0, 0);
        selectedDetector.touchUp(screenX + 20, screenY + 15, 0, 0);

        // then
        verify(selectionService, times(0)).setSelectedPart(any());
    }


    @Test
    public void whenTapThenDetectAction() {
        // given
        Camera camera = mock(PerspectiveCamera.class);
        Ray ray = new Ray(new Vector3(0, -2, 0), new Vector3(0, 2, 0));
        when(camera.getPickRay(screenX, screenY)).thenReturn(ray);

        Array<ModelInstance> modelInstances = new Array<>();
        ModelInstance modelInstance = mock(ModelInstance.class);
        BoundingBox boundingBox = new BoundingBox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));
        when(modelInstance.calculateBoundingBox(any(BoundingBox.class))).thenReturn(boundingBox);
        modelInstances.add(modelInstance);

        SelectionService selectionService = mock(SelectionService.class);

        PartSelectionDetector selectedDetector = new PartSelectionDetector(camera, modelInstances, selectionService);

        // when
        selectedDetector.touchDown(screenX, screenY, 0, 0);
        selectedDetector.touchUp(screenX, screenY, 0, 0);

        // then
        verify(selectionService, times(1)).setSelectedPart(any());
    }
}