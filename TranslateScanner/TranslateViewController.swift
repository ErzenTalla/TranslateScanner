//
//  TranslateViewController.swift
//  TranslateScanner
//
//  Created by Erzen Talla  on 30.10.21.
//

import UIKit
import MLKit
import Foundation
class TranslateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var textToTranslate=""
    var sourceLanguage=""
    var translatedLanguage=""
    //    var text2="Good Morning"
    let data=["English","German", "French", "Bulgarian", "Arabic"]
    @IBOutlet weak var baseLanguagePickerView: UIPickerView!
    @IBOutlet weak var translatedLanguagePickerView: UIPickerView!
    
    @IBOutlet weak var baseTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        baseLanguagePickerView.delegate=self
        baseLanguagePickerView.dataSource=self
        translatedLanguagePickerView.delegate=self
        translatedLanguagePickerView.dataSource=self
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print(textToTranslate)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == baseLanguagePickerView {
            print("base")
            print(data[row])
            sourceLanguage=getLanguage(language: data[row])
        }
        else {
            print("translated")
            print(data[row])
            translatedLanguage=getLanguage(language: data[row])
        }
        
        
    }
    //get two characters of picken language
    func getLanguage(language: String) -> String {
        let l=language.lowercased().prefix(2)
        return String(l)
    }
    //TranslateText
    @IBAction func translateText(_ sender: Any) {
        //        let b=TranslateLanguage(rawValue: "en")
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .french)
        //        print(options.targetLanguage.rawValue)
        let englishGermanTranslator = Translator.translator(options: options)
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
            
        )
        //       let localModels = ModelManager.modelManager().downloadedTranslateModels
        //        let frenchModel = TranslateRemoteModel.translateRemoteModel(language: .bengali)
        //        let xls=ModelManager.modelManager().isModelDownloaded(frenchModel)
        //        print(xls)
        
        englishGermanTranslator.downloadModelIfNeeded(with: conditions) { error in
            print("12")
            guard error == nil else { return }
            
            // Model downloaded successfully. Okay to start translating.
            //            self.translatetext()
            englishGermanTranslator.translate(self.textToTranslate) { translatedText, error in
                guard error == nil, let translatedText = translatedText else { return }
                print(translatedText)
                // Translation succeeded.
            }
        }
        
        
    }
    func translatetext(){
        //        englishGermanTranslator.translate(text2) { translatedText, error in
        //                  guard error == nil, let translatedText = translatedText else { return }
        //                    print(translatedText)
        //                  // Translation succeeded.
        //              }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

