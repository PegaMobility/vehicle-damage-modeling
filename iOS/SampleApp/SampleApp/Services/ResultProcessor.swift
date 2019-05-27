// Copyright 2019 Flying Vehicle Monster team
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

import Foundation

extension ViewController {
    internal func getReadableDamagedParts(_ data: String) -> String? {
        let binaryData = data.data(using: .utf8)
        var selectionRoot: SelectionRoot
        do {
            selectionRoot = try JSONDecoder().decode(SelectionRoot.self, from: binaryData!)
        } catch {
            print("Invalid data, can't read damaged parts: -> \(data)")
            return nil
        }
        
        var result = ""
        for part in selectionRoot.selection {
            result.append("\(part.id); ")
        }
        return result
    }
    
    internal func getConfigurationData() -> String {
        ResultContainer.damagedCarParts = partsTextView.text
        ResultContainer.description = descriptionTextView.text
        let damagedParts = selectionFormatter.format(ResultContainer.damagedCarParts)
        return """
        {
        "prompt": "\(ResultContainer.description)",
        "selection": [\(damagedParts)]
        }
        """
    }
}
