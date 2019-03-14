//
//  LegalViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {

    @IBOutlet weak var textview:UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var message:String="\n"
        message=message+"株式会社スパークワークス（以下、「当社」といいます）は、この規約（以下、「本規約」といいます）に基づいて、"
        message=message+"「中華グルメ」サービス（以下、「本サービス」といいます）を提供いたします。\n"
        message=message+"\n"
        message=message+"本サービスのコンテンツ（以下「コンテンツ」）は「中華グルメ」アプリ上に"
        message=message+"公開可能な形で提供される文字・画像・音声等の情報とダウンロード可能なアプリケーションや"
        message=message+"ドキュメント形式のファイルの一切を含みます。\n"
        message=message+"\n"
        message=message+"本サービス\n"
        message=message+"■本サービスの内容、品質、稼動状態、障害対処など一切の保証をいたしません。\n"
        message=message+"　何らの予告なくサービスの変更、または中止することがあります。\n"
        message=message+"■本サービスを使用すること、あるいは使用できないことに対し一切責任を負いません。\n"
        message=message+"■本サービスを使用するする際には利用者の自己の責任と費用により行って頂きます。\n"
        message=message+"■当社は、本サービスの利用に関し、起因して発生した損失や損害について、すべてに一切責任を負いません。\n"
        message=message+"\n"
        message=message+"コンテンツ\n"
        message=message+"■コンテンツは、何らの予告なく改変もしくは削除を行う事があります。\n"
        message=message+"■コンテンツの内容や信頼性、合法性に対して一切責任を負いません。\n"
        message=message+"■コンテンツを使用する際には利用者の自己の責任と費用により行って頂きます。\n"
        message=message+"■コンテンツの動作についていかなる保証もいたしません。\n"
        message=message+"■コンテンツがコンピュータ・ウイルスに感染していないことを保証しません。\n"
        message=message+"　また、万一コンテンツがコンピュータ・ウイルスに感染していた場合に対し一切責任を負いません。\n"
        message=message+"■当社は、上記のすべてに起因して発生した損失や損害について一切責任を負いません。\n"
        
        textview.text = message

        title = "利用規約"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
