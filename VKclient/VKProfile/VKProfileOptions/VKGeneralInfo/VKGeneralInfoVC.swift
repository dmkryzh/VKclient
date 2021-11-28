//
//  VKGeneralInfoVC.swift
//  VKclient
//
//  Created by Dmitrii KRY on 28.11.2021.
//


import Foundation
import UIKit
import SnapKit
import M13Checkbox

protocol VKGeneralInfoVCDelegate {
    func test()
}

final class VKGeneralInfoVC: UIViewController {
    
    var presenter: VKGeneralInfoVCDelegate?

    /// -- NavBarButtons start--
    lazy var rightButton: UIBarButtonItem = {
        let image = UIImage(systemName: "text.justify")
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return view
    }()
    
    let leftBarBtt: UILabel = {
        let view = UILabel()
        view.text = "default_user"
        return view
    }()
    /// -- NavBarButtons end--
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let deny: UIImageView = {
        let image = UIImage(systemName: "xmark")
        let view = UIImageView(image: image)
        return view
    }()
    
    let accept: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let view = UIImageView(image: image)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "General Info"
        return view
    }()
    
    let name: UILabel = {
        let view = UILabel()
        view.text = "Default User"
        return view
    }()
    
    let surname: UILabel = {
        let view = UILabel()
        view.text = "Surname"
        return view
    }()
    
    let maleBox: M13Checkbox = {
        let view = M13Checkbox()
        view.markType = .radio
        view.tintColor = .red
        return view
    }()
    
    let femaleBox: M13Checkbox = {
        let view = M13Checkbox()
        view.markType = .radio
        view.tintColor = .red
        return view
    }()
    
    let sex: UILabel = {
        let view = UILabel()
        view.text = "Sex"
        return view
    }()
    
    let male: UILabel = {
        let view = UILabel()
        view.text = "male"
        return view
    }()
    
    let female: UILabel = {
        let view = UILabel()
        view.text = "famale"
        return view
    }()

    
    let dob: UILabel = {
        let view = UILabel()
        view.text = "DOB"
        return view
    }()
    
    let city: UILabel = {
        let view = UILabel()
        view.text = "Native city"
        return view
    }()
    
    
    let nameField: UITextField = {
        let view = UITextField()
        view.placeholder = "name"
        return view
    }()
    
    let surnameField: UITextField = {
        let view = UITextField()
        view.placeholder = "surname"
        return view
    }()
    
    let dobField: UITextField = {
        let view = UITextField()
        view.placeholder = "01.01.2000"
        return view
    }()
    
    let cityField: UITextField = {
        let view = UITextField()
        view.placeholder = "Write the city"
        return view
    }()

    //MARK: - CONSTRAINTS
    
    lazy var setupConstraints = { [self] in
        
        let safe = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safe)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(safe)
        }
        
        deny.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(15)
            make.height.width.equalTo(30)
            make.leading.equalTo(containerView).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        accept.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(15)
            make.height.width.equalTo(30)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(containerView).offset(16)
        }
        
        nameField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(name.snp.bottom).offset(5)
            make.leading.trailing.equalTo(containerView).offset(16)
        }
        
        surname.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(16)
        }
        
        surnameField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(surname.snp.bottom).offset(5)
            make.leading.trailing.equalTo(containerView).offset(16)
        }
        
        sex.snp.makeConstraints { make in
            make.top.equalTo(surnameField.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(16)
        }
        
        maleBox.snp.makeConstraints { make in
            make.height.width.equalTo(15)
            make.top.equalTo(sex.snp.bottom).offset(5)
            make.leading.equalTo(containerView).offset(16)
        }
        
        male.snp.makeConstraints { make in
            make.leading.equalTo(maleBox.snp.trailing).offset(20)
            make.centerY.equalTo(maleBox)
        }
        
        femaleBox.snp.makeConstraints { make in
            make.height.width.equalTo(15)
            make.top.equalTo(maleBox.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }
        
        female.snp.makeConstraints { make in
            make.leading.equalTo(femaleBox.snp.trailing).offset(20)
            make.centerY.equalTo(femaleBox)
        }
        
        dob.snp.makeConstraints { make in
            make.top.equalTo(female.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }
        
        dobField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(dob.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).offset(16)
        }
        
        city.snp.makeConstraints { make in
            make.top.equalTo(dobField.snp.bottom).offset(15)
            make.leading.equalTo(containerView).offset(16)
        }
        
        cityField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(city.snp.bottom).offset(5)
            make.leading.trailing.equalTo(containerView).offset(16)
        }
    }
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// - NavBarButtons start --
        navigationItem.setRightBarButton(rightButton, animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(), animated: false)
        navigationItem.leftBarButtonItem?.customView = leftBarBtt
        /// - NavBarButtons end --
        view.addSubview(scrollView)
        scrollView.addSubviews(containerView, deny, titleLabel, accept, name, nameField, surname, surnameField, sex, maleBox, male, femaleBox, female, dob, dobField, city, cityField)
        setupConstraints()
    }
}
