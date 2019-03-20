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
import FVM

class ViewController: UIViewController {
    @IBOutlet weak var manageDescriptionTextView: UITextView!
    @IBOutlet weak var manageDamagedCarPartsTextView: UITextView!
    @IBOutlet weak var goesToFVMButton: UIButton!
    @IBOutlet weak var displayReturningDataTextView: UITextView!
    
    override func viewDidLoad() {
        initializeManageDamagedCarPartsTextView()
        initializeManageDescriptionTextView()
        initializeDisplayReturningJSONTextView()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CurrentValue.FirstTimeInformation == true {
            showFirstTimeOpenAppInformationAlert()
        }
        else {
            showInformationAlertWhenReturingFVM()
        }
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is FVMDamagedCarViewController {
            let fvmController = segue.destination as? FVMDamagedCarViewController
            fvmController!.configurationData = prepareJSONToSend()
            
            fvmController!.getReturningData = { returningData in
                self.fillDamagedCarPartsTextView(returningData)
                self.displayReturningDataTextView.text = returningData
            }
        }
    }
}
