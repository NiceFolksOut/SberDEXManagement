//
// Created by Timofey on 2/18/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation
import SwiftyJSON
import secp256k1_ios
import CryptoSwift

final class WealthManagementProcedure: RemoteProcedure {

    init() {}

    func call() throws -> SwiftyJSON.JSON {
        let network = KovanInfuraNetwork(apiKey: "3O4Ywm6wGFgpIn8G10TT")

        let nonce = Data(
            integer: UInt(
                (try EthTransactions(
                    transactionsCountProcedure: GetTransactionsCountProcedure(
                        network: network,
                        address: SimpleAddress(value: "0x7b8e03Ab8Ef7b29be1b6591118ED6A8716e90e01"),
                        blockChainState: PendingBlockChainState()
                    )
                ).count() )
            ).bigEndian
        ).droppingLeadingZeroes()

        let rlps: [RLP] = [
            SimpleRLP(
                bytes: nonce
            ),
            SimpleRLP(
                bytes: Data(
                    hexString: "0x3b9aca00"
                )
            ),
            SimpleRLP(
                bytes: Data(
                    hexString: "0x2625a0"
                )
            ),
            SimpleRLP(
                bytes: Data()
            ),
            SimpleRLP(
                bytes: Data()
            ),
            SimpleRLP(
//                bytes: Data()
                bytes: Data(hexString: "0x6060604052336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550341561004f57600080fd5b604051604080610dc38339810160405280805190602001909190805190602001909190505081600260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080600360006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505050610cbc806101076000396000f3006060604052600436106100ba576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806313af4035146100bf5780631758078b146100f85780631f0ba6c91461014d5780632e1a7d4d14610162578063323a5e0b146101855780637762df25146101ae5780638da5cb5b14610203578063a6b909e114610258578063b6b55f2514610281578063d5d1e770146102a4578063d9510215146102b9578063e5a6b10f146102e2575b600080fd5b34156100ca57600080fd5b6100f6600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091905050610337565b005b341561010357600080fd5b61010b61048e565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561015857600080fd5b6101606104b4565b005b341561016d57600080fd5b6101836004808035906020019091905050610575565b005b341561019057600080fd5b610198610824565b6040518082815260200191505060405180910390f35b34156101b957600080fd5b6101c161082a565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561020e57600080fd5b610216610850565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561026357600080fd5b61026b610875565b6040518082815260200191505060405180910390f35b341561028c57600080fd5b6102a2600480803590602001909190505061087b565b005b34156102af57600080fd5b6102b7610a6a565b005b34156102c457600080fd5b6102cc610c46565b6040518082815260200191505060405180910390f35b34156102ed57600080fd5b6102f5610c4c565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561039257600080fd5b7f8a95addc59dddee94a894365b5c66c6c2473b7084d3fd1df9f503db4a2cd6dcc6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1682604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019250505060405180910390a180600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050565b600360009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16148061055c5750600360009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16145b151561056757600080fd5b600160065401600681905550565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156105d257600080fd5b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166370a08231306000604051602001526040518263ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050602060405180830381600087803b151561069757600080fd5b6102c65a03f115156106a857600080fd5b5050506040518051905090508181101515156106c357600080fd5b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a9059cbb6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff16846000604051602001526040518363ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200182815260200192505050602060405180830381600087803b15156107b157600080fd5b6102c65a03f115156107c257600080fd5b5050506040518051905015156107d757600080fd5b6107e360055483610c72565b6005819055507f0b9902d0034ddfc952780845244566bd6ed8256f0adf511407b391c4e5cadb06826040518082815260200191505060405180910390a15050565b60045481565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60065481565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156108d657600080fd5b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166323b872dd6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1630846000604051602001526040518463ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018281526020019350505050602060405180830381600087803b15156109f857600080fd5b6102c65a03f11515610a0957600080fd5b505050604051805190501515610a1e57600080fd5b610a2a60045482610c72565b6004819055507fa1ab46d0e38f33a7b1f03853088a305927deb55c906370ff5d6d2bc732f15095816040518082815260200191505060405180910390a150565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16141515610ac657600080fd5b7f70aea8d848e8a90fb7661b227dc522eb6395c3dac71b63cb59edd5c9899b23646000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019250505060405180910390a1600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff166000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506000600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550565b60055481565b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000808284019050838110151515610c8657fe5b80915050929150505600a165627a7a723058209e68c9be53d7a326387517b86e03a62bd8f7ec09442e81cd3889dbc83c3ab9d10029000000000000000000000000138051fd239c5798d6ddc7157196506695379d0a000000000000000000000000e35d276812001e33e3a8f6f445e2d1e90ff86f1c")
            )
        ]

        let replayStubs: [RLP] = [
            SimpleRLP(
                bytes: Data(
                    hexString: "0x2a"
                )
            ),
            SimpleRLP(
                bytes: Data()
            ),
            SimpleRLP(
                bytes: Data()
            )
        ]

        let signature = SECP256k1Signature(
            privateKey: Data(
                hexString: "0xb0047b5a622f9e22732ccac454abbb32dff1d1f13de378c877326d85f740cc7e"
            ).map{$0},
            message: try SimpleRLP(
                rlps: rlps + replayStubs
            ).toData().map{$0},
            hashFunction: SHA3(variant: .keccak256).calculate
        )

        let value = try SimpleRLP(
            rlps: rlps + [
                SimpleRLP(
                    bytes: Data(
                        integer: UInt(try 0x77 + signature.recoverID()).bigEndian
                    ).droppingLeadingZeroes()
                ),
                SimpleRLP(
                    bytes: try signature.r()
                ),
                SimpleRLP(
                    bytes: try signature.s()
                )
            ]
        ).toData().toHexString().addingHexPrefix()

        let json = try JSON(
            data: network.call(
                method: "eth_sendRawTransaction",
                params: [
                    StringParameter(
                        value: value
                    )
                ]
            )
        )
        return json
    }
}