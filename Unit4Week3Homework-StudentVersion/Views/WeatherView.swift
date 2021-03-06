//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
  
    //Message Label
    lazy var messageLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "7 Day Forecast"
        return label
    }()
    
    //Collection View
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = UIColor(red: 206, green: 214, blue: 226, alpha: 0.50)
        //register collectionViewCell
        cv.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return cv
    }()
    
    
    //TextField
    lazy var textField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor.darkGray
        tField.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        tField.textAlignment = .center
        tField.tintColor = .white
        tField.attributedPlaceholder = NSAttributedString(string: "ZipCode",
                                                           attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        tField.textColor = .white
        tField.keyboardType = .numbersAndPunctuation
        tField.keyboardAppearance = .dark
        tField.borderStyle =  .roundedRect
        return tField
    }()
    
    
    //Zipcode Message Label
    lazy var zipcodeMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.backgroundColor = .clear
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.text = "Enter zipcode for your city's weather"
        return label
    }()


    //Initialization
    override init(frame: CGRect) {//overriding the parent class's functions
        super.init(frame: UIScreen.main.bounds)
        setUpGUI()
    }
    
    required init?(coder aDecoder: NSCoder) { //now the new initializer required for this uiView
        super.init(coder: aDecoder)
        //setUpGUI()
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        // To add round edges
        //textField.layer.cornerRadius = textField.bounds.width / 1.0
        //textField.layer.masksToBounds = true
        
    }
    
    private func setUpGUI() {
        backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects() {
        
        //ARRAY MUST BE ON ORDER!!
        let weatherViewObjects = [messageLabel, collectionView, textField, zipcodeMessageLabel] as [UIView]
        
        weatherViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //Weather Message Label
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            
            //Collection View
            collectionView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            
            //TextField
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            
            //Zipcode Message Label
            zipcodeMessageLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            zipcodeMessageLabel.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            zipcodeMessageLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
            
            ])
    }
}
