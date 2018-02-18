//
// Created by Timofey on 1/30/18.
// Copyright (c) 2018 Jufy. All rights reserved.
//

import Foundation
import SnapKit
import RxSwift

//FIXME: This needs a proper selection object, similar to SwitchableSelectionView
final class SegmentControl<SelectionType>: UIView {

    //FIXME: This should be implemented with media and protocols
    struct Segment<SegmentType> {

        let title: String
        let item: SegmentType

    }

    private final class SegmentView<SegmentType>: UIView {

        let selected: Observable<Void>

        let segment: Segment<SegmentType> //FIXME: This is bad

        private var deselected = PublishSubject<Void>()
        private var selectedExternaly = PublishSubject<Void>()
        private var disposeBag = DisposeBag()
        init(segment: Segment<SegmentType>) {
            self.segment = segment
            let tapGR = UITapGestureRecognizer()
            let titleLabel = UILabel().with(
                text: SimpleText(
                    string: segment.title,
                    font: .systemFont(ofSize: 18, weight: .bold),
                    color: .sbrWhite
                )
            )
            selected = Observable.merge([tapGR.rx.event.map{  _ in () },
                                         selectedExternaly])
                .do(onNext: { titleLabel.textColor = .warmGrey })
            deselected.subscribe(onNext: {
                titleLabel.textColor = .sbrWhite
            })
            .disposed(by: disposeBag)
            super.init(frame: .zero)
            addGestureRecognizer(tapGR)


            addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        
        func deselect() {
            deselected.onNext({}())
        }
        
        func select() {
            selectedExternaly.onNext({}())
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }

    }

    private(set) lazy var selected: Observable<SelectionType> = self.selectionSubject.asObservable()
    private let selectionSubject = ReplaySubject<SelectionType>.create(bufferSize: 1)

    private let segmentsLayoutStackView = HorizontalStackView().with(distribution: .fillEqually)
    private let selectionView = UIView().with(backgroundColor: .algaeGreen)

    init() {
        super.init(frame: .zero)
        addSubview(segmentsLayoutStackView)
        segmentsLayoutStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        addSubview(selectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private var disposeBag = DisposeBag()
    func configure(with segments: [Segment<SelectionType>]) {
        disposeBag = DisposeBag()
        segmentsLayoutStackView.clear()
        let segmentViews = segments.map{
            SegmentView(
                segment: $0
            )
        }
        segmentsLayoutStackView.addArrangedSubviews(segmentViews)

        Observable.merge(
            segmentViews.map{ view in
                view.selected.map{ _ in
                    view
                }
            } + [
                Observable.just(segmentViews.first)
                    .filter{ $0 != nil }
                    .map{ $0! }
            ]
        ).subscribe(
            onNext: { [unowned self] view in
                self.selectionSubject.on(.next(view.segment.item))
                segmentViews
                    .filter {
                        $0.segment.title != view.segment.title
                    }
                    .forEach {
                        $0.deselect()
                }
                self.selectionView.snp.remakeConstraints{
                    $0.height.equalTo(3)
                    $0.leading.trailing.bottom.equalTo(view)
                }
                
                self.segmentsLayoutStackView.setNeedsLayout()
                self.segmentsLayoutStackView.layoutIfNeeded()
                UIView.animate(
                    withDuration: 0.3,
                    animations: { [unowned self] in
                        self.layoutIfNeeded()
                    }
                )
            })
            .disposed(by: disposeBag)
        segmentViews.first?.select()
        
    }

    func configured(with segments: [Segment<SelectionType>]) -> Self {
        self.configure(with: segments)
        return self
    }

}
