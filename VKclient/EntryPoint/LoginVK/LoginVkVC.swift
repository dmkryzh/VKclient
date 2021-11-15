//
//  LoginVkVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 16.10.2021.
//

import Foundation
import SnapKit
import UIKit
import WebKit

class LoginVkVC: UIViewController {

    var delegate: LoginVkPresenterProtocol?
    
    let webView = WKWebView()
    
    let webUrl = URLRequest(url: URL(string: "https://oauth.vk.com/authorize?client_id=7975663&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=notify,friends,photos,audio,video,status,wall,groups,email&response_type=token")!)

    
    lazy var setupConstraints = { [self] in
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        logOut()
        webView.load(webUrl)
        webView.navigationDelegate = self
        view.addSubview(webView)
        setupConstraints()
    }
    
    func logOut() {
        
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("vk.com") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: { print("Deleted: " + record.displayName);
                    })
                }
            }
        }
    }
    
}

extension LoginVkVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            print("redirected URL: \(url)")
            delegate?.loggedIn(url) { urlString in
                let parsedToken = urlString.fetchToken
                return parsedToken
            }
        }
    }
    
}

