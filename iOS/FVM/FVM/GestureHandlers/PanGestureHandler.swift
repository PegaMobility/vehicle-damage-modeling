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
    static let min: Int = 1
    static let max: Int = 2
}

fileprivate struct RotateConstraint {
    static let maxHeightRatioXDown: Float = -0.15
    static let maxHeightRatioXUp: Float = 0.45
}

fileprivate struct LastRatio {
    static var width: Float = 1.1
    static var height: Float = 0.0
}

extension FVMCarModelViewController {
    @objc
    internal func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
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
        panGestureRecognizer.minimumNumberOfTouches = NumberOfTouches.min
        panGestureRecognizer.maximumNumberOfTouches = NumberOfTouches.max
    }
    
    private func truncateRatioConstraintsOverflow(_ heightRatio: inout Float) {
        heightRatio = heightRatio >= RotateConstraint.maxHeightRatioXUp ? RotateConstraint.maxHeightRatioXUp : heightRatio
        heightRatio = heightRatio <= RotateConstraint.maxHeightRatioXDown ? RotateConstraint.maxHeightRatioXDown : heightRatio
    }
}
