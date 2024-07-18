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

    //MARK: AVCapture Video Sessions
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var textRecognitionRequest: VNRecognizeTextRequest!
    var isPaused = false {
        didSet {
            self.pauseResumeVideoCapture()
        }
    }
    
    func pauseResumeVideoCapture(){
        
        DispatchQueue.global(qos: .background).async {
            if self.isPaused {
                self.captureSession.stopRunning()
            } else {
                self.captureSession.startRunning()
            }
        }
    }
    
    //MARK: - App LyfeCycle
    
        override func viewDidLoad() {
            super.viewDidLoad()
        
        // Set up the camera
            setupCamera()
        
        // Set up Vision text recognition request
            setupVision()
            
            // Add tap gesture recognizer
            addGesture()
        }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            // Pause video rendering
            isPaused = true
            // Add your code to stop or pause the video rendering
        }
        
        override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isPaused = true
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Resume video rendering
            isPaused = false
            // Add your code to resume the video rendering
        }
    
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            videoPreviewLayer.frame = view.bounds
        }
    
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            coordinator.animate(alongsideTransition: { _ in
                self.updateVideoRotationAngle()
            })
        }

    private func updateVideoRotationAngle() {
          guard let connection = videoPreviewLayer.connection else { return }
          switch UIDevice.current.orientation {
          case .portrait:
              connection.videoRotationAngle = 90
          case .landscapeRight:
              connection.videoRotationAngle = 180
          case .landscapeLeft:
              connection.videoRotationAngle = 0
          case .portraitUpsideDown:
              connection.videoRotationAngle = 270
          default:
              connection.videoRotationAngle = 90
          }
          videoPreviewLayer.frame = view.bounds
      }
    
    //MARK: - Tap Gestures
    
    private func addGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(_: )
            )
        )
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        for (index,box) in textBoxes.enumerated() {
            if box.path!.contains(location) {
                let recognizedText = recognizedTexts[index]
                processTappedText(recognizedText)
                break
            }
        }
    }
    
    private func processTappedText(_ text: String) {
        print("Tapped text: \(text)")
        // Perform the desired action with the tapped text
        self.updateRecognizedText(text)
    }
    
    //MARK: - Text Rendering
    
    private var recognizedTexts: [String] = []

    private func processTextRecognitionResults(_ results: [Any]?) {
        guard let results = results as? [VNRecognizedTextObservation] else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.textBoxes.forEach {
                $0.removeFromSuperlayer()
            }
            self?.textBoxes.removeAll()
            self?.recognizedTexts.removeAll()
            
            for observation in results {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                print(topCandidate.string)
                
                let box = self?.createBox(for: observation)
                self?.view.layer.addSublayer(box!)
                self?.textBoxes.append(box!)
                self?.recognizedTexts.append(topCandidate.string)
            }
        }
    }
    
    
    //MARK: - Vision
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)}
        catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self,
            queue: DispatchQueue(label: "videoQueue")
        )
        
        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(
            session: captureSession
        )
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(
            videoPreviewLayer
        )
        /* starting capture session */
        DispatchQueue.global(
            qos: .background
        ).async {
            self.captureSession.startRunning()
        }
    }
    
    private func setupVision() {
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: {
            [weak self] (
                request,
                error
            ) in
            if let error = error {
                print(
                    "Error recognizing text: \(error.localizedDescription)"
                )
                return
            }
            self?.processTextRecognitionResults(
                request.results
            )
        })
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    }
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(
            sampleBuffer
        ) else {
            return
        }
        
        var requestOptions: [VNImageOption : Any] = [:]
        
        if let cameraIntrinsicData = CMGetAttachment(
            sampleBuffer,
            key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix,
            attachmentModeOut: nil
        ) {
            requestOptions = [.cameraIntrinsics: cameraIntrinsicData]
        }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                        orientation: .right,
                                                        options: requestOptions)
        
        do {
            try imageRequestHandler.perform(
                [textRecognitionRequest]
            )
        } catch {
            print(
                error
            )
        }
    }
    
    //MARK: - Visual Boxes
    
    let CheckerController = WordCheckController()
    var textBoxes: [CAShapeLayer] = []
    

    
    
    private func createBox(
        for observation: VNRecognizedTextObservation
    ) -> CAShapeLayer {
        
        let writtenText = observation.topCandidates(1).first?.string
        let box = CAShapeLayer()
        box.lineWidth = 2.5
        box.fillColor = UIColor.clear.cgColor
        if CheckerController.checkWordisCorrect(writtenText) {
            box.strokeColor = UIColor.abcGreen.cgColor
        } else {
            box.strokeColor = UIColor.abcRed.cgColor
        }
   
        let boundingBox = observation.boundingBox
        let boxWidth = (boundingBox.width + 0.05) * view.bounds.width
        let boxHeight = (boundingBox.height + 0.01) * view.bounds.height
        
        let size = CGSize(
            width: boxWidth ,
            height: boxHeight
        )
        let origin = CGPoint(
            x: boundingBox.minX * view.bounds.width,
            y: (
                1 - boundingBox.minY
            ) * view.bounds.height - size.height
        )
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                origin: origin,
                size: size
            ),cornerRadius: 15
        )
            box.path = path.cgPath
            
            return box
        }
    
    private func updateRecognizedText(
        _ text: String
    ) {
        print(
            text
        )
        self.writtenText = text
        if CheckerController.checkWordisCorrect(text) {
            self.performSegue(
                withIdentifier: "toWordProcessedVC",
                sender: self
            )
        } else {
           let feedback = UINotificationFeedbackGenerator()
            feedback.notificationOccurred(.error)
        }
        self.performSegue(
            withIdentifier: "toWordProcessedVC",
            sender: self
        )
    }
    
    var writtenText = ""
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if segue.identifier == "toWordProcessedVC",
           let destinationVC = segue.destination as? ARSceneViewController {
               destinationVC.writtenWord = writtenText
         }
    }
    
        
}
