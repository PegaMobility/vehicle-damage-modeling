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

import UIKit

extension ViewController : UITextViewDelegate {
    fileprivate static let END_WRITING_CHARACTER = "\n"
    fileprivate static let LIGHT_GRAY_COLOR = UIColor.lightGray
    fileprivate static let BLACK_COLOR = UIColor.black
    fileprivate static let DESCRIPTION_ID = "Description"
    fileprivate static let DESCRIPTION_VALUE = "Your description for FVM:"
    fileprivate static let DAMAGED_CAR_PARTS_ID = "DamagedCarParts"
    fileprivate static let DAMAGED_CAR_PARTS_VALUE = "Your damaged car parts for FVM"
    fileprivate static let DEFAULT_VALUE = ""
    fileprivate static let DEFAULT_TEXT = """
            {
            }
        """
    
    public func textView(_ textView: UITextView, shouldChangeTextIn: NSRange, replacementText: String) -> Bool {
        if replacementText == ViewController.END_WRITING_CHARACTER {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ViewController.LIGHT_GRAY_COLOR {
            textView.text = nil
            textView.textColor = ViewController.BLACK_COLOR
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = getDefaultText(textView)
            textView.textColor = ViewController.LIGHT_GRAY_COLOR
        }
    }
    
    internal func initializeManageDamagedCarPartsTextView() {
        manageDamagedCarPartsTextView.text = CurrentValue.DamagedCarParts
        manageDamagedCarPartsTextView.delegate = self
    }
    
    internal func initializeManageDescriptionTextView() {
        manageDescriptionTextView.text = CurrentValue.Description
        manageDescriptionTextView.textColor = ViewController.LIGHT_GRAY_COLOR
        manageDescriptionTextView.delegate = self
    }
    
    internal func initializeDisplayReturningJSONTextView() {
        displayReturningDataTextView.text = ViewController.DEFAULT_TEXT
    }
    
    fileprivate func getDefaultText(_ textViewId: UITextView) -> String {
        switch textViewId.restorationIdentifier {
        case ViewController.DESCRIPTION_ID:
            return ViewController.DESCRIPTION_VALUE
        case ViewController.DAMAGED_CAR_PARTS_ID:
            return ViewController.DAMAGED_CAR_PARTS_VALUE
            default:
                return ViewController.DEFAULT_VALUE
        }
    }
}
