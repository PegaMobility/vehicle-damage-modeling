// Copyright 2018 Flying Vehicle Monster team
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package com.pega.vehicledamagemodeling;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.assets.AssetManager;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.Model;
import com.badlogic.gdx.graphics.g3d.ModelBatch;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute;
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight;
import com.badlogic.gdx.utils.Array;
import com.google.gson.JsonObject;
import com.pega.vehicledamagemodeling.api.SelectedPartsRepository;
import com.pega.vehicledamagemodeling.api.Parser;


public class VehicleDamageModeling extends ApplicationAdapter {
    private final VehicleDamageReportCallback callback;

    private PerspectiveCamera cam;
    private LimitedCameraInputController camController;
    private ModelBatch modelBatch;
    private AssetManager assets;
    private Array<ModelInstance> instances = new Array<>();
    private Environment environment;
    private boolean loading;
    private static final String MODEL_FILE_NAME = "model.2.0.obj";

    private SelectedPartsRepository selections;

    public VehicleDamageModeling(VehicleDamageReportCallback callback) {
        this.callback = callback;
        // To report selected damage call e.g.:
        // callback.onFinished(new JsonParser().parse("{result:\"car mask\"}").getAsJsonObject());
    }

    public VehicleDamageModeling(JsonObject report, VehicleDamageReportCallback callback) {
        this(callback);

        selections = new SelectedPartsRepository(report, new Parser());

        System.out.println("Init Json: " + selections.getInitJson());
        // display given report
    }

    @Override
    public void create () {
        modelBatch = new ModelBatch();
        environment = new Environment();
        environment.set(new ColorAttribute(ColorAttribute.AmbientLight, 0.6f, 0.6f, 0.6f, 1f));
        environment.add(new DirectionalLight().set(0.8f, 0.8f, 0.8f, -0.8f, -0.8f, -0.8f));

        cam = new PerspectiveCamera(60, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        cam.position.set(20f, 20f, 20f);
        cam.lookAt(0,0,0);
        cam.update();

        camController = new LimitedCameraInputController(cam);
        Gdx.input.setInputProcessor(camController);

        assets = new AssetManager();
        assets.load(MODEL_FILE_NAME, Model.class);
        loading = true;
    }

    private void doneLoading() {
        Model car = assets.get(MODEL_FILE_NAME, Model.class);
        ModelInstance shipInstance = new ModelInstance(car, 0 , -5, 0);
        instances.add(shipInstance);
        loading = false;
    }

    @Override
    public void render () {
        if (loading && assets.update()) {
            doneLoading();
        }
        camController.update();

        Gdx.gl.glViewport(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);

        modelBatch.begin(cam);
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
    }

    @Override
    public void pause() {
    }

    @Override
    public void resume() {
    }
}