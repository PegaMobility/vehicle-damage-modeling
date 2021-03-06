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
@testable import FVM

class ParserMock : Serializer <SelectionRoot> {
    public var parseCalls = 0
    
    public override func deserialize(data: Data?) -> SelectionRoot? {
        return SelectionRoot(selectionArray: [Selection](), text: "")
    }
    
    public override func deserialize(jsonData: String) -> SelectionRoot?{
        let simpleJson = simpleJsonWithOnePart.0
        let expectedValue = simpleJsonWithOnePart.1[0].id
        parseCalls += 1
        if jsonData == simpleJson{
            
            var arrayWithOneElement = [Selection]()
            arrayWithOneElement.append(Selection(newName: expectedValue))
            return SelectionRoot(selectionArray: arrayWithOneElement, text: "")
        }
        
        return SelectionRoot(selectionArray: [Selection](), text: "")
    }
}
