//
//  ViewController.swift
//  MyHealth
//
//  Created by Sai Kiran Anumalla on 10/12/24.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {
    
    var nlpView = NLPDashboardView()
    
    override func loadView() {
        view = nlpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        nlpView.submitButton.addTarget(self, action: #selector(handleAnalyzeText), for: .touchUpInside)
    }
    
    @objc func handleAnalyzeText() {
        guard let text = nlpView.inputTextView.text, !text.isEmpty, text != "Enter text here..." else {
            nlpView.languageLabel.text = "Please enter valid text."
            return
        }
        
        // Perform NLP tasks
        let language = detectLanguage(for: text)
        let tokens = tokenizeText(for: text)
        let sentiment = analyzeSentiment(for: text)
        let entities = performNER(for: text)
        
        // Update labels
        nlpView.languageLabel.text = "Language: \(language)"
        nlpView.sentimentLabel.text = "Sentiment: \(sentiment)"
        nlpView.tokensLabel.text = "Tokens: \(tokens.joined(separator: ", "))"
        nlpView.entitiesLabel.text = """
        Entities:
        - People: \(entities["Person"]?.joined(separator: ", ") ?? "None")
        - Organizations: \(entities["Organization"]?.joined(separator: ", ") ?? "None")
        - Places: \(entities["Place"]?.joined(separator: ", ") ?? "None")
        """
    }
    
    // NLP Utility Methods
    func detectLanguage(for text: String) -> String {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else {
            return "Unknown"
        }
        return Locale.current.localizedString(forLanguageCode: languageCode) ?? "Unknown"
    }
    
    func tokenizeText(for text: String) -> [String] {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        return tokenizer.tokens(for: text.startIndex..<text.endIndex).map {
            String(text[$0])
        }
    }
    
    func analyzeSentiment(for text: String) -> String {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        guard let sentimentScore = sentiment?.rawValue else { return "Neutral" }
        
        if let score = Double(sentimentScore) {
            if score > 0 { return "Positive" }
            else if score < 0 { return "Negative" }
        }
        return "Neutral"
    }
    
    func performNER(for text: String) -> [String: [String]] {
        let tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = text
        
        var entities: [String: [String]] = ["Person": [], "Organization": [], "Place": []]
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: [.omitWhitespace, .omitPunctuation]) { tag, range in
            if let tag = tag {
                let entity = String(text[range])
                switch tag {
                case .personalName: entities["Person"]?.append(entity)
                case .organizationName: entities["Organization"]?.append(entity)
                case .placeName: entities["Place"]?.append(entity)
                default: break
                }
            }
            return true
        }
        return entities
    }
}



