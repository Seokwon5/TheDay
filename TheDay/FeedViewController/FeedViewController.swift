//
//  FeedViewController.swift
//  TheDay
//
//  Created by 이석원 on 2022/10/08.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    private var feedList: [Feed] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedViewControllerCell.self, forCellWithReuseIdentifier: "FeedViewControllerCell")
        
        
        return collectionView
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagepickerController = UIImagePickerController()
        imagepickerController.sourceType = .photoLibrary
        imagepickerController.allowsEditing = true
        imagepickerController.delegate = self
        
        return imagepickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        fetchData()
    }
}

//dataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedViewControllerCell", for: indexPath) as? FeedViewControllerCell
        let feed = feedList[indexPath.item]
        cell?.setup(feed: feed)
        
        return cell ?? UICollectionViewCell()
    }
   
}
    




extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = collectionView.frame.width - 32.0
        return CGSize(width: width, height: width)
    }
}

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { selectImage = editedImage

        }else  if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
            
        }
        picker.dismiss(animated: true) { [weak self] in
            let uploadViewController = UploadViewController(uploadImage: selectImage ?? UIImage())
            let navigationViewController = UINavigationController(rootViewController: uploadViewController)
            navigationViewController.modalPresentationStyle = .fullScreen
            
            self?.present(navigationViewController, animated: true)
        }
    }
}

private extension FeedViewController {
    func setupNavigationBar() {
        navigationItem.title = "TheDay"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(didTapUploadButton))
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc func didTapUploadButton() {
        present(imagePickerController, animated: true)
    }
}

private extension FeedViewController {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feed", withExtension: "plist") else {return}
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feed].self, from: data)
            feedList = result
            
        }catch{
            
        }
    }
}
