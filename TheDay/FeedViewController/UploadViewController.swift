//
//  UploadViewController.swift
//  TheDay
//
//  Created by 이석원 on 2022/10/08.
//

import UIKit
import SnapKit

final class UploadViewController : UIViewController {
    private let uploadImage : UIImage
    private let imageView = UIImageView()
    

    private lazy var titleTextField : UITextField = {
        let titleTextField = UITextField()
        titleTextField.font = .systemFont(ofSize: 20.0)
        titleTextField.text = "내용 입력"
        titleTextField.textColor = .secondaryLabel
        titleTextField.delegate = self
        
        
        return titleTextField
    }()
    
    private lazy var dateTextField : UITextField = {
        let dateTextField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        dateTextField.text = " "
        dateTextField.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height - 100)


        return dateTextField
    }()
    
    private lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.cornerRadius = 5.0
        datePicker.layer.shadowOpacity = 0.5
        datePicker.datePickerMode = .date

        datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        
        return datePicker
    }()
    
    @objc func onDidChangeDate(sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.dateTextField.text = selectedDate
    }
    
    
    
    
    //uploadImage
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavigationItem()
        setupLayout()
        
        imageView.image = uploadImage
    }
}

//placeHolder
extension UploadViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ titleTextField: UITextField) {
        guard titleTextField.textColor == .secondaryLabel else { return }
        
        titleTextField.text = nil
        titleTextField.textColor = .label
        
    }
}

private extension UploadViewController {
    func setupNavigationItem() {
        navigationItem.title = "새 게시물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소", style: .plain, target: self, action: #selector(didTapLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장", style: .plain, target: self, action: #selector(didTapRightBarButton))
    }
    
    @objc func didTapLeftBarButton() {
        dismiss(animated: true)
    }
    @objc func didTapRightBarButton() {
    //TODO: 저장하기.
        dismiss(animated: true)
    }

    //UI
    func setupLayout() {
        [ imageView, titleTextField, dateTextField, datePicker].forEach { view.addSubview($0)}
        
        let imageViewInset : CGFloat = 16.0
        
        imageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.width.equalTo(300.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleTextField.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        datePicker.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.top)
            $0.leading.equalTo(dateTextField.snp.trailing).offset(100.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}

