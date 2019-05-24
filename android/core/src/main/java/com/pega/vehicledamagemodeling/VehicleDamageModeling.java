/*
 * Copyright (c) 2019 Flying Vehicle Monster team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.pega.vehicledamagemodeling;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputMultiplexer;
import com.badlogic.gdx.assets.AssetManager;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.Model;
import com.badlogic.gdx.graphics.g3d.ModelBatch;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute;
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight;
import com.badlogic.gdx.utils.Array;
import com.google.gson.JsonObject;
import com.pega.vehicledamagemodeling.api.Parser;
import com.pega.vehicledamagemodeling.api.PartSelectionDetector;
import com.pega.vehicledamagemodeling.api.SelectedPartsRepository;
import com.pega.vehicledamagemodeling.api.SelectionService;

import static com.badlogic.gdx.Gdx.gl;
import static com.badlogic.gdx.Gdx.graphics;
import static com.badlogic.gdx.graphics.GL20.GL_COLOR_BUFFER_BIT;
import static com.badlogic.gdx.graphics.GL20.GL_DEPTH_BUFFER_BIT;
import static com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute.AmbientLight;

public class VehicleDamageModeling extends ApplicationAdapter {
    private ModelBatch modelBatch;
    private Environment environment;
    private PerspectiveCamera camera;
    private LimitedCameraInputController cameraController;
    private SelectionService selectionService = new SelectionService(new SelectedPartsRepository(), new Parser());
    private AssetManager assets;
    private Array<ModelInstance> instances = new Array<>();
    private JsonObject jsonWithSelectedParts;
    private boolean loading;
    private final VehicleDamageReportCallback callback;
    private final UIUpdateCallback uiUpdateCallback;
    private static final String MODEL_FILE_NAME = "model.obj";

    public VehicleDamageModeling(VehicleDamageReportCallback callback, UIUpdateCallback uiUpdateCallback) {
        this.callback = callback;
        this.uiUpdateCallback = uiUpdateCallback;
    }

    public VehicleDamageModeling(JsonObject jsonWithSelectedParts, VehicleDamageReportCallback callback, UIUpdateCallback uiUpdateCallback) {
        this(callback, uiUpdateCallback);
        this.jsonWithSelectedParts = jsonWithSelectedParts;
    }

    @Override
    public void create () {
        modelBatch = new ModelBatch();
        environment = new Environment();
        environment.set(new ColorAttribute(AmbientLight, 0.6f, 0.6f, 0.6f, 1f));
        environment.add(new DirectionalLight().set(0.8f, 0.8f, 0.8f, -0.8f, -0.8f, -0.8f));

        camera = new PerspectiveCamera(60, graphics.getWidth(), graphics.getHeight());
        camera.position.set(20f, 20f, 20f);
        camera.lookAt(0,0,0);
        camera.update();

        PartSelectionDetector partSelectionDetector = new PartSelectionDetector(camera, instances, selectionService, uiUpdateCallback);
        cameraController = new LimitedCameraInputController(camera, uiUpdateCallback);
        Gdx.input.setInputProcessor(new InputMultiplexer(partSelectionDetector, cameraController));

        assets = new AssetManager();
        assets.load(MODEL_FILE_NAME, Model.class);
        loading = true;
    }

    private void doneLoading() {
        Model model = assets.get(MODEL_FILE_NAME, Model.class);

        for (int i = 0; i < model.nodes.size; i++) {
            String id = model.nodes.get(i).id;
            ModelInstance instance = new ModelInstance(model, id, true);

            instances.add(instance);
        }

        if (jsonWithSelectedParts != null) {
            selectionService.attachJson(jsonWithSelectedParts, instances);
        }

        loading = false;
        uiUpdateCallback.fillMainScreenText(selectionService.getMainScreenText());
    }

    @Override
    public void render () {
        if (loading && assets.update()) {
            doneLoading();
        }
        cameraController.update();

        gl.glViewport(0, 0, graphics.getWidth(), graphics.getHeight());
        gl.glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        gl.glClearColor(1,1,1,1);

        modelBatch.begin(camera);
        modelBatch.render(instances, environment);
        modelBatch.end();
    }

    @Override
    public void dispose () {
        modelBatch.dispose();
        instances.clear();
        assets.dispose();
    }

    @Override
    public void resize(int width, int height) {
        camera.viewportHeight = height;
        camera.viewportWidth = width;
        camera.update();
    }

    public void end(){
        callback.onFinished(selectionService.getInitJson());
    }

    public void endWithModification(){
        callback.onFinished(selectionService.getModifiedJson());
    }
}