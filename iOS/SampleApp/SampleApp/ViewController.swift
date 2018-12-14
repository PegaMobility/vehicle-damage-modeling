// Copyright 2018 Pegasystems Inc.
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
import FVM

class ViewController: UIViewController {
    @IBOutlet weak var damageSelector: FVMCarModelViewController!
    
    override func viewDidLoad() {
        damageSelector.viewDidLoad()
        damageSelector.drawPyramid()
        super.viewDidLoad()
    }
    
    @IBAction func showParts(_ sender: UIButton) {
   //     let alert = UIAlertController(title: "Selected parts",
   //                                   message: damageSelector.selectedPartsJSON,
   //                                  preferredStyle: UIAlertController.Style.alert)
   //    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
   //     self.present(alert, animated: true)
    }
}
