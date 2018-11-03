//
//  ProfileViewController.swift
//  SoFiCodeChallenge
//
//  Created by Tyler Clonts on 10/23/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileInfoLabel: UILabel!
    @IBOutlet weak var profileInfoTextView: UITextView!
    @IBOutlet weak var tabBarProfileUIView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    @IBOutlet weak var imageViewFour: UIImageView!
    @IBOutlet weak var imageViewSix: UIImageView!
    @IBOutlet weak var basicsButton: UIButton!
    @IBOutlet weak var preferencesButton: UIButton!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var mainViewXButton: UIButton!
    @IBOutlet weak var imageOneXButton: UIButton!
    @IBOutlet weak var imageTwoXButton: UIButton!
    @IBOutlet weak var imageThreeXButton: UIButton!
    @IBOutlet weak var imageFourXButton: UIButton!
    @IBOutlet weak var imageFiveXButton: UIButton!
    
    @IBAction func basicsButtonAction(_ sender: UIButton) {
        basicsButton.layer.borderWidth = 1.0
        basicsButton.backgroundColor = UIColor.white
        basicsButton.layer.borderColor = UIColor.SoFiBlue.cgColor
        basicsButton.setTitleColor(UIColor.SoFiBlue, for: .normal)
        
        photosButton.layer.borderWidth = 1.0
        photosButton.backgroundColor = UIColor.SoFiBlue
        photosButton.layer.borderColor = UIColor.white.cgColor
        photosButton.setTitleColor(UIColor.white, for: .normal)
        
        preferencesButton.layer.borderWidth = 1.0
        preferencesButton.backgroundColor = UIColor.SoFiBlue
        preferencesButton.layer.borderColor = UIColor.white.cgColor
        preferencesButton.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func preferencesButtonAction(_ sender: UIButton) {
        preferencesButton.layer.borderWidth = 1.0
        preferencesButton.backgroundColor = UIColor.white
        preferencesButton.layer.borderColor = UIColor.SoFiBlue.cgColor
        preferencesButton.setTitleColor(UIColor.SoFiBlue, for: .normal)
        
        basicsButton.layer.borderWidth = 1.0
        basicsButton.backgroundColor = UIColor.SoFiBlue
        basicsButton.layer.borderColor = UIColor.white.cgColor
        basicsButton.setTitleColor(UIColor.white, for: .normal)
        
        photosButton.layer.borderWidth = 1.0
        photosButton.backgroundColor = UIColor.SoFiBlue
        photosButton.layer.borderColor = UIColor.white.cgColor
        photosButton.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func photosButtonAction(_ sender: UIButton) {
        photosButton.layer.borderWidth = 1.0
        photosButton.backgroundColor = UIColor.white
        photosButton.layer.borderColor = UIColor.SoFiBlue.cgColor
        photosButton.setTitleColor(UIColor.SoFiBlue, for: .normal)
        
        basicsButton.layer.borderWidth = 1.0
        basicsButton.backgroundColor = UIColor.SoFiBlue
        basicsButton.layer.borderColor = UIColor.white.cgColor
        basicsButton.setTitleColor(UIColor.white, for: .normal)
        
        preferencesButton.layer.borderWidth = 1.0
        preferencesButton.backgroundColor = UIColor.SoFiBlue
        preferencesButton.layer.borderColor = UIColor.white.cgColor
        preferencesButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        //Create the UIImage Screen Shot
        guard let layer = UIApplication.shared.keyWindow?.layer else { return }
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        //Send email to SoFi tlawson@sofi.org

        let mailComposeVC = MFMailComposeViewController()
        guard let data = image.pngData() else { return }
        mailComposeVC.addAttachmentData(data, mimeType: "image/jpeg", fileName:  "test.jpeg")
        let tlawsonEmail = "tlawson@sofi.org"
        let cpratt = "cpratt@sofi.org"
        mailComposeVC.setToRecipients([tlawsonEmail, cpratt])
        
        mailComposeVC.setSubject("SoFi Code Challenge Result for Tyler Clonts")
        
        mailComposeVC.setMessageBody("<html><body><p>Thanks for taking the time to interview me. This challenge was a ton of fun! I would love to work for SoFi!</p></body></html>", isHTML: true)
        
        self.present(mailComposeVC, animated: true, completion: nil)

    }
    @IBAction func mainImageDeleteButtonTapped(_ sender: UIButton) {
        mainImageView.image = nil
    }
    @IBAction func imageOneDeleteButtonTapped(_ sender: UIButton) {
        imageViewOne.image = nil
    }
    @IBAction func imageTwoDeleteButtonTapped(_ sender: UIButton) {
        imageViewTwo.image = nil
    }
    @IBAction func imageThreeDeleteButtonTapped(_ sender: UIButton) {
        imageViewThree.image = nil
    }
    @IBAction func imageFourDeleteButtonTapped(_ sender: UIButton) {
        imageViewFour.image = nil
    }
    @IBAction func imageFiveDeleteButtonTapped(_ sender: UIButton) {
        imageViewSix.image = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.shared.fetchUser()
        imageAssigner()
        navigationBarSetUp()
        buttonSetupUI()
        bioSetter()
        longPressImageViewSetup()
        imageRoundSetup()
        
        view.backgroundColor = UIColor.SoFiBlue
        profileInfoTextView.isEditable = false
    
      
        
    }
    
    private func navigationBarSetUp() {
        
        navigationController?.navigationBar.barTintColor = UIColor.SoFiBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarProfileUIView.backgroundColor = UIColor.SoFiBlue
    }
    
    @objc func longPress() {
        mainViewXButton.isHidden = false
        imageOneXButton.isHidden = false
        imageTwoXButton.isHidden = false
        imageThreeXButton.isHidden = false
        imageFourXButton.isHidden = false
        imageFiveXButton.isHidden = false
    }
    
    func imageAssigner() {
        let avatarImages = UserController.shared.users.compactMap { $0.avatar}
        print(avatarImages)
        
        DispatchQueue.main.async() {
            self.mainImageView.downloaded(from: avatarImages[6], contentMode: .scaleToFill)
            self.imageViewOne.downloaded(from: avatarImages[1], contentMode: .scaleToFill)
            self.imageViewTwo.downloaded(from: avatarImages[2], contentMode: .scaleToFill)
            self.imageViewThree.downloaded(from: avatarImages[3], contentMode: .scaleToFill)
            self.imageViewFour.downloaded(from: avatarImages[7], contentMode: .scaleToFill)
            self.imageViewSix.downloaded(from: avatarImages[5], contentMode: .scaleToFill)
        }
    }
    
    func bioSetter() {
        let userBios = UserController.shared.users.compactMap { $0.bio }
        profileInfoTextView.text = userBios.randomElement()
    }
    
    func buttonSetupUI() {
        basicsButton.layer.borderWidth = 1.0
        basicsButton.layer.borderColor = UIColor.white.cgColor
        basicsButton.setTitleColor(UIColor.white, for: .normal)
        
        preferencesButton.layer.borderWidth = 1.0
        preferencesButton.layer.borderColor = UIColor.white.cgColor
        preferencesButton.setTitleColor(UIColor.white, for: .normal)
        
        photosButton.layer.borderWidth = 1.0
        photosButton.backgroundColor = UIColor.white
        photosButton.layer.borderColor = UIColor.SoFiBlue.cgColor
        photosButton.setTitleColor(UIColor.SoFiBlue, for: .normal)
        
        mainViewXButton.isHidden = true
        imageOneXButton.isHidden = true
        imageTwoXButton.isHidden = true
        imageThreeXButton.isHidden = true
        imageFourXButton.isHidden = true
        imageFiveXButton.isHidden = true
        
        mainViewXButton.layer.cornerRadius = mainViewXButton.layer.frame.size.width/2
        imageOneXButton.layer.cornerRadius = imageOneXButton.layer.frame.size.width/2
        imageTwoXButton.layer.cornerRadius = imageTwoXButton.layer.frame.size.width/2
        imageThreeXButton.layer.cornerRadius = imageThreeXButton.layer.frame.size.width/2
        imageFourXButton.layer.cornerRadius = imageFourXButton.layer.frame.size.width/2
        imageFiveXButton.layer.cornerRadius = imageFiveXButton.layer.frame.size.width/2
        
    }
    
    func longPressImageViewSetup() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        let longPressGestur = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        let longPressGestu = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        let longPressGest = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        let longPressGe = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressGesture.minimumPressDuration = 3.0
        
        mainImageView.addGestureRecognizer(longPressGesture)
        imageViewOne.addGestureRecognizer(longPressGestur)
        imageViewTwo.addGestureRecognizer(longPressGestu)
        imageViewThree.addGestureRecognizer(longPressGest)
        imageViewFour.addGestureRecognizer(longPressGes)
        imageViewSix.addGestureRecognizer(longPressGe)
    }
    
    func imageRoundSetup() {
        self.mainImageView.layer.cornerRadius = 12
        self.mainImageView.clipsToBounds = true
        
        self.imageViewOne.layer.cornerRadius = 12
        self.imageViewOne.clipsToBounds = true
        
        self.imageViewTwo.layer.cornerRadius = 12
        self.imageViewTwo.clipsToBounds = true
        
        self.imageViewThree.layer.cornerRadius = 12
        self.imageViewThree.clipsToBounds = true
        
        self.imageViewFour.layer.cornerRadius = 12
        self.imageViewFour.clipsToBounds = true
        
        self.imageViewSix.layer.cornerRadius = 12
        self.imageViewSix.clipsToBounds = true
    }
    
 
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



