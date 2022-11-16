//
//  ViewController.swift
//  TranslateScanner
//
//  Created by Erzen Talla  on 28.10.21.
//

import UIKit
import Vision
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    var recognizedStrings=""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imageView.image=nil
        recognizedStrings=""
        present(imagePicker, animated: true, completion: nil)
    }
    //hidden
    @IBAction func recogniseText(_ sender: Any) {
        guard let cgImage = imageView.image?.cgImage else { return }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        //        let request = VNRecognizeTextRequest(completion: recognizeTextHandler)
        let request = VNRecognizeTextRequest { request, error in
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else {
                        return
                    }
            self.recognizedStrings = observations.compactMap { observation in
                // Return the string of the top VNRecognizedText instance.
                return observation.topCandidates(1).first?.string
            }.joined(separator: ", ")
            
            // Process the recognized strings.
            DispatchQueue.main.async {
                print(self.recognizedStrings)
            }
        }
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
    }
    func recognise(){
        guard let cgImage = imageView.image?.cgImage else { return }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        //        let request = VNRecognizeTextRequest(completion: recognizeTextHandler)
        let request = VNRecognizeTextRequest { request, error in
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else {
                        return
                    }
            self.recognizedStrings = observations.compactMap { observation in
                // Return the string of the top VNRecognizedText instance.
                return observation.topCandidates(1).first?.string
            }.joined(separator: ", ")
            
            // Process the recognized strings.
            DispatchQueue.main.async {
                print(self.recognizedStrings)
            }
        }
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
        recognise()
    }
    
    @IBAction func sendData(_ sender: Any) {
        performSegue(withIdentifier: "segueSend", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination=segue.destination as? TranslateViewController
        //        destination?.textToTranslate=recognizedStrings
        destination?.textToTranslate="good"
    }
    
}

