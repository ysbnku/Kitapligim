//
//  QRScannerViewController.swift
//  QRScanner
//
//  Created by 周斌 on 2018/11/29.
//
import UIKit
import Foundation
import AVFoundation
public protocol QRScannerDelegate:class {
    func qrScannerDidFail(scanner:QRScannerViewController, error:QRScannerError)
    func qrScannerDidSuccess(scanner:QRScannerViewController, result:String)
}

open class QRScannerViewController: UIViewController {
    
    public weak var delegate: QRScannerDelegate?
    public let squareView = QRScannerSquareView()
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    let cameraPreview: UIView = UIView()
    let maskLayer = CAShapeLayer()
    let torchItem = UIButton()
    let metaDataQueue = DispatchQueue(label: "metaDataQueue",qos: .userInteractive)
    let videoQueue = DispatchQueue(label: "videoQueue",qos: .background)
    lazy var resourcesBundle:Bundle? = {
        if let path = Bundle.main.path(forResource: "QRScanner", ofType: "framework", inDirectory: "Frameworks"),
           let framework = Bundle(path: path),
           let bundlePath = framework.path(forResource: "QRScanner", ofType: "bundle"),
           let bundle = Bundle(path: bundlePath){
            return bundle
        }
        return nil
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
        checkPermissions()
        setUpLayout()
        setUpLayers()
    }
    
    @objc public func openAlbum(){
        QRScannerPermissions.authorizePhotoWith { [weak self] in
            if $0{
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                picker.delegate = self
                self?.present(picker, animated: true, completion: nil)
            }else{
                self?.delegate?.qrScannerDidFail(scanner: self!, error: QRScannerError.photoPermissionDenied)
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        squareView.startAnimation()
    }
    
    func checkPermissions(){
        QRScannerPermissions.authorizeCameraWith {[weak self] in
            if $0{
                self?.captureSession?.startRunning()
            }else{
                self?.delegate?.qrScannerDidFail(scanner: self!, error: QRScannerError.photoPermissionDenied)
            }
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = cameraPreview.bounds
        maskLayer.frame = view.bounds
        let path = UIBezierPath(rect: view.bounds)
        path.append(UIBezierPath(rect: squareView.frame))
        maskLayer.path = path.cgPath
    }
    
    func setUpLayout(){
        view.backgroundColor = UIColor.black
        view.addSubview(cameraPreview)
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        cameraPreview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cameraPreview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cameraPreview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let length = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 100
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.widthAnchor.constraint(equalToConstant: length).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: length).isActive = true
        squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(torchItem)
        torchItem.setImage(UIImage(named: "Torch-off", in: resourcesBundle, compatibleWith: nil), for: UIControl.State.normal)
        torchItem.setImage(UIImage(named: "Torch-on", in: resourcesBundle, compatibleWith: nil), for: UIControl.State.selected)
        torchItem.addTarget(self, action: #selector(toggleTorch), for: UIControl.Event.touchUpInside)
        torchItem.isHidden = true
        torchItem.translatesAutoresizingMaskIntoConstraints = false
        torchItem.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 30).isActive = true
        torchItem.heightAnchor.constraint(equalToConstant: 30).isActive = true
        torchItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        torchItem.centerXAnchor.constraint(equalTo: squareView.centerXAnchor).isActive = true
        
    }
    
    @objc func toggleTorch(bt:UIButton){
        bt.isSelected = !bt.isSelected
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)else{return}
        try? device.lockForConfiguration()
        device.torchMode = bt.isSelected ? .on : .off
        device.unlockForConfiguration()
    }
    
    func setUpLayers(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        let viewLayer = cameraPreview.layer
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        viewLayer.addSublayer(previewLayer!)
        maskLayer.fillColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        view.layer.insertSublayer(maskLayer, above: previewLayer)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func playAlertSound(){
        guard let soundPath = resourcesBundle?.path(forResource: "noticeMusic.caf", ofType: nil)  else { return }
        guard let soundUrl = NSURL(string: soundPath) else { return }
        
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    func drawRect(resultObj:AVMetadataMachineReadableCodeObject){
        #if !targetEnvironment(simulator)
        let path = UIBezierPath()
        
        for point in resultObj.corners{
            let index = resultObj.corners.firstIndex(of: point) ?? 0
            if index == 0 {
                path.move(to: point)
            }else if index == resultObj.corners.count - 1,let first = resultObj.corners.first{
                path.addLine(to: point)
                path.move(to: point)
                path.addLine(to: first)
                path.close()
            }else{
                path.addLine(to: point)
                path.move(to: point)
            }
            
        }
        
        for ly in self.maskLayer.sublayers ?? []{
            ly.removeFromSuperlayer()
        }
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = 3
        layer.strokeColor = UIColor.green.cgColor
        self.maskLayer.addSublayer(layer)
        self.maskLayer.setNeedsDisplay()
        #endif
    }
    func setupCameraSession() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.high
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)else{
            delegate?.qrScannerDidFail(scanner: self, error: QRScannerError.invalidDevice)
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession?.addInput(input)
        } catch {
            print(error)
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        if captureSession!.canAddOutput(videoOutput) {
            captureSession?.addOutput(videoOutput)
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        }
        
        let metaOutput = AVCaptureMetadataOutput()
        if captureSession!.canAddOutput(metaOutput) {
            captureSession?.addOutput(metaOutput)
            metaOutput.metadataObjectTypes = metaOutput.availableMetadataObjectTypes
            metaOutput.setMetadataObjectsDelegate(self, queue: metaDataQueue)
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: {[weak self] (noti) in
            guard let sf = self else{
                return
            }
            metaOutput.rectOfInterest = sf.previewLayer!.metadataOutputRectConverted(fromLayerRect: sf.squareView.frame)
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension QRScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate{
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let metadataDict = CMCopyDictionaryOfAttachments(allocator: nil, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
        guard let metadata = metadataDict as? [AnyHashable: Any],
              let exifMetadata = metadata[kCGImagePropertyExifDictionary as String] as? [AnyHashable: Any],
              let brightness = exifMetadata[kCGImagePropertyExifBrightnessValue as String] as? NSNumber,
              let device = AVCaptureDevice.default(for: AVMediaType.video),device.hasTorch else{
            return
        }
        DispatchQueue.main.async {[weak self] in
            if self?.torchItem.isSelected == true{
                self?.torchItem.isHidden = false
            }else{
                self?.torchItem.isHidden = brightness.floatValue > 0
            }
        }
    }
}

extension QRScannerViewController:AVCaptureMetadataOutputObjectsDelegate{
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let obj = metadataObjects.first,
              let resultObj = previewLayer?.transformedMetadataObject(for: obj) as? AVMetadataMachineReadableCodeObject,
              let result = resultObj.stringValue else{
            return
        }
        captureSession?.stopRunning()
        playAlertSound()
        DispatchQueue.main.async {[weak self] in
            guard let sf = self else{
                return
            }
            sf.drawRect(resultObj: resultObj)
            sf.squareView.stopAnimation()
            sf.delegate?.qrScannerDidSuccess(scanner: sf, result: result)
        }
    }
}

extension QRScannerViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
              let ciImage = CIImage(image: image),
              let detector:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]) else{
            return
        }
        let features = detector.features(in:ciImage)
        if let feature = features.first as? CIQRCodeFeature,let result = feature.messageString{
            delegate?.qrScannerDidSuccess(scanner: self, result: result)
        }
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
