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

internal class DamagedPartsRepository : DamagedPartsRepositoryProtocol {
    private var selections = [Selection]()
    
    public func clear(){
        selections.removeAll()
    }
    
    public func add(selection: Selection){
        if !selections.contains(selection){
            selections.append(selection)
        }
    }
    
    public func remove(selection: Selection){
        remove(partId: selection.id)
    }
    
    public func add(selections: [Selection]){
        for selection in selections{
            add(selection: selection)
        }
    }
    
    public func remove(partId: String){
        selections.removeAll{$0.id == partId}
    }
    
    public func getAll() -> [Selection]{
        return selections
    }
}
