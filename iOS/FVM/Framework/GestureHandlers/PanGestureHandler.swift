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

fileprivate struct NumberOfTouches {
    internal static let min: Int = 1
    internal static let max: Int = 2
}

fileprivate struct RotateConstraint {
    internal static let minAngle: Float = -0.15
    internal static let maxAngle: Float = 0.35
}

fileprivate struct LastRatio {
    internal static var width: Float = 1.2
    internal static var height: Float = 0.0
    
    internal static func reset() {
        width = 1.2
        height = 0.0
    }
}

extension FVMCarModelViewController {
    @objc
    internal func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        hideRotationPrompt()
        
        let translation = gestureRecognizer.translation(in: self)
        let widthRatio = Float(translation.x) / Float(self.frame.size.width) + LastRatio.width
        var heightRatio = Float(translation.y) / Float(self.frame.size.height) + LastRatio.height
        truncateRatioConstraintsOverflow(&heightRatio)
        
        scnCameraOrbit.eulerAngles.y = -2 * Float.pi * widthRatio
        scnCameraOrbit.eulerAngles.x = -Float.pi * heightRatio
        
        if gestureRecognizer.state == .ended {
            LastRatio.width = widthRatio
            LastRatio.height = heightRatio
        }
    }
    
    internal func configurePanGestureRecognizer(_ panGestureRecognizer: inout UIPanGestureRecognizer) {
        LastRatio.reset()
        panGestureRecognizer.minimumNumberOfTouches = NumberOfTouches.min
        panGestureRecognizer.maximumNumberOfTouches = NumberOfTouches.max
    }
    
    private func truncateRatioConstraintsOverflow(_ heightRatio: inout Float) {
        heightRatio = min(heightRatio, RotateConstraint.maxAngle)
        heightRatio = max(heightRatio, RotateConstraint.minAngle)
    }
    
    fileprivate func hideRotationPrompt() {
        NotificationCenter.default.post(name: .hideRotationPrompt, object: FVMDamagedCarViewController.self)
    }
}
