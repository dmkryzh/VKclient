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

protocol LoginVkDelegate {
    func loggedIn(_ link: String, _ completion: ((String) -> String)?)
    var linkForWebView: URL? { get set }
}

class LoginVkVC: UIViewController {

    var delegate: LoginVkDelegate?
    
    let webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        return view
    }()
    
    lazy var linkForWebView: URLRequest? = {
        guard let link = delegate?.linkForWebView else { return nil}
        let request = URLRequest(url: link)
        return request
    }()
    
    lazy var setupConstraints = { [self] in
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
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
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        logOut()
        guard let link = linkForWebView else { return }
        webView.load(link)
        webView.navigationDelegate = self
        view.addSubview(webView)
        setupConstraints()
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

