//
//  ViewController.swift
//  Ejercicio 1
//
//  Created by DISMOV on 14/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var internetMonitor = InternetMonitor()
    var image: UIImageView!
    var actI: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        image = UIImageView(frame: view.bounds.insetBy(dx: 0, dy: 100))
        image.contentMode = .scaleAspectFit
        self.view.addSubview(image)
        
        actI = UIActivityIndicatorView()
        actI.center = view.center
        self.view.addSubview(actI)
        actI.hidesWhenStopped = true
        actI.style = .large
        
        let btn = UIButton(frame: CGRect(x: view.frame.maxX-100, y: view.frame.maxY-160, width: 90, height: 44))
        self.view.addSubview(btn)
        btn.setTitle("abrir en safari", for: .normal)
        btn.titleLabel?.font = UIFont(coder: <#T##NSCoder#>)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(btnTouch), for: .touchUpInside)
    }
    
    @objc func btnTouch() {
        let urlStr = "https://fundacionunam.org/cei/assets/img/unam.jpg"
        if let url = URL(string: urlStr) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if internetMonitor.isConnected {
            //Si hay conexión a internet, descarga la imagen
            let urlStr = "https://fundacionunam.org/cei/assets/img/unam.jpg"
            if let url = URL(string: urlStr){
                self.actI.startAnimating()
                /*let datos = try Data(contentsOf: url)
                image.image = UIImage(data: datos)*/
                let request = URLRequest(url: url)
                let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
                let task = session.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        self.actI.stopAnimating()
                        if error == nil {
                            // todo ok, cargar la imagen en el imageview
                            self.image.image = UIImage(data: data!)
                        }
                    }
                }
                task.resume()
            }
//            image.image = UIImage(systemName: "apple.logo")
        } else {
            image.image = UIImage(systemName: "wifi.exclamationmark")
        }
    }


}

