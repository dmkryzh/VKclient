//
//  VKToolsVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 21.11.2021.
//

import Foundation
import UIKit
import SnapKit
import WeScan
import Photos

protocol VKToolsDelegate {
    func scanBttnPressed()
}

class VKToolsVC: UIViewController {
    
    let data = VKToolsModel()
    
    var presenter: VKToolsDelegate?
    
    let imageFromLib: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    /// -- NavBarButtons start--
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "folder.fill")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.tintColor = .black
        view.action = #selector(rightBttnHandler)
        view.target = self
        return view
    }()
    
    lazy var leftBarBtt: UIBarButtonItem = {
        let image = UIImage(systemName: "scanner.fill")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.tintColor = .black
        view.action = #selector(leftBarBttnHandler(_:))
        view.target = self
        return view
    }()
    /// -- NavBarButtons end--
    ///
    
    let imagePicker =  UIImagePickerController()
    
    func selectImageFromLibrary() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        imageFromLib.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.centerX.centerY.equalTo(safe)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.setRightBarButton(rightButton, animated: true)
        navigationItem.setLeftBarButton(leftBarBtt, animated: false)
        view.addSubview(imageFromLib)
        setupConstraints()
    }
    
    
    func saveToCameraRoll(image: UIImage, completion: @escaping (URL?) -> Void) {
        var placeHolder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            placeHolder = creationRequest.placeholderForCreatedAsset
        }, completionHandler: { success, error in
            guard success, let placeholder = placeHolder else {
                completion(nil)
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
            guard let asset = assets.firstObject else {
                completion(nil)
                return
            }
            asset.requestContentEditingInput(with: nil, completionHandler: { (editingInput, _) in
                completion(editingInput?.fullSizeImageURL)
            })
        })
    }
    
}

extension VKToolsVC: ImageScannerControllerDelegate {
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        
        saveToCameraRoll(image: results.originalScan.image) { link in
           
            guard let link = link else { return }
            
            print("URL: \(String(describing: link))")
           
            self.data.saveLink(link)
            self.data.loadLink()
        }
        navigationController?.dismiss(animated: true)

    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        navigationController?.dismiss(animated: true)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        
    }
}

//MARK: ACTIONS

extension VKToolsVC {
    @objc func leftBarBttnHandler(_ sender: Any) {
        presenter?.scanBttnPressed()
    }
    
    @objc func rightBttnHandler() {
        selectImageFromLibrary()
    }
}

extension VKToolsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageFromLib.image = selectedImage
    }
}

