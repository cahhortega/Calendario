//
//  ViewController.swift
//  Calendario-storyboard
//
//  Created by Carolina Ortega on 15/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dom: UIButton!
    @IBOutlet weak var seg: UIButton!
    @IBOutlet weak var ter: UIButton!
    @IBOutlet weak var qua: UIButton!
    @IBOutlet weak var qui: UIButton!
    @IBOutlet weak var sex: UIButton!
    @IBOutlet weak var sab: UIButton!
    
    let diaDaSemanaAtual = Calendar.current.component(.weekday, from: Date())-1
    //Este é o valor que irá nos mostrar em que dia estamos (Ex: segunda, terça, etc).
    //O -1 é necessário para igualar as posições do dia com as posições dos botões no vetor
    
    var diaAtual = Calendar.current.component(.day, from: Date())
    //Dia atual (Ex: 1, 2, 31, etc).
    
    var mesAtual = Calendar.current.component(.month, from: Date())
    //Mês atual (Ex: Janeiro, Fevereiro, etc).
    //Esse valor é necessário para verificarmos o número de dias de cada mês
    
    var anoAtual = Calendar.current.component(.year, from: Date())
    //Ano atual (Ex: 2022)
    //Esse valor é necessário para verificarmos se o ano é bissexto ou não
    
    lazy var dias: [UIButton] = [dom, seg, ter, qua, qui, sex, sab]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dias[diaDaSemanaAtual].backgroundColor = UIColor.systemTeal
        dias[diaDaSemanaAtual].titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        calendario()
    }
    
    func calendario() {
        var diaDepois = diaAtual
        var diaAntes = diaAtual
        
        for dia in diaDaSemanaAtual ... 6 { //Para saber qual é o próximo dia
            dias[dia].setTitle("\(diaDepois)", for: .normal)
            switch mesAtual {
            case 1, 3, 5, 7, 8, 10, 12: //Meses com 31 dias
                if diaDepois == 31 {
                    diaDepois = 1
                } else {
                    diaDepois += 1
                }
                
            case 4, 6, 9, 11: //Meses com 30 dias
                if diaDepois == 30{
                    diaDepois = 1
                } else {
                    diaDepois += 1
                }
                
            case 2: //Fevereiro (exceção)
                if anoAtual % 4 == 0 { //Para saber se o ano é bissexto
                    if diaDepois == 29 {
                        diaDepois = 1
                    } else {
                        diaDepois += 1
                    }
                } else {
                    if diaDepois == 28 {
                        diaDepois = 1
                    } else {
                        diaDepois += 1
                    }
                }
                
            default:
                break
            }
        }
        for dia in (0 ... diaDaSemanaAtual-1).reversed() { //Para saber qual é o dia anterior
            switch mesAtual {
            case 1, 2, 4, 6, 8, 9, 11: //Meses que antecedem um mês de 31 dias
                if diaAntes == 1 {
                    diaAntes = 31
                } else {
                    diaAntes -= 1
                }
            case 5, 7, 10, 12: //Meses que antecedem um mês de 30 dias
                if diaAntes == 1 {
                    diaAntes = 30
                } else {
                    diaAntes -= 1
                }
            case 3: //Março (exceção)
                if diaAntes == 1 {
                    if anoAtual % 4 == 0 { //Para saber se o ano é bissexto
                        diaAntes = 29
                    } else {
                        diaAntes = 28
                    }
                } else {
                    diaAntes -= 1
                }
                
            default:
                break
            }
            dias[dia].setTitle("\(diaAntes)", for: .normal)
        }
    }
}
