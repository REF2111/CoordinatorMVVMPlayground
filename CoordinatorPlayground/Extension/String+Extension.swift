//
//  String+Extension.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 12.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

extension String {
    
    func isValidUsername() -> Bool {
        count >= 3
    }
    
    func isValidPassword() -> Bool {
        count >= 3
    }
}
