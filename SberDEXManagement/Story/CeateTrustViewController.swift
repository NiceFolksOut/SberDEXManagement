//
//  CeateTrustViewController.swift
//  SberDEXManagement
//
//  Created by Артмеий Шлесберг on 17/02/2018.
//  Copyright © 2018 NFO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CreateTrustViewController: UIViewController {
    
    var textField = UITextField()
    .with(placeholder: "SR")
    .with(font: .systemFont(ofSize: 35, weight: .bold))
    .withBottomBorder()
    
    var sumLabel  = StandardLabel(font: .systemFont(ofSize: 13, weight: .medium), textColor: .warmGrey, text: "Сумма перевода")
    
    private var addButton = StandardRoundEdgeButton()
        .with(font: .systemFont(ofSize: 18, weight: UIFont.Weight.bold))
        .with(title: "Создать")
        .with(titleColor: .white)
        .with(backgroundColor: .algaeGreen)
    
    private var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        textField.textColor = .algaeGreen
        
        let segmentControl = SegmentControl().configured(
            with: [
                SegmentControl.Segment<UIView>(
                    title: "Стратегия 1",
                    item: UIView()
                ),
                SegmentControl.Segment<UIView>(
                    title: "Стратегия 2",
                    item: UIView()
                ),
                SegmentControl.Segment<UIView>(
                title: "Стратегия 3",
                item: UIView()
                )
            ]
            ).with(backgroundColor: .white)
        view.addSubviews([textField, sumLabel, addButton, segmentControl])

        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(183)
        }
        sumLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints{
            $0.top.equalTo(sumLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(45)
            $0.top.equalTo(segmentControl.snp.bottom).offset(42)
        }

        addButton.rx.tap.subscribe(onNext: {
            if let text = self.textField.text,
                let amount = Float(text),
                let _ = try? UserTrusts.shared.add(from: SbercoinWallet.shared, with: amount) {
                self.navigationController?.popViewController(animated: true)
            }
        })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cоздать счет"
        self.navigationController?.navigationBar.tintColor = .algaeGreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
