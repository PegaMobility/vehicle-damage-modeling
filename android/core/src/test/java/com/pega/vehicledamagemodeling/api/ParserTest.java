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

package com.pega.vehicledamagemodeling.api;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.junit.Before;
import org.junit.Test;
import java.util.HashSet;

import static org.junit.Assert.assertEquals;

public class ParserTest {
    private Parser parser;
    private JsonObject initJson;
    private static final String SELECTION = "selection";
    private static final String ID = "id";
    private static final String MAIN_SCREEN_TEXT = "prompt";
    private static final String NOTHING = "nothing";
    private static final String ROOF = "roof";
    private static final String FRONT_BUMPER = "front bumper";

    @Before
    public void setUp() {
        parser = new Parser();
        initJson = new JsonObject();
    }

    @Test
    public void whenJsonIsNullThenHashSetIsEmpty() {
        //given
        initJson = null;

        //when
        HashSet<String> hashSet = parser.parseToSelectedParts(initJson);

        //then
        assertEquals(hashSet, new HashSet<>());
    }

    @Test
    public void whenJsonContainsTwoPartsThenReturnSelectedParts() {
        //given
        JsonArray partsArray = new JsonArray();
        JsonObject jsonProperty = new JsonObject();
        jsonProperty.addProperty(ID, ROOF);
        partsArray.add(jsonProperty);
        JsonObject jsonProperty2 = new JsonObject();
        jsonProperty2.addProperty(ID, FRONT_BUMPER);
        partsArray.add(jsonProperty2);
        initJson.add(SELECTION, partsArray);
        HashSet<String> list = new HashSet<>();
        list.add(ROOF);
        list.add(FRONT_BUMPER);

        //when
        HashSet<String> result = parser.parseToSelectedParts(initJson);

        //then
        assertEquals(list, result);
    }

    @Test
    public void whenJsonIsEmptyThenReturnEmptyHashSet() {
        //given
        HashSet<String> expected = new HashSet<>();

        //when
        HashSet<String> result = parser.parseToSelectedParts(initJson);

        //then
        assertEquals(expected, result);
    }

    @Test
    public void whenHashSetContainsTwoPartsThenReturnJson() {
        //given
        HashSet<String> hashSet = new HashSet<>();
        hashSet.add(ROOF);
        hashSet.add(FRONT_BUMPER);
        JsonObject expectedJson = new JsonObject();
        JsonArray partsArray = new JsonArray();
        JsonObject jsonProperty = new JsonObject();
        jsonProperty.addProperty(ID, ROOF);
        partsArray.add(jsonProperty);
        JsonObject jsonProperty2 = new JsonObject();
        jsonProperty2.addProperty(ID, FRONT_BUMPER);
        partsArray.add(jsonProperty2);
        expectedJson.addProperty(MAIN_SCREEN_TEXT, NOTHING);
        expectedJson.add(SELECTION, partsArray);

        //when
        JsonObject result = parser.parseToJson(NOTHING, hashSet);

        //then
        assertEquals(expectedJson, result);
    }

    @Test
    public void whenHashSetIsEmptyThenReturnJsonWithoutParts() {
        //given
        HashSet<String> parts = new HashSet<>();
        JsonObject expectedJson = new JsonObject();
        expectedJson.addProperty(MAIN_SCREEN_TEXT, NOTHING);
        JsonArray partsArray = new JsonArray();
        expectedJson.add(SELECTION, partsArray);

        //when
        JsonObject result = parser.parseToJson(NOTHING, parts);

        //then
        assertEquals(expectedJson, result);
    }

    @Test
    public void whenMainScreenTextInJsonIsNotNullThenReturnCorrectText() {
        //given
        String expectedText = NOTHING;
        initJson.addProperty(MAIN_SCREEN_TEXT, NOTHING);

        //when
        String result = parser.parseToMainScreenText(initJson);

        //then
        assertEquals(expectedText, result);
    }

    @Test
    public void whenJsonDoesNotContainMainScreenTextThenReturnEmptyText() {
        //given
        String expectedText = "";

        //when
        String result = parser.parseToMainScreenText(initJson);

        //then
        assertEquals(expectedText, result);
    }
}
