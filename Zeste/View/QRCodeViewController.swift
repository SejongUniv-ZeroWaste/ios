//
//  QRCodeViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/26.
//

import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseDatabase

class QRCodeViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    // real db
    var ref : DatabaseReference!
    
    var qrArea:CGRect!
    
    let qrIV = UIImageView()
    var output = AVCaptureMetadataOutput()
    override func viewDidLoad() {
        initV()
        bindConstraints()
        
        // firebase reference 초기화
        ref = Database.database().reference()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Error capturing QRCode")
        }
        
        
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.frame = view.layer.bounds
//        view.layer.addSublayer(previewLayer)
        
  

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        view.layer.addSublayer(previewLayer)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = view.layer.bounds
        
        qrIV.layer.borderWidth = 5
        qrIV.layer.borderColor = UIColor.zestGreen.cgColor
        self.view.bringSubviewToFront(qrIV)
        let xP : CGFloat = (self.view.frame.width - 220)/2
        let yP : CGFloat = (self.view.frame.height - 220)/2
        qrArea = CGRect(x: xP , y: yP, width: 220, height: 220)
        session.startRunning()
        output.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: qrArea)
    }
}

extension QRCodeViewController {
    private func initV() {
        self.view.addSubview(qrIV)
    }
    private func bindConstraints(){
        qrIV.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(250)
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaDataObject = metadataObjects.first {
            guard let readableObject = metaDataObject as? AVMetadataMachineReadableCodeObject else {
                return
            }
            if readableObject.stringValue == "http://m.site.naver.com/0Ta6T" {
                self.session.stopRunning()
                if !session.isRunning {
                    showIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismissIndicator()
                    
                    self.presentAlert(title: "적립완료") { [self] action in
                        let userID = Auth.auth().currentUser?.uid ?? ""
                        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                            for child in snapshot.children {
                                let snap = child as! DataSnapshot
                                print(snap)
                                let value = snap.value as? NSDictionary
                                if value?["nick"] as! String == "miori" {
                                    var tmpStamp = value?["points"] as? Int ?? 0
                                    tmpStamp += 1
                                    self.ref.child("users").child(userID).updateChildValues(["points":tmpStamp])
                                }
                                //print(self.myStampCnt)
                                self.navigationController?.popViewController(animated: false)
                            }
                        }) { (error) in
                            print(error.localizedDescription)
                        }
                    }
                }
                    
                }
            } else {
                self.session.stopRunning()
                if !session.isRunning {
                    showIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismissIndicator()
                        self.presentAlert(title: "올바른 qr 코드를 찍어주세요") {
                            [self] action in
                            session.startRunning()
                        }
                    }
                }

            }
            
            //               let alert = UIAlertController(title: "QRCode 리딩 성공", message: readableObject.stringValue, preferredStyle: .actionSheet)
            //
            //               alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
            //                   self.session.startRunning()
            //               }))
            
            //              present(alert, animated: true, completion: nil)
        }
    }
}

