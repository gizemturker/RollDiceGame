//
//  ViewController.swift
//  RollDiceGame
//
//  Created by Gizem Turker on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    
  
    @IBOutlet weak var lblOyuncu1Skor: UILabel!
    @IBOutlet weak var lblOyuncu2Skor: UILabel!
    @IBOutlet weak var lblOyuncu1Puan: UILabel!
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    @IBOutlet weak var imgOyuncu1Durum: UIImageView!
    @IBOutlet weak var imgOyuncu2Durum: UIImageView!
    @IBOutlet weak var imgZar1: UIImageView!
    @IBOutlet weak var imgZar2: UIImageView!
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0 , ikinciOyuncuPuani : 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru : 0 , ikinciOyuncuSkoru : 0)
    var oyuncuSira : Int = 1
    
    
    var maxSetSayisi : Int = 5
    var suankiSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let arkaPlan = UIImage(named: "arkaPlan") {
            self.view.backgroundColor = UIColor(patternImage: arkaPlan)
        }
        
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if suankiSet > maxSetSayisi {
            return
        }
        
        zarDegerleriniUret()
    }
    func setSonucu(zar1 : Int , zar2 : Int) {
        
        if oyuncuSira == 1 {
            
            oyuncuPuanlari.birinciOyuncuPuani = zar1 + zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.birinciOyuncuPuani)
            imgOyuncu1Durum.image = UIImage(named: "bekle")
            imgOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2. oyuncuda!"
            oyuncuSira = 2
            lblOyuncu2Puan.text = "0"
            
        } else {
            oyuncuPuanlari.ikinciOyuncuPuani = zar1 + zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.ikinciOyuncuPuani)
            imgOyuncu1Durum.image = UIImage(named: "onay")
            imgOyuncu2Durum.image = UIImage(named: "bekle")
            oyuncuSira = 1
            
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuani {
                
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 1. oyuncu kazandı!"
                
                suankiSet += 1
                lblOyuncu1Skor.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
            } else if oyuncuPuanlari.ikinciOyuncuPuani > oyuncuPuanlari.birinciOyuncuPuani {
                
                oyuncuSkorlari.ikinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 2. oyuncu kazandı!"
                suankiSet += 1
                lblOyuncu2Skor.text = String(oyuncuSkorlari.ikinciOyuncuSkoru)
            } else {
                lblSetSonucu.text = "\(suankiSet). Set berabere kaldı."
            }
            
            oyuncuPuanlari.birinciOyuncuPuani = 0
            oyuncuPuanlari.ikinciOyuncuPuani = 0
        }
        
    }
    func zarDegerleriniUret() {
        
        let zar1 = arc4random_uniform(6) + 1
        let zar2 = arc4random_uniform(6) + 1
        
        imgZar1.image = UIImage(named: String(zar1))
        imgZar2.image = UIImage(named: String(zar2))
        
        setSonucu(zar1: Int(zar1) , zar2: Int(zar2))
        
        
        if suankiSet > maxSetSayisi {
            
            if oyuncuSkorlari.birinciOyuncuSkoru > oyuncuSkorlari.ikinciOyuncuSkoru {
                
                lblSetSonucu.text = "Oyunun galibi 1. oyuncu!"
            } else {
                lblSetSonucu.text = "Oyunun galibi 2. oyuncu!"
            }
                
                
        }
        
    }
    
}

