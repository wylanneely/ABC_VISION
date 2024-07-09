//
//  TextCaptureViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/3/24.
//

import UIKit
import AVFoundation
import Vision

class TextCaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var textRecognitionRequest: VNRecognizeTextRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the camera
        setupCamera()
        
        // Set up Vision text recognition request
        setupVision()
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
        /* starting capture session */
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    private func setupVision() {
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { [weak self] (request, error) in
            if let error = error {
                print("Error recognizing text: \(error.localizedDescription)")
                return
            }
            self?.processTextRecognitionResults(request.results)
        })
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        var requestOptions: [VNImageOption : Any] = [:]
        
        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics: cameraIntrinsicData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: requestOptions)
        
        do {
            try imageRequestHandler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    private func processTextRecognitionResults(_ results: [Any]?) {
        guard let results = results as? [VNRecognizedTextObservation] else { return }
        
//        var recognizedText = ""
//        for observation in results {
//            guard let topCandidate = observation.topCandidates(1).first else { continue }
//            recognizedText += topCandidate.string + "\n"
//        }
//        DispatchQueue.main.async { [weak self] in
//            self?.updateRecognizedText(recognizedText)
//        }
        DispatchQueue.main.async { [weak self] in
                   // Remove previous text boxes
                   self?.textBoxes.forEach { $0.removeFromSuperlayer() }
                   self?.textBoxes.removeAll()
                   
                   // Process recognized text and draw bounding boxes
                   for observation in results {
                       guard let topCandidate = observation.topCandidates(1).first else { continue }
                       print(topCandidate.string)
                       
                       // Create a box for the text
                       let box = self?.createBox(for: observation)
                       self?.view.layer.addSublayer(box!)
                       self?.textBoxes.append(box!)
                   }
               }
        
    }
    
    //MARK: - Visual Boxes
    var textBoxes: [CAShapeLayer] = []
    
    private func createBox(for observation: VNRecognizedTextObservation) -> CAShapeLayer {
            let box = CAShapeLayer()
            box.strokeColor = UIColor.red.cgColor
            box.lineWidth = 2
            box.fillColor = UIColor.clear.cgColor
            
            let boundingBox = observation.boundingBox
            let size = CGSize(width: boundingBox.width * view.bounds.width, height: boundingBox.height * view.bounds.height)
            let origin = CGPoint(x: boundingBox.minX * view.bounds.width, y: (1 - boundingBox.minY) * view.bounds.height - size.height)
            
            let path = UIBezierPath(rect: CGRect(origin: origin, size: size))
            box.path = path.cgPath
            
            return box
        }
    
    private func updateRecognizedText(_ text: String) {
        print(text)
        // Update your UI here with the recognized text
    }
}
