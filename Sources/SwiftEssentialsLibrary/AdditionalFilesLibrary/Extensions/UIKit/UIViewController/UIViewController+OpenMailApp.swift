//
//  UIViewController+OpenMailApp.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import UIKit
import MessageUI

extension UIViewController {
    
    func sendEmailTo(recipientEmail: String, subject: String, body: String, mailComposeDelegate: MFMailComposeViewControllerDelegate) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = mailComposeDelegate
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            present(mail, animated: true)
        
        // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        }
        
        return defaultUrl
    }
    
}
