//
//  TextCaptureViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/3/24.
//

import UIKit
import AVFoundation
import Vision

class TextCaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    
    var testWords: [Word]? {
      return GameController.shared.getWords(forPlayer: currentPlayer?.nickname ?? "", inStack: testWordCategory ?? "")
    }
    
    var testWordCategory: String? 
    var currentPlayer: Player?
    
    var selectedWordToLearn: String?
    
    //MARK: - CollectionView
    
    @IBOutlet weak var wordHintCollectionView: UICollectionView!
    @IBOutlet weak var openCloseButton: UIButton!
    @IBOutlet weak var wordAssistLabel: UILabel!
    
    var isTableViewOpen: Bool = false
    
    func setUpCollectionView() {
        addBottomBorderLine()
        
        wordHintCollectionView.dataSource = self
        wordHintCollectionView.delegate = self
        wordHintCollectionView.allowsSelection = true
        
        let nib = UINib(nibName: "ARWordHintCell", bundle: nil)
        self.wordHintCollectionView.register(nib, forCellWithReuseIdentifier: "ARWordHintCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let testWords = testWords {
            return testWords.count
        } else {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wordHintCollectionView.dequeueReusableCell(withReuseIdentifier: "ARWordHintCell", for: indexPath) as? ARWordHintCell else {
            return UICollectionViewCell()
        }
        if let testWords = testWords {
            let word = testWords[indexPath.row]
          //  cell.WordHintLabelDelegate = self
            cell.setUIStates(word: word)
            return cell
        }
        
        return cell
    }
   
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let testWords = testWords else { return }
        
        let selectedWord = testWords[indexPath.row]
        MusicPlayerManager.shared.playSoundFileNamed(name: selectedWord.name)
        setWordAssistLabel(word: selectedWord.name,isComplete: selectedWord.isComplete)
        self.selectedWordToLearn = selectedWord.name
        gradientProgressBar.resetProgress()
        resetCorrectlyObservedWords()
        openCloseWordHintTableView(self)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isIPhone = UIDevice.current.userInterfaceIdiom == .phone
        
        if isIPhone {
            let width = (collectionView.frame.width - 40)
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        } else {
            let width = (collectionView.frame.width) / 2.6
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
      }
    
    func setUpControlFlowLayout(){
        if let layout = wordHintCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               let snappingLayout = CenterSnappingFlowLayout()
               snappingLayout.scrollDirection = .horizontal // Ensure horizontal scrolling
               snappingLayout.itemSize = layout.itemSize
               snappingLayout.minimumLineSpacing = layout.minimumLineSpacing
            wordHintCollectionView.collectionViewLayout = snappingLayout
           }
           
        wordHintCollectionView.decelerationRate = .fast // Ensures snapping feels natural
       }
    
    private func addBottomBorderLine() {
            let borderThickness: CGFloat = 1.0
            let border = CALayer()
            border.backgroundColor = UIColor.abcGreen.cgColor // Set the border color
            border.frame = CGRect(x: 0,
                                  y: wordHintCollectionView.frame.height - borderThickness,
                                  width: wordHintCollectionView.frame.width,
                                  height: borderThickness)
            wordHintCollectionView.layer.addSublayer(border)
        }
   
    //MARK: Word Assist
    
    func setWordAssistLabel(word: String, isComplete: Bool){
        wordAssistLabel.text = word
        if isComplete {
            wordAssistLabel.textColor = UIColor.abcGreen
        } else {
            wordAssistLabel.textColor = UIColor.abcRed
        }
    }
    
    
    @IBOutlet weak var wordHintTableViewTopConstraint: NSLayoutConstraint!
    
    
    @IBAction func openCloseWordHintTableView(_ sender: Any) {

        let tableViewHeight = wordHintCollectionView.frame.height
        let newTableViewYPosition: CGFloat = isTableViewOpen ? -tableViewHeight : 0

        wordHintTableViewTopConstraint.constant = isTableViewOpen ? -tableViewHeight : 0

        UIView.animate(withDuration: 0.4, animations: {
            self.wordHintCollectionView.transform = CGAffineTransform(translationX: 0, y: newTableViewYPosition)
            self.view.layoutIfNeeded()
        }) { _ in
            self.isTableViewOpen.toggle()
            let buttonImage = self.isTableViewOpen ? UIImage(named: "CloseWordsButton") : UIImage(named: "OpenWordsButton")
            self.openCloseButton.setImage(buttonImage, for: .normal)
        }
    }
//        
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
    //MARK: ProgressBar
    
    private let gradientProgressBar = GradientProgressBar()
    
    func setUpProgressBar(){
        // Configure progress bar
        gradientProgressBar.colors = [.blue, .purple, .green]
        gradientProgressBar.resetProgress() // Start at 0
                
                // Add to view
        gradientProgressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientProgressBar)
                
                // Add constraints
        NSLayoutConstraint.activate([
            gradientProgressBar.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 20),
            gradientProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gradientProgressBar.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            gradientProgressBar.heightAnchor.constraint(equalToConstant: 20) // Set height
        ])
    }
    
    //To help with the loading of the view, 3 times to fill it up for now. Edit the progress animation in the gradient class
    //make sure to reset when new word is selected
    private var correctlyObserveredWords: Int = 0 {
        didSet {
            gradientProgressBar.addToProgress(timesCorrect: correctlyObserveredWords)
        }
    }
    
    private func resetCorrectlyObservedWords(){
        correctlyObserveredWords = 0
    }
    
    func addToCorrectWordCount(){
        switch correctlyObserveredWords {
        case 0: correctlyObserveredWords = 1
        case 1: correctlyObserveredWords = 2
        case 2: correctlyObserveredWords = 3
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(
                    withIdentifier: "toWordProcessedVC",
                    sender: self
                )
            }
        default:
            return
        }
    }
    
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
        //testing
         //   setUpWord()
        // Set up the camera
            setupCamera()
        // Set up Vision text recognition request
            setupVision()
        // Add tap gesture recognizer
            addGesture()
            setUpCollectionView()
            setUpControlFlowLayout()
        //bringtableview to front
            setUpProgressBar()
            bringSubviewsToFront()
        }
    
    func bringSubviewsToFront(){
        view.bringSubviewToFront(wordAssistLabel)
        view.bringSubviewToFront(magnifyingGlassImageView)
        view.bringSubviewToFront(wordHintCollectionView)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(openCloseButton)
        view.bringSubviewToFront(gradientProgressBar)

    }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            isPaused = true
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            isPaused = true
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            resetWordLearningProcess()
            isPaused = false
        }
    
    func resetWordLearningProcess(){
        //reset setatu bar and learning word
        wordAssistLabel.text = nil
        selectedWordToLearn = nil
        gradientProgressBar.resetProgress()
        resetCorrectlyObservedWords()
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
    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            view.bringSubviewToFront(magnifyingGlassImageView)
            magnifyingGlassImageView.isHidden = false
            openCloseWordHintTableView(self)
        }
    
        override var prefersStatusBarHidden: Bool {
            return true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .allButUpsideDown
        }
    
        // Enable the commented-out updateVideoRotationAngle method
        private func updateVideoRotationAngle() {
            guard let connection = videoPreviewLayer.connection else {
                return
            }
            switch UIDevice.current.orientation {
            case .portrait:
                connection.videoOrientation = .portrait
            case .landscapeRight:
                connection.videoOrientation = .landscapeLeft
            case .landscapeLeft:
                connection.videoOrientation = .landscapeRight
            case .portraitUpsideDown:
                connection.videoOrientation = .portraitUpsideDown
            default:
                connection.videoOrientation = .portrait
            }
        }
    
    //MARK: - Tap Gestures
    
    private func addGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(_:))
        )
        tapGestureRecognizer.delegate = self // Set the delegate
        tapGestureRecognizer.cancelsTouchesInView = false

        view.addGestureRecognizer(tapGestureRecognizer)
    }

    // Allow the gesture recognizer to work simultaneously with other gestures (like the table view selection)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
    
    //MARK: 1 - Text Rendering
    
    private var recognizedTexts: [String] = []
//3
    private func processTextRecognitionResults(_ results: [Any]?) {
        guard let results = results as? [VNRecognizedTextObservation] else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.textBoxes.forEach { $0.removeFromSuperlayer() }
            self?.textBoxes.removeAll()
            self?.recognizedTexts.removeAll()

            var closestObservation: VNRecognizedTextObservation?
            var minDistance: CGFloat = CGFloat.greatestFiniteMagnitude
            let centerPoint = CGPoint(x: self?.view.bounds.midX ?? 0, y: self?.view.bounds.midY ?? 0)

            for observation in results {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                let filteredString = topCandidate.string.filter { $0.isASCII && $0.isLetter || $0.isWhitespace }

                if !filteredString.isEmpty {
                    print(filteredString)

                    // Calculate the bounding box center
                    let boundingBox = observation.boundingBox
                    let boxCenter = CGPoint(x: boundingBox.midX * (self?.view.bounds.width ?? 1),
                                            y: (1 - boundingBox.midY) * (self?.view.bounds.height ?? 1))

                    // Calculate the distance from the center of the view
                    let distance = hypot(centerPoint.x - boxCenter.x, centerPoint.y - boxCenter.y)

                    // Find the observation closest to the center of the view
                    if distance < minDistance {
                        minDistance = distance
                        closestObservation = observation
                    }
                }
            }

            if let closestObservation = closestObservation, let topCandidate = closestObservation.topCandidates(1).first {
                let filteredString = topCandidate.string.filter { $0.isASCII && $0.isLetter || $0.isWhitespace }
                if !filteredString.isEmpty {
                    let box = self?.createBox(for: closestObservation)
                    self?.view.layer.addSublayer(box!)
                    self?.textBoxes.append(box!)
                    self?.recognizedTexts.append(filteredString)
                }
            }
        }
    }
    
    //MARK: 0 - Vision
    //0
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }

        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))

        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
        
        // Update the video preview layer orientation based on device orientation
        updateVideoRotationAngle()
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    //1
    private func setupVision() {
        textRecognitionRequest = VNRecognizeTextRequest { [weak self] (request, error) in
            if let error = error {
                print("Error recognizing text: \(error.localizedDescription)")
                return
            }
            self?.processTextRecognitionResults(request.results)
        }
        
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
        textRecognitionRequest.recognitionLanguages = ["en-US"] // Set to recognize only English text
    }

    //2
    
    var lastProcessedTime: TimeInterval = 0
    let frameProcessingInterval: TimeInterval = 0.4// 0.1 = every 200 ms
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        // Get current time
        let currentTime = CACurrentMediaTime()
        
        // Only process frames every 'frameProcessingInterval' seconds
        if currentTime - lastProcessedTime < frameProcessingInterval {
            return
        }
        // Update the last processed time
        lastProcessedTime = currentTime
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        var requestOptions: [VNImageOption: Any] = [:]
        if let cameraIntrinsicData = CMGetAttachment(
            sampleBuffer,
            key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix,
            attachmentModeOut: nil
        ) {
            requestOptions = [.cameraIntrinsics: cameraIntrinsicData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: requestOptions)
        
        do {
            try imageRequestHandler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }

    //MARK: - Images
    
    @IBOutlet weak var magnifyingGlassImageView: UIImageView!
    
    
    //MARK: PRogress Bar
    
    var greenBoxTimer: Timer?
    let detectionDuration: TimeInterval = 0.6
    var progressBar: UIProgressView!
    
    //MARK: 2 - Visual Boxes
    
    let CheckerController = WordCheckController()
    var textBoxes: [CAShapeLayer] = []
    var writtenText = ""

    private func createBox(for observation: VNRecognizedTextObservation) -> CAShapeLayer {
           
           let writtenText = observation.topCandidates(1).first?.string
           let box = CAShapeLayer()
           box.lineWidth = 2.5
           box.fillColor = UIColor.clear.cgColor
        if let wordToLearn = selectedWordToLearn {
            //change in future stable releases
            if writtenText?.lowercased() == wordToLearn.lowercased() {
                addToCorrectWordCount()
                box.strokeColor = UIColor.abcGreen.cgColor
            } else {
                box.strokeColor = UIColor.abcRed.cgColor
            }
            
        } else if CheckerController.checkWordisCorrect(writtenText) {
               box.strokeColor = UIColor.abcGreen.cgColor
             //  startGreenBoxTimer() // Start the timer when the correct word is detected
           } else {
               box.strokeColor = UIColor.abcRed.cgColor
              // MusicPlayerManager.shared.playSoundFileNamed(name: "IncorrectSound")
             //  resetGreenBoxTimer() // Reset the timer if it's not correct
           }
           
           let boundingBox = observation.boundingBox
           let boxWidth = (boundingBox.width + 0.05) * view.bounds.width
           let boxHeight = (boundingBox.height + 0.01) * view.bounds.height
           
           let size = CGSize(width: boxWidth, height: boxHeight)
           let origin = CGPoint(
               x: boundingBox.minX * view.bounds.width,
               y: (1 - boundingBox.minY) * view.bounds.height - size.height
           )
           
           let path = UIBezierPath(
               roundedRect: CGRect(origin: origin, size: size),
               cornerRadius: 15
           )
           box.path = path.cgPath
           return box
       }
       
    //This will be implemented in future for
//       // Timer Logic for Green Box Detection
//       func startGreenBoxTimer() {
//           resetGreenBoxTimer() // Ensure the timer is reset before starting a new one
//           greenBoxTimer = Timer.scheduledTimer(withTimeInterval: detectionDuration, repeats: false) { [weak self] _ in
//               self?.triggerSegueForCorrectWord()
//           }
//       }
//       
//       func resetGreenBoxTimer() {
//           greenBoxTimer?.invalidate()
//           greenBoxTimer = nil
//       }
//       
//       // This method will be called when the green box is detected for 1.4 seconds
//       func triggerSegueForCorrectWord() {
//           if let currentText = recognizedTexts.first, CheckerController.checkWordisCorrect(currentText) {
//               self.performSegue(withIdentifier: "toWordProcessedVC", sender: self)
//           }
//       }
    
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
            MusicPlayerManager.shared.playSoundWithWavFile(name: "IncorrectSound")
           let feedback = UINotificationFeedbackGenerator()
            feedback.notificationOccurred(.error)
        }
    }
        
    //MARK: Navigation
    //to home
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    
    func transitionToHome() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeViewController.currentPlayer = currentPlayer
            window.rootViewController = homeViewController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }
    
    
    //To word unlock
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        wordHintCollectionView.reloadData()
        wordAssistLabel.textColor = UIColor.abcGreen
        if segue.identifier == "toWordProcessedVC",
           let destinationVC = segue.destination as? ARSceneViewController {
               unlockWrittenWord(written: writtenText)
            MusicPlayerManager.shared.playSoundFileNamed(name: "GoodJob")
            
            //did this because when a user selects that word to learn then freestyle is off and they want to see the word they selected.
            if let wordToLearn = selectedWordToLearn {
                destinationVC.writtenWord = wordToLearn
            } else {
                destinationVC.writtenWord = writtenText
            }
        }
    }
    
    func unlockWrittenWord(written: String) {
        if (testWords != nil) {
            for word in testWords! {
                let name = word.name
                if written.lowercased() == name.lowercased() {
                    
                    word.unlockComplete()
                    GameController.shared.markWordComplete(forPlayer: currentPlayer?.nickname ?? "", inStack: testWordCategory ?? "" , wordName: word.name)
                }
            }
        }
    }
    
    //MARK: Rewards
    

        
}
