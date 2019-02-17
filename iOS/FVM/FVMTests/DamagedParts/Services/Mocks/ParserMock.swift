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

class ParserMock : JsonParser<SelectionRoot>{
    
    
    public var simpleIdCalls = 0
    
    public override func parse(data: Data?) -> SelectionRoot? {
        
        return SelectionRoot(selectionArray: [Selection]())
    }
    
    public override func parse(jsonData: String) -> SelectionRoot?{
        let simpleJson = """
{
   "selection":[
      {
         "id":"simpleId"
      }
   ]
}

"""
        if jsonData == simpleJson{
            
            simpleIdCalls = simpleIdCalls + 1
            var arrayWithOneElement = [Selection]()
            arrayWithOneElement.append(Selection(newName: "simpleId"))
            return SelectionRoot(selectionArray: arrayWithOneElement)
        }
        
        return SelectionRoot(selectionArray: [Selection]())
    }
    
}
