//
//  ErrorViewAlertController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import UIKit

final class ErrorViewAlertController: UIAlertController {
    
    // MARK: - Initializers
    
    convenience init(message: String, tryAgainHandler: (() -> Void)?) {
        self.init(title: AppData.AlertError.title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: AppData.AlertError.cancel, style: .cancel)
        self.addAction(cancelAction)
        
        if let tryAgainHandler {
            let tryAgainAction = UIAlertAction(title: AppData.AlertError.repeat, style: .default) { _ in
                tryAgainHandler()
            }
            self.addAction(tryAgainAction)
        }
    }
}
