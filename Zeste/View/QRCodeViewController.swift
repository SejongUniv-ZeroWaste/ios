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

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    // real db
    var ref : DatabaseReference!
    
    let qrIV = UIImageView()
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
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        qrIV.layer.borderWidth = 2
        qrIV.layer.borderColor = UIColor.red.cgColor
        self.view.bringSubviewToFront(qrIV)
        
        session.startRunning()
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
                    self.presentAlert(title: "적립완료") { [self] action in
                        let userID = Auth.auth().currentUser?.uid ?? ""
                        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                            for child in snapshot.children {
                                let snap = child as! DataSnapshot
                                print(snap)
                                let value = snap.value as? NSDictionary
                                var tmpStamp = value?["points"] as? Int ?? 0
                                tmpStamp += 1
                                self.ref.child("users").child(userID).updateChildValues(["points":tmpStamp])
                                //print(self.myStampCnt)
                                self.navigationController?.popViewController(animated: false)
                            }
                        }) { (error) in
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            } else {
                self.presentAlert(title: "올바른 qr 코드를 찍어주세요")
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

