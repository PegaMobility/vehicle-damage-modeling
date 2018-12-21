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

package com.pega.android.vehicledamagemodeling.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.pega.android.vehicledamagemodeling.VehicleDamageModelingActivity;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {

    private TextView textView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);
        textView = findViewById(R.id.result_text_view);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case (VehicleDamageModelingActivity.REQUEST_CODE): {
                if (resultCode == Activity.RESULT_OK) {
                    String returnValue = data.getStringExtra(VehicleDamageModelingActivity.REPORT_EXTRA);
                    textView.setText(returnValue);
                }
            }
        }
    }

    public void showVehicleModel(View view) {
        Intent intent = new Intent(this, VehicleDamageModelingActivity.class);
        String report = textView.getText().toString();
        if (!report.isEmpty()) {
            intent.putExtra(VehicleDamageModelingActivity.REPORT_EXTRA, report);
        }
        startActivityForResult(intent, VehicleDamageModelingActivity.REQUEST_CODE);
    }


}
