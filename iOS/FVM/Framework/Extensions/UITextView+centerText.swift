//
//  UITextView+centerText.swift
//  FVM
//
//  Created by Smykala, Szymon on 03/05/2019.
//  Copyright © 2019 Czajka, Kamil. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func centerTextVertically() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
