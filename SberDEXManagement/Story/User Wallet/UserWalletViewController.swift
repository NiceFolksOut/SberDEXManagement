//
//  ViewController.swift
//  SberDEXManagement
//
//  Created by Timofey on 2/17/18.
//  Copyright © 2018 NFO. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class UserWalletViewController: UIViewController {
    
    enum WalletItems {
        case sberCoinAccount(Wallet)
        case portfolioLabel()
        case activePosition(ActivePosition)
        case historyLabel()
        case transaction(Transaction)
        case addTrust()
    }
    
    private let disposeBag = DisposeBag()
    
    private var userSubject = PublishSubject<User>()
    
    private var depositeSubject = PublishSubject<Void>()
    
    let tableView: StandardTableView = StandardTableView()
    
    private var user: User
    init(with user: User) {
        self.user = user

        super.init(nibName: nil, bundle: nil)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.separatorStyle = .none
        
        let dataSource = RxTableViewSectionedReloadDataSource<StandardSectionModel<WalletItems>>(configureCell: { ds, tv, ip, item in
            switch item {
            case let .sberCoinAccount(wallet):
                return tv.dequeueReusableCellOfType(SberCoinCell.self, for: ip).setuped(with: wallet, subject: { self.depositeSubject }())
            case .addTrust:
                return tv.dequeueReusableCellOfType(AddTrustAccountCell.self, for: ip)
            case .portfolioLabel():
                return tv.dequeueReusableCellOfType(PortfolioTitleCell.self, for: ip)
            case let .activePosition(activePosition):
                return tv.dequeueReusableCellOfType(ActivePositionCell.self, for: ip).setuped(with: activePosition)
            case .historyLabel:
                return tv.dequeueReusableCellOfType(HistoryTitleCell.self, for: ip)
            case let .transaction(transaction):
                return tv.dequeueReusableCellOfType(TransactionCell.self, for: ip).setuped(with: transaction)
            }
        })

        userSubject.asObservable()
            .flatMap { user -> Observable<[StandardSectionModel<WalletItems>]> in
            var items = [WalletItems]()
            if let account = user.trustAccount() {
                items =
                    [WalletItems.portfolioLabel()] +
                    account.portfolio.map { WalletItems.activePosition($0) } +
                    [WalletItems.historyLabel()] +
                    account.history.map { WalletItems.transaction($0) }
                
            } else {
                items = [WalletItems.addTrust()]
            }

            return Observable.just(
                [WalletItems.sberCoinAccount(user.sbercoinWallet())] + items
                )
                .map {
                    [StandardSectionModel<WalletItems>(items: $0)]
                }
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(WalletItems.self).subscribe(onNext: {
            switch $0 {
            case .addTrust():
                self.navigationController?.pushViewController(CreateTrustViewController(), animated: true)
            default:
                return
            }
        }).disposed(by: disposeBag)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Кошелёк"
        depositeSubject = PublishSubject<Void>()
        depositeSubject.asObserver().subscribe(onNext: {
            self.navigationController?.pushViewController(MakeDepositViewContreller(), animated: true)
        }).disposed(by: disposeBag)
        userSubject.onNext(user)
        
        let item = UIBarButtonItem(title: "Вывести", style: .plain, target: nil, action: nil)
        item.rx.tap.asObservable().subscribe(onNext: {
            self.navigationController?.pushViewController(WithdrawViewController(), animated: true)
        }).disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = .algaeGreen

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
