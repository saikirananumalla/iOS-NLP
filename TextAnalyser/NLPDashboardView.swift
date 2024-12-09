//
//  NLPDashboardView.swift
//  TextInsights
//
//  Created by Sai Kiran Anumalla on 10/12/24.
//

import UIKit

class NLPDashboardView: UIView {
    
    var inputTextView: UITextView!
    var submitButton: UIButton!
    var languageLabel: UILabel!
    var sentimentLabel: UILabel!
    var tokensLabel: UILabel!
    var entitiesLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupView()
    }
    
    func setupView() {
        inputTextView = setInputTextView()
        submitButton = setButton("Analyze Text")
        languageLabel = setLabel("Language: Unknown")
        sentimentLabel = setLabel("Sentiment: Neutral")
        tokensLabel = setLabel("Tokens: None")
        entitiesLabel = setLabel("Entities: None")
        
        self.addSubview(inputTextView)
        self.addSubview(submitButton)
        self.addSubview(languageLabel)
        self.addSubview(sentimentLabel)
        self.addSubview(tokensLabel)
        self.addSubview(entitiesLabel)
        setupConstraints()
    }
    
    func setInputTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Enter text here..."
        textView.textColor = UIColor.lightGray
        return textView
    }
    
    func setButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }
    
    func setLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0 // Allow multiline text
        return label
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            inputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            inputTextView.heightAnchor.constraint(equalToConstant: 100),
            
            submitButton.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            languageLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            sentimentLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
            sentimentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sentimentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            tokensLabel.topAnchor.constraint(equalTo: sentimentLabel.bottomAnchor, constant: 20),
            tokensLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tokensLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            entitiesLabel.topAnchor.constraint(equalTo: tokensLabel.bottomAnchor, constant: 20),
            entitiesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            entitiesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
