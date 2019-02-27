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

internal class DamagedPartsValidator : Validable {
    private var provider: DamagedPartsNamesProviderProtocol
    
    init(provider: DamagedPartsNamesProviderProtocol) {
        self.provider = provider
    }
    
    public func validate(partsNames: [Selection]) -> [Selection]{
        
        var result = [Selection]();
        let actualNames = provider.getValidNames()
        
        for part in partsNames{
            if (actualNames.contains(part.id)){
                result.append(part)
            }
        }
        
        return result
    }
    
    func validate(part: Selection) -> Selection? {
        if provider.getValidNames().contains(part.id){
            return part
        }
        return nil
    }
}
