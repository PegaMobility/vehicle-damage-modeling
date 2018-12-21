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
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.google.gson.JsonObject;

public class VehicleDamageModeling extends ApplicationAdapter {

    private final VehicleDamageReportCallback callback;

    private SpriteBatch batch;
    private Texture img;

    public VehicleDamageModeling(VehicleDamageReportCallback callback) {
        this.callback = callback;

        // To report selected damage call e.g.:
        // callback.onFinished(new JsonParser().parse("{result:\"car mask\"}").getAsJsonObject());
    }

    public VehicleDamageModeling(JsonObject report, VehicleDamageReportCallback callback) {
        this(callback);
        // display given report
    }

    @Override
    public void create() {
        batch = new SpriteBatch();
        img = new Texture("cat.jpg");
    }

    @Override
    public void render() {
        Gdx.gl.glClearColor(1, 0, 0, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        batch.begin();
        batch.draw(img, 0, 0);
        batch.end();
    }

    @Override
    public void dispose() {
        batch.dispose();
        img.dispose();
    }
}