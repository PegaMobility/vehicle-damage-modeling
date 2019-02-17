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

public class DemagedPartsServiceImpl: DemagePartsService{

    private var demagedParts = [Selection]()
    private var parser: AbstractParser<SelectionRoot>
    
    init(parser: AbstractParser<SelectionRoot>) {
        self.parser = parser
    }
    
    public func CreateAndGetCollectionOfDamagedParts(json: String) -> [Selection] {
        CreateCollectionOfDamagedParts(json: json)
        return GetCollectionOfDamagedParts()
    }
    
    public func GetCollectionOfDamagedParts() -> [Selection] {
        return demagedParts
    }
    
    public func CreateCollectionOfDamagedParts(json: String) {
        let root = parser.parse(jsonData: json)
        demagedParts = (root?.selection)!;
    }
    
}
