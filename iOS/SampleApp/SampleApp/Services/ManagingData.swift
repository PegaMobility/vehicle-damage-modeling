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
    internal func prepareDamagedCarPartsToSend() -> String {
        func removeRedundantCharacters() -> String {
            return CurrentValue.DamagedCarParts.replacingOccurrences(of: " ", with: ";").replacingOccurrences(of: ",", with: ";")
        }
        
        func parseDamagedCarParts(toParse tmp: String) -> String {
            let elems = tmp.split(separator: ";")
            var result = ""
            var first = true
            for e in elems {
                if first {
                    first = false
                }
                else {
                    result.append(",")
                }
                
                result.append("{ \"id\" : \"")
                result.append(String(e))
                result.append("\" }")
            }
            return result
        }
        
        return parseDamagedCarParts(toParse: removeRedundantCharacters())
    }
    
    internal func fillDamagedCarPartsTextView (_ returningJSON: String) {
        func removeRedundantCharacters(_ tmp: String) -> String {
            return tmp.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "id", with: "")
        }
        
        let tmp = returningJSON.split(separator: ":")
        var i = 0
        var result = ""
        for t in tmp {
            if i < 3 {
                i = i + 1
            }
            else {
                let elem = removeRedundantCharacters(String(t))
                result.append(elem)
                result.append("; ")
            }
            
        }
        
        CurrentValue.DamagedCarParts = result
        manageDamagedCarPartsTextView.text = result
    }
    
    internal func prepareJSONToSend() -> String {
        updateCurrentValuesBeforeSending()
        
        return """
        {
        "mainScreenText": "\(CurrentValue.Description)",
        "selection": [\(prepareDamagedCarPartsToSend())]
        }
        """
    }
    
    internal func updateCurrentValuesBeforeSending() {
        CurrentValue.DamagedCarParts = manageDamagedCarPartsTextView.text
        CurrentValue.Description = manageDescriptionTextView.text
    }
}
