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

package com.pega.android.vehicledamagemodeling;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;

import com.badlogic.gdx.backends.android.AndroidApplication;
import com.badlogic.gdx.backends.android.AndroidApplicationConfiguration;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.pega.vehicledamagemodeling.UIUpdateCallback;
import com.pega.vehicledamagemodeling.VehicleDamageModeling;
import com.pega.vehicledamagemodeling.VehicleDamageReportCallback;

public class VehicleDamageModelingActivity extends AndroidApplication {

    public VehicleDamageModeling vehicleDamageModeling;

    public static final int REQUEST_CODE = 123;
    public static final String REPORT_EXTRA = "vehicle_damage_report_extra";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.vehicle_damage_modeling_activity);

        initVDM();
    }

    public void onCancelButtonClick(View view) {
        vehicleDamageModeling.end();
    }

    public void onCheckButtonClick(View view) {
        vehicleDamageModeling.endWithModification();
    }

    private void initVDM() {
        vehicleDamageModeling = createVDM();

        ViewGroup viewGroup = findViewById(R.id.vdm_model_container);
        viewGroup.addView(initializeForView(vehicleDamageModeling, createAppConfig()));
    }

    private VehicleDamageModeling createVDM() {
        VehicleDamageReportCallback reportCallback = new VDMReportCallback();
        final UIUpdateCallback uiCallback = new VDMUICallback();

        String report = getIntent().getStringExtra(REPORT_EXTRA);
        if (report == null || report.isEmpty()) {
            return new VehicleDamageModeling(reportCallback, uiCallback);
        } else {
            JsonObject jsonWithSelectedParts = new JsonParser().parse(report).getAsJsonObject();
            return new VehicleDamageModeling(jsonWithSelectedParts, reportCallback, uiCallback);
        }
    }

    private AndroidApplicationConfiguration createAppConfig() {
        AndroidApplicationConfiguration config = new AndroidApplicationConfiguration();
        config.useAccelerometer = false;
        config.useCompass = false;
        config.disableAudio = true;
        return config;
    }

    private class VDMReportCallback implements VehicleDamageReportCallback {
        @Override
        public void onFinished(JsonObject result) {
            Intent intent = new Intent();
            if (result != null) {
                String report = new GsonBuilder().setPrettyPrinting().create().toJson(result);
                intent.putExtra(REPORT_EXTRA, report);
            }
            setResult(RESULT_OK, intent);
            finish();
        }

        @Override
        public void onFilledMainScreenText(final String mainScreenText) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // TODO change
//                        Button userText = findViewById(R.id.user_text);
//                        Log.d("Text", "Fill Main Screen Text");
//                        userText.setText("Missing text?");
                    // userText.setText(mainScreenText);
                }
            });
        }
    }

    private class VDMUICallback implements UIUpdateCallback {
        @Override
        public void hideRotationPrompt() {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    View rotationPrompt = findViewById(R.id.vdm_rotation_prompt);
                    rotationPrompt.setVisibility(View.INVISIBLE);
                }
            });
        }
    }
}
