//
//  SongDetailsView.swift
//  iMusic
//
//  Created by SOUMEN GHOSH on 15/3/18.
//  Copyright © 2018 Sg106. All rights reserved.
//

import UIKit
import AVKit

class SongDetailsView: UIViewController, UIWebViewDelegate, PayPalPaymentDelegate {
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
            paymentViewController.dismiss(animated: true, completion: { () -> Void in
        })
    }
    
    var imageUrl: String?
    var songDetailsName: String?
    var songArtistName: String?
    var priceAmount: String?
    var priceCurrency: String?
    var videoURLgot: String?
    
    func getImageURL(url: String, songName: String, artistName: String, price: String, currency: String, videoURL: String){
        imageUrl = url
        songDetailsName = songName
        songArtistName = artistName
        priceAmount = price
        priceCurrency = currency
        videoURLgot = videoURL
    }
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    var payPalConfig = PayPalConfiguration()
    
    let songImage: CustomImageView = {
        let im = CustomImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.layer.cornerRadius = 10
        im.layer.masksToBounds = true
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    let songName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 22)
        lb.numberOfLines = 0
//        lb.backgroundColor = .blue
        lb.textAlignment = .center
        return lb
    }()
    
    let artistName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 20)
        lb.numberOfLines = 0
//        lb.backgroundColor = .green
        lb.textAlignment = .center
        return lb
    }()
    
    let price: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 20)
        lb.numberOfLines = 0
//        lb.backgroundColor = .red
        lb.textAlignment = .right
        return lb
    }()
    
    let currency: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "Times New Roman", size: 20)
        lb.numberOfLines = 0
//        lb.backgroundColor = .red
        lb.textAlignment = .left
        return lb
    }()
    
    let showButt: UIButton = {
        let butt = UIButton()
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Hit for Video", for: .normal)
        butt.backgroundColor = UIColor.gray
        butt.titleLabel?.textColor = .white
        butt.layer.cornerRadius = 5
        butt.layer.masksToBounds = true
        butt.addTarget(self, action: #selector(videoButt), for: .touchUpInside)
        return butt
    }()
    
    @objc func videoButt() {
        guard let myURL = videoURLgot else {return}
//        print(myURL)
        guard let videoURL = URL(string: myURL) else {return}
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    let openURLButt: UIButton = {
        let butt = UIButton()
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Hit for Open URL", for: .normal)
        butt.backgroundColor = UIColor.gray
        butt.titleLabel?.textColor = .white
        butt.layer.cornerRadius = 5
        butt.layer.masksToBounds = true
        butt.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        return butt
    }()
    
    let imageGIF: UIImageView = {
        let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        //im.image = #imageLiteral(resourceName: "myDP")
        im.layer.masksToBounds = true
        im.contentMode = .scaleAspectFit
        im.layer.cornerRadius = 5
        return im
    }()
    
    
    @objc func openURL() {
        let vc = OpenURLView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func getEverything(image: String, songName: String, artistName: String, price: String, currency: String) {
        self.songImage.loadImage(urlString: image.replacingOccurrences(of: "133x100bb", with: "1330x1000bb"))
        self.songName.text = songName
        self.artistName.text = artistName
        self.price.text = price
        self.currency.text = currency
    }
    
    func runGif() {
        imageGIF.loadGif(name: "mygif")
    }
    
    func setup() {
        view.backgroundColor = .white
        setupNav()
        runGif()
        setupImage()
        setupSongName()
        setupArtistName()
        setupPrice()
        setupCurrency()
        setupButt()
        setupOpenURLButt()
        setupGif()
        getEverything(image: imageUrl!, songName: songDetailsName!, artistName: songArtistName!, price: priceAmount!, currency: priceCurrency!)
        
        setupPayPal()
    }
    
    func setupNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Buy Now", style: .plain, target: self, action: #selector(buttHit))
        navigationItem.title = "Item"
    }
    
    @objc func buttHit() {
        
        let price = priceAmount?.dropFirst()
        let newPrice: String = "\(price ?? "")"

        let item = PayPalItem(name: songDetailsName!, withQuantity: 1, withPrice: NSDecimalNumber(string: newPrice), withCurrency: priceCurrency!, withSku: "KJ34IO34A")
        
        let items = [item]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: priceCurrency!, shortDescription: "soumen-IT.com", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        payment.currencyCode = priceCurrency!
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // error in payment
            print("Payment not processalbe: \(payment)")
        }
        
    }
    
    func setupPayPal() {
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Sg106 Co."
        
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .both
    }
    
    func setupImage() {
        view.addSubview(songImage)
        songImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        songImage.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        songImage.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
    }
    
    func setupSongName() {
        view.addSubview(songName)
        songName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        songName.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: 5).isActive = true
        songName.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        songName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupArtistName() {
        view.addSubview(artistName)
        artistName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistName.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 5).isActive = true
        artistName.widthAnchor.constraint(equalToConstant: view.frame.width - 10).isActive = true
        artistName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupPrice() {
        view.addSubview(price)
        price.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        price.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 5).isActive = true
        price.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 10).isActive = true
    }
    
    func setupCurrency() {
        view.addSubview(currency)
        currency.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        currency.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 5).isActive = true
        currency.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 10).isActive = true
    }
    
    func setupButt() {
        view.addSubview(showButt)
        showButt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showButt.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: 5).isActive = true
        showButt.widthAnchor.constraint(equalToConstant: 150).isActive = true
        showButt.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupOpenURLButt() {
        view.addSubview(openURLButt)
        openURLButt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openURLButt.topAnchor.constraint(equalTo: showButt.bottomAnchor, constant: 5).isActive = true
        openURLButt.widthAnchor.constraint(equalToConstant: 150).isActive = true
        openURLButt.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupGif() {
        view.addSubview(imageGIF)
        imageGIF.topAnchor.constraint(equalTo: openURLButt.bottomAnchor, constant: 5).isActive = true
        imageGIF.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        imageGIF.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        imageGIF.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
}
















