//
//  QRScannerView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

/*import SwiftUI
import AVFoundation

struct QRScannerView: View {
    @Binding var scannedResult: String
    @State private var isScanning = true
    @State private var captureSession = AVCaptureSession()
    @State private var previewLayer: AVCaptureVideoPreviewLayer?

    var body: some View {
        ZStack {
            // ✅ Camada da Câmera com Preview direto via SwiftUI
            CameraPreviewLayer(session: $captureSession)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                if isScanning {
                    Text("🔎 Scan the QR Code")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            setupScanner()
        }
        .onDisappear {
            stopSession()
        }
    }

    // ✅ Configuração Inicial do Scanner
    func setupScanner() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("❌ Erro ao acessar a câmera: \(error.localizedDescription)")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(makeCoordinator(), queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }

        captureSession.startRunning()
    }

    // ✅ Para a sessão quando sai da tela
    func stopSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    // ✅ Coordenador para processar QR Code
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    // ✅ Lida com dados escaneados
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScannerView

        init(parent: QRScannerView) {
            self.parent = parent
        }

        // ✅ Processa o QR Code detectado
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
                  let scannedValue = metadataObject.stringValue else { return }

            DispatchQueue.main.async {
                self.parent.scannedResult = scannedValue
                self.parent.isScanning = false
                self.parent.stopSession()
            }
        }
    }
}

// ✅ Camada da Câmera sem UIView
struct CameraPreviewLayer: View {
    @Binding var session: AVCaptureSession

    var body: some View {
        CameraLayer(session: session)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
    }
}

// ✅ Camada personalizada para AVCaptureSession sem UIView
struct CameraLayer: UIViewControllerRepresentable {
    var session: AVCaptureSession

    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.session = session
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

// ✅ Controlador Customizado para Mostrar Câmera
class CameraViewController: UIViewController {
    var session: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ Camada de Pré-visualização
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
}
*/

























/*import SwiftUI
import AVFoundation
import UIKit

struct QRScannerView: UIViewControllerRepresentable {
    @Binding var scannedResult: String
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRScannerView
        
        init(parent: QRScannerView) {
            self.parent = parent
        }
        
        // ✅ Método chamado ao detectar o QR Code
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
               let stringValue = metadataObject.stringValue {
                parent.scannedResult = stringValue
            }
        }
    }
    
    // ✅ Criação da câmera para escanear QR Code
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return viewController
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return viewController
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return viewController
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        return viewController
    }
    
    // ✅ Atualiza a visualização
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    // ✅ Criando coordenador para lidar com metadados
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
*/
