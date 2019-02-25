// Copyright 2019 Flying Vehicle Monster team
///Users/smyks/repos/vehicle-damage-modeling/iOS/FVM/FVM/art.scnassets
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

import Foundation

public class JsonParser <Element: Decodable>{
    public func parse(data: Data?) -> Element? {
        let selectionRoot = try? JSONDecoder().decode(Element.self, from: data!)
        return selectionRoot
    }
    
    public func parse(jsonData: String) -> Element?{
        let data = jsonData.data(using: .utf8)
        let selectionRoot = parse(data: data)
        return selectionRoot
    }
}
